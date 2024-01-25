-- Task 1
-- Create OrdersView virtual table that focuses on OrderID, Quantity, and Cost columns
-- for all orders with quantity greater than 2

CREATE VIEW OrdersView AS
SELECT 
	OrderID,
	Quantity,
	TotalCost
FROM orders
WHERE Quantity > 2;

SELECT * FROM OrdersView;

-- Task 2
-- Get information from four tables on all customers with orders that cost more than $150

SELECT
	c.CustomerID,
	c.FullName,
	o.OrderID,
	o.TotalCost,
	m.MenuName,
    mi.CourseName,
    mi.StarterName
FROM customers c
INNER JOIN orders o ON c.CustomerID = o.CustomerID
INNER JOIN menus m ON o.MenuID = m.MenuID
INNER JOIN menuitems mi ON m.MenuItemsID = mi.MenuItemsID
WHERE TotalCost > 150
ORDER BY TotalCost;


-- Task 3
-- Find all menu items for which more than 2 orders have been placed
-- (Use subquery that lists the menu names from the menus table for any order quantity with more than 2)

SELECT MenuName
FROM menus
WHERE MenuID = ANY (SELECT MenuID FROM orders WHERE Quantity > 2);
