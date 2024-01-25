-- Task 1
-- Create a procedure GetMaxQuantity that displays the maximum ordered quantity in the Orders table

CREATE PROCEDURE GetMaxQuantity()
SELECT MAX(Quantity) AS "Max Quantity in Order" FROM Orders;

CALL GetMaxQuantity();

-- Task 2
-- Create a prepared statement GetOrderDetail with one input argument CustomerID

PREPARE GetOrderDetail FROM 'SELECT OrderID, Quantity, TotalCost FROM Orders WHERE CustomerID = ?';

SET @id = 1;
EXECUTE GetOrderDetail USING @id;

-- Task 3
-- Create a stored procedure called CancelOrder to delete an order record based on the user input of the order id.

CREATE PROCEDURE CancelOrder(IN OrderIDInput INT)
DELETE FROM orders WHERE OrderID = OrderIDInput;

CALL CancelOrder(5);
