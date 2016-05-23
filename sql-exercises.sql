--Northwind Database SQL Exercises

--1 Return all category names with their descriptions from the Categories table.
SELECT CategoryName, [Description]
FROM Categories


--2 Return the contact name, customer id, and company name of all Customers in London
SELECT ContactName, CustomerID, CompanyName
FROM Customers
WHERE City='London'


--3 Return all available columns in the Suppliers tables for the marketing managers and sales representatives that have a FAX number
SELECT * FROM Suppliers
WHERE Fax IS NOT NULL
AND ContactTitle='Marketing Manager' OR ContactTitle='Sales Representative'


--4 Return a list of customer id's from the Orders table with required dates between Jan 1, 1997 and Jan 1, 1998 and with freight under 100 units.
SELECT CustomerID 
FROM Orders
WHERE RequiredDate BETWEEN '01/01/1997' AND  '01/01/1998' and Freight < 100


--5 Return a list of company names and contact names of all the Owners from the Customer table from Mexico, Sweden and Germany.
SELECT CompanyName, ContactName
FROM Customers
WHERE Country IN ('Mexico','Sweden','Germany');


--6 Return a count of the number of discontinued products in the Products table.
SELECT COUNT(ProductId)
FROM Products
WHERE Discontinued=0


--7 Return a list of category names and descriptions of all categories beginning with 'Co' from the Categories table.
SELECT CategoryName, Description
FROM Categories
WHERE CategoryName LIKE 'Co%'


--8 Return all the company names, city, country and postal code from the Suppliers table with the word 'rue' in their address. The list should ordered alphabetically by company name.
SELECT CompanyName, City, Country, PostalCode
FROM Suppliers
WHERE Address LIKE '%rue%' 
ORDER BY CompanyName DESC


--9 Return the product id and the total quantities ordered for each product id in the Order Details table.
SELECT ProductId, SUM(Quantity)
AS TotalItemsOrdered
FROM [Order Details]
GROUP BY ProductID
ORDER BY ProductID


--10 Return the customer name and customer address of all customers with orders that shipped using Speedy Express.
SELECT ContactName, Address
FROM Customers 
INNER JOIN
Orders ON Customers.CustomerID = Orders.CustomerId
INNER JOIN Shippers ON Orders.ShipVia = Shippers.ShipperId
AND Shippers.CompanyName = 'Speedy Express'


--11 Return a list of Suppliers containing company name, contact name, contact title and region description.
--SELECT CompanyName, ContactName, ContactTitle
--FROM Suppliers
--INNER JOIN 
--Products ON 
-- Tried to make a query for this one, but there's no distinct relationship(connection) to query the region description specifically.


--12 Return all product names from the Products table that are condiments.
SELECT * FROM Products
INNER JOIN
Categories ON Products.CategoryID = Categories.CategoryID
WHERE CategoryName = 'Condiments'


--13 Return all product names from the Products table that are condiments.
SELECT CompanyName 
FROM Customers
LEFT JOIN Orders on Customers.CustomerID = Orders.CustomerID
WHERE Orders.CustomerID IS NULL


--14 Add a shipper named 'Amazon' to the Shippers table using SQL.
SELECT * FROM Shippers
INSERT INTO Shippers (CompanyName, Phone) Values ('Amazon', '(888)-280-4331');


--15 Change the company name from 'Amazon' to 'Amazon Prime Shipping' in the Shippers table using SQL.
UPDATE Shippers 
SET CompanyName='Amazon Prime Shipping' 
WHERE CompanyName='Amazon'

SELECT * FROM Shippers


--16 Return a complete list of company names from the Shippers table. 
--Include freight totals rounded to the nearest whole number for each shipper from the Orders table for those shippers with orders.
SELECT CompanyName, CONVERT(int,ROUND(SUM(Freight),0))
AS FreightTotal
FROM Shippers
INNER JOIN Orders on Shippers.ShipperID = Orders.ShipVia
GROUP BY CompanyName
ORDER BY CompanyName


--17 Return all employee first and last names from the Employees table by combining the 2 columns aliased as 'DisplayName'. 
--The combined format should be 'LastName, FirstName'.
SELECT CONCAT (FirstName, ' ',LastName) AS DisplayName 
FROM Employees


--18 Add yourself to the Customers table with an order for 'Grandma's Boysenberry Spread'.
SELECT * FROM Customers WHERE CompanyName='Cherr Inc'
SELECT * FROM Orders WHERE CustomerID = 'CB'
SELECT * FROM [Order Details] ORDER BY Orderid DESC
SELECT * FROM Products

INSERT INTO Customers (CustomerID, CompanyName, ContactName, ContactTitle, Address, City, Region, PostalCode, Country, Phone, Fax) 
VALUES ('CB','Cherr Inc', 'Cherr Batac', 'Tech Geek', '123 Somewhere St.', 'San Diego', 'CA', 92121, 'USA', '123-456-789',NULL)

INSERT INTO Orders(CustomerID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)
VALUES ('CB', GETDATE(), CONVERT(DATETIME,'5/25/2016'), NULL, 1, 12.99, 'Mouse', '123 Somewhere St', 'San Diego', NULL, '92121', 'USA')

INSERT INTO Products(ProductName,QuantityPerUnit) VALUES ('Grandma''s Boysenberry Spread', '6 oz jar')


--19 Remove yourself and your order from the database.
DELETE FROM Products WHERE ProductID = 78
SELECT * FROM Products

DELETE FROM Orders WHERE CustomerID = 'CB'
SELECT * FROM Orders

DELETE FROM Customers WHERE CustomerID = 'CB'
SELECT * FROM Customers


--20 Return a list of products from the Products table along with the total units in stock for each product. 
--Give the computed column a name using the alias, 'TotalUnits'. Include only products with TotalUnits greater than 100.

SELECT ProductName, UnitsInStock AS TotalUnits FROM Products WHERE UnitsInStock  > 100