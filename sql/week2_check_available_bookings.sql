-- Task 1
-- Add 4 records using simple INSERT statements

-- Create Customer rows with Customer IDS 1, 2, and 3
INSERT INTO customers (CustomerID, FullName, EmailAddress, PhoneNumber) VALUES
(1, 'Joe Biden', 'jbiden@coursera.org', '8005551234'),
(2, 'Donald Trump', 'dtrump@coursera.org', '8006661234'),
(3, 'Nikki Haley', 'nhaley@coursera.org', '8007771234');

-- Create a Staff row with StaffID = 1 
INSERT INTO staff (StaffID, FirstName, LastName, Role, Salary) VALUES (1, 'Joe', 'Smith', 'Manager', 50000);

-- Complete task of adding 4 records
INSERT INTO bookings (BookingID, BookingDate, TableNumber, CustomerID, StaffID)
VALUES
(1, '2022-10-10', 5, 1, 1),
(2, '2022-11-12', 3, 3, 1),
(3, '2022-10-11', 2, 2, 1),
(4, '2022-10-13', 2, 1, 1);

-- Task 2
-- Create a stored procedure CheckBooking to check whether a table is already booked.

CREATE PROCEDURE CheckBooking(IN BookingDateInput DATE, IN TableNumberInput INT)
SELECT CONCAT("Table ", TableNumber, " is already booked") AS "Booking status"
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
CREATE PROCEDURE AddValidBooking(IN BookingDateInput DATE, IN TableNumberInput INT)
BEGIN
	DECLARE IsBooked BOOL;
    IF EXISTS (
		SELECT TableNumber
		FROM bookings
		WHERE BookingDate = BookingDateInput
		AND TableNumber = TableNumberInput) THEN SET IsBooked = TRUE;
	ELSE SET IsBooked = FALSE;
    END IF;
    
    -- Insert booking if TableNumber is not already booked; otherwise do nothing (rollback)
    START TRANSACTION;	
	INSERT INTO bookings VALUES (99, BookingDateInput, TableNumberInput, 1, 1);
    IF IsBooked THEN ROLLBACK;
    ELSE COMMIT;
    END IF;
    
    -- Update user with booking status
    SELECT
		CASE WHEN IsBooked THEN CONCAT("Table ", TableNumberInput, " is already booked - booking cancelled")
        ELSE CONCAT("Booking Table ", TableNumberInput) END AS "Booking status";
END//    
DELIMITER ;

-- Confirm booking is cancelled by passing an known existing (BookingDate, TableNumber)
CALL AddValidBooking('2022-10-13', 2);
