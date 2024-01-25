-- Task 1
-- Create a new procedure AddBooking with fouru input parameters

DELIMITER //

CREATE PROCEDURE AddBooking(IN BookingIDInput INT, IN CustomerIDInput INT, IN BookingDateInput DATE, IN TableNumberInput INT)
BEGIN
    INSERT INTO bookings (BookingID, CustomerID, BookingDate, TableNumber)
		VALUES (BookingIDInput, CustomerIDInput, BookingDateInput, TableNumberInput);
	
    -- Show confirmation
    SELECT "New booking added" as Confirmation;
END//

DELIMITER ;

CALL AddBooking(9, 3, '2022-12-30', 4);

-- Task 2
-- Create a new procedure UpdateBooking to update existing bookings

DELIMITER //

CREATE PROCEDURE UpdateBooking(IN BookingIDInput INT, IN BookingDateInput DATE)
BEGIN
    UPDATE bookings
		SET BookingDate = BookingDateInput
        WHERE BookingID = BookingIDInput;
    
    -- Show confirmation
    SELECT CONCAT("Booking ", BookingIDInput, " updated")  as Confirmation;
END//

DELIMITER ;

CALL UpdateBooking(9, '2022-12-17');

-- Task 3
-- Create a new procedure CancelBooking to cancel/remove a booking

DELIMITER //

CREATE PROCEDURE CancelBooking(IN BookingIDInput INT)
BEGIN
    DELETE FROM bookings WHERE BookingID = BookingIDInput;
    
    -- Show confirmation
    SELECT CONCAT("Booking ", BookingIDInput, " cancelled")  as Confirmation;
END//

DELIMITER ;

CALL CancelBooking(9);
