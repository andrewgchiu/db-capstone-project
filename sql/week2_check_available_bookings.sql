-- Task 1
-- Add 4 records using simple INSERT statements
-- TODO: Adjust for extra columns in bookings table

INSERT INTO bookings (BookingID, BookingDate, TableNumber, CustomerID)
VALUES
(1, '2022-10-10', 5, 1),
(2, '2022-11-12', 3, 3),
(3, '2022-10-11', 2, 2),
(4, '2022-10-13', 2, 1);

INSERT INTO bookings
VALUES
(1, '2022-10-10', 5, 1, 0, 0, 0, 0, 0, 0),
(2, '2022-11-12', 3, 3, 0, 0, 0, 0, 0, 0),
(3, '2022-10-11', 2, 2, 0, 0, 0, 0, 0, 0),
(4, '2022-10-13', 2, 1, 0, 0, 0, 0, 0, 0);

-- Task 2
-- Create a stored procedure CheckBooking to check whether a table is already booked.

CREATE PROCEDURE CheckBooking(IN BookingDateInput DATE, IN TableNumberInput INT)
SELECT CONCAT("Table ", TableNumber, " is alreaady booked") AS "Booking status"
FROM bookings
WHERE TableNumber = ANY (
	SELECT TableNumber
	FROM bookings
	WHERE BookingDate = BookingDateInput
	AND TableNumber = TableNumberInput);

CALL CheckBooking('2022-11-12', 3);

-- Task 3

-- Create stored procedure AddValidBooking

DELIMITER //
CREATE PROCEDURE AddValidBooking(IN BookingDateInput DATE, IN TableIDInput INT)
BEGIN
	DECLARE IsBooked BOOL;
    IF EXISTS (
		SELECT TableNumber
		FROM bookings
		WHERE BookingDate = BookingDateInput
		AND TableNumber = TableNumberINput) THEN SET IsBooked = TRUE;
	ELSE SET IsBooked = FALSE;
    END IF;
    
    -- Insert booking if TableNumber is not already booked; otherwise do nothing (rollback)
    START TRANSACTION;	
	INSERT INTO bookings VALUES (NULL, BookingDateInput, TableNumberInput);
    IF IsBooked THEN ROLLBACK;
    ELSE COMMIT;
    END IF;
    
    -- Update user with booking status
    SELECT
		CASE WHEN IsBooked THEN CONCAT("Table ", TableID, " is already booked - booking cancelled")
        ELSE CONCAT("Booking Table ", TableID) END AS "Booking status";
END//    
DELIMITER ;

CALL AddValidBooking('2022-12-17', 6);
