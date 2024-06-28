use northwind;

/* 1. What is the name of the table that holds the items Northwind sells? */
SELECT * FROM Products;

/* 2. Write a query to list the product id, product name, and unit price of every
product. */
SELECT ProductID, ProductName, UnitPrice FROM Products;

/* 3. Write a query to list the product id, product name, and unit price of every
product. Except this time, order then in ascending order by price. */
SELECT ProductID, ProductName, UnitPrice FROM Products ORDER BY UnitPrice;

/* 4. What are the products that we carry where the unit price is $7.50 or less? */
SELECT ProductID, ProductName, UnitPrice FROM Products WHERE UnitPrice <= 7.50;

/* 5. What are the products that we carry where we have at least 100 units on hand?
Order them in descending order by price. */
SELECT ProductID, ProductName, UnitPrice, UnitsInStock FROM Products WHERE UnitsInStock >= 100 ORDER BY UnitPrice DESC;

/* 6. What are the products that we carry where we have at least 100 units on hand?
Order them in descending order by price. If two or more have the same price, list
those in ascending order by product name. */
SELECT ProductID, ProductName, UnitPrice, UnitsInStock FROM Products WHERE UnitsInStock >= 100 ORDER BY UnitPrice DESC, ProductName;

/* 7. What are the products that we carry where we have no units on hand, but 1 or
more units of them on backorder? Order them by product name. */
SELECT ProductID, ProductName, UnitsInStock, UnitsOnOrder FROM Products WHERE UnitsInStock = 0 AND UnitsOnOrder > 0 ORDER BY ProductName;

/* 8. What is the name of the table that holds the types (categories) of the items
Northwind sells? */
SELECT * FROM Categories;

/* 9. Write a query that lists all of the columns and all of the rows of the categories
table? What is the category id of seafood? */
SELECT * FROM Categories;
SELECT CategoryID FROM Categories WHERE CategoryName='Seafood';

/* 10. Examine the Products table. How does it identify the type (category) of each item
sold? Write a query to list all of the seafood items we carry. */
SELECT * FROM PRODUCTS WHERE CategoryID = 8;
SELECT * FROM PRODUCTS WHERE CategoryID = ( SELECT CategoryID FROM Categories WHERE CategoryName='Seafood');

/* 11. What are the first and last names of all of the Northwind employees? */
SELECT FirstName, LastName FROM Employees;

/* 12. What employees have "manager" in their titles? */
SELECT * FROM Employees WHERE title LIKE '%manager%';

/* 13. List the distinct job titles in employees. */
SELECT DISTINCT(title) FROM Employees;

/* 14. What employees have a salary that is between $200 0 and $2500? */
SELECT * FROM Employees WHERE Salary BETWEEN 2000 AND 2500;

/* 15. List all of the information about all of Northwind's suppliers. */
SELECT * FROM Suppliers;

/*  16. Examine the Products table. How do you know what supplier supplies each
product? Write a query to list all of the items that "Tokyo Traders" supplies to
Northwind */
SELECT SupplierID FROM Suppliers WHERE CompanyName = 'Tokyo Traders';
SELECT * FROM Products WHERE SupplierID = 4;
SELECT * FROM Products WHERE SupplierID = (SELECT SupplierID FROM Suppliers WHERE CompanyName = 'Tokyo Traders');


/* ============ */
/* 1. How many suppliers are there? Use a query! */
SELECT COUNT(*) FROM Suppliers;

/* 2. What is the sum of all the employee's salaries? */
SELECT SUM(Salary) FROM Employees;

/* 3. What is the price of the cheapest item that Northwind sells? */
SELECT MIN(UnitPrice) FROM Products;

/* 4. What is the average price of items that Northwind sells? */
SELECT AVG(UnitPrice) FROM Products;

/* 5. What is the price of the most expensive item that Northwind sells? */
SELECT MAX(UnitPrice) FROM Products;

/* 6. What is the supplier ID of each supplier and the number of items they supply?
You can answer this query by only looking at the Products table. */
SELECT SupplierID, COUNT(*) AS 'Total Items' FROM Products GROUP BY SupplierID; 

/* 7. What is the category ID of each category and the average price of each item in the
category? You can answer this query by only looking at the Products table. */
SELECT CategoryID, AVG(UnitPrice) AS 'Average Price'  FROM Products GROUP BY CategoryID;

/* 8. For suppliers that provide at least 5 items to Northwind, what is the supplier ID of
each supplier and the number of items they supply? You can answer this query
by only looking at the Products table. */
SELECT SupplierID, COUNT(*) AS 'TotalItems' FROM Products GROUP BY SupplierID HAVING TotalItems >= 5; 

/* 9. List the product id, product name, and inventory value (calculated by multiplying
unit price by the number of units on hand). Sort the results in descending order
by value. If two or more have the same value, order by product name. */
SELECT ProductID, ProductName, (UnitPrice * UnitsInStock) AS InventoryValue FROM Products ORDER BY InventoryValue DESC, ProductName;

/* ================ */
/*  1. What is the product name(s) of the most expensive products? HINT: Find the
max price in a subquery and then use that value to find products whose price
equals that value. */
SELECT ProductName, UnitPrice FROM Products WHERE UnitPrice=( SELECT MAX(UnitPrice) FROM Products);

/* 2. What is the order id, shipping name and shipping address of all orders shipped via
"Federal Shipping"? HINT: Find the shipper id of "Federal Shipping" in a subquery
and then use that value to find the orders that used that shipper. */
SELECT OrderID, ShipName, ShipAddress FROM Orders WHERE ShipVia = (
  SELECT ShipperID FROM Shippers WHERE CompanyName='Federal Shipping');
  
/* 3. What are the order ids of the orders that ordered "Sasquatch Ale"? HINT: Find
the product id of "Sasquatch Ale" in a subquery and then use that value to find
the matching orders from the `order details` table. Because the `order details`
table has a space in its name, you will need to surround it with back ticks in the
FROM clause. */
SELECT OrderID FROM `Order Details` WHERE ProductID = (
  SELECT ProductID from Products WHERE ProductName = 'Sasquatch Ale');
  
/* 4. What is the name of the employee that sold order 10266? */
SELECT FirstName, LastName FROM Employees WHERE EmployeeID = (
   SELECT EmployeeID FROM Orders WHERE OrderID = 10266);
   
/* 5. What is the name of the customer that bought order 10266? */
SELECT ContactName FROM Customers WHERE CustomerID = (
   SELECT CustomerID FROM Orders WHERE OrderID = 10266);
   
/* ============= */
/* 1. List the product id, product name, unit price and category name of all products.
Order by category name and within that, by product name. */
SELECT Products.ProductID, Products.ProductName, Products.UnitPrice, Categories.CategoryName 
FROM Products 
LEFT JOIN Categories 
ON Products.CategoryID = Categories.CategoryID 
ORDER BY Categories.CategoryName, Products.ProductName;

/* 2. List the product id, product name, unit price and supplier name of all products
that cost more than $75. Order by product name. */
SELECT Products.ProductID, Products.ProductName, Products.UnitPrice, Suppliers.ContactName 
FROM Products
LEFT JOIN Suppliers
ON Products.SupplierID = Suppliers.SupplierID
WHERE Products.UnitPrice > 75
ORDER BY Products.ProductName;

/* 3. List the product id, product name, unit price, category name, and supplier name
of every product. Order by product name. */
SELECT Products.ProductID, Products.ProductName, Products.UnitPrice, Categories.CategoryName, Suppliers.ContactName
FROM Products
LEFT JOIN Categories ON Products.CategoryID = Categories.CategoryID
LEFT JOIN Suppliers ON Products.SupplierID = Suppliers.SupplierID
ORDER BY Products.ProductName;

/* 4. What is the product name(s) and categories of the most expensive products?
HINT: Find the max price in a subquery and then use that in your more complex
query that joins products with categories. */
SELECT Products.ProductName, Products.UnitPrice, Categories.* FROM 
Products LEFT JOIN Categories ON Products.CategoryID = Categories.CategoryID
WHERE Products.UnitPrice = ( SELECT MAX(UnitPrice) FROM Products);

/* 5. List the order id, ship name, ship address, and shipping company name of every
order that shipped to Germany. */
SELECT Orders.OrderID, Orders.ShipName, Orders.ShipAddress, Shippers.CompanyName 
FROM Orders LEFT JOIN Shippers ON Orders.ShipVia = Shippers.ShipperID
WHERE Orders.ShipCountry = 'Germany';

/* 6. List the order id, order date, ship name, ship address of all orders that ordered
"Sasquatch Ale"? */
SELECT Orders.OrderID, Orders.OrderDate, Orders.ShipName, Orders.ShipAddress
FROM Orders 
LEFT JOIN `Order Details` AS OrderDetails 
ON Orders.OrderID = OrderDetails.OrderID
LEFT JOIN Products 
ON OrderDetails.ProductID = Products.ProductID
WHERE Products.ProductName = 'Sasquatch Ale';

/* ============== */
/* 1. Add a new supplier. */
INSERT INTO Suppliers(CompanyName) VALUES ('TEST Company');

/* 2. Add a new product provided by that supplier */
INSERT INTO Products(ProductName, UnitPrice) VALUES ('TEST Product', 100);
UPDATE Products SET SupplierID=(SELECT SupplierID FROM Suppliers WHERE CompanyName='TEST Company') WHERE ProductName='TEST Product';

/* 3. List all products and their suppliers. */
SELECT Products.*, Suppliers.CompanyName FROM Products JOIN Suppliers ON Products.SupplierID = Suppliers.SupplierID;

/*4. Raise the price of your new product by 15%.*/
UPDATE Products SET UnitPrice=UnitPrice*1.15 WHERE ProductName='TEST PRODUCT';

/* 5. List the products and prices of all products from that supplier. */
SELECT Products.ProductName, Products.UnitPrice, Suppliers.CompanyName 
FROM Products 
JOIN Suppliers 
ON Products.SupplierID = Suppliers.SupplierID 
WHERE 
Suppliers.CompanyName = 'TEST Company';

/* 6. Delete the new product. */
DELETE FROM Products WHERE ProductName = 'TEST Product';

/* 7. Delete the new supplier.*/
DELETE FROM Suppliers WHERE CompanyName = "TEST Company";

/* 8. List all products. */
SELECT * FROM Products;

/* 9. List all suppliers.*/
SELECT * FROM Suppliers;