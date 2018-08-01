/*1) Удалить элементы таблицы Products у которых цена < 20*/
DELETE FROM Products
WHERE Price < 20;

/*2) В таблице Customers обновить поле Country на "Ukraine" где Country = "Germany"*/
UPDATE Customers
SET Country = 'Ukraine'
WHERE Country = 'Germany';

/*3) Из таблицы Employees выбрать все записи в поле Notes которых содержиться слово "University"*/
SELECT * FROM Employees
WHERE Notes LIKE '%University%';

/*4) Выбрать все запись из таблицы Orders где значение поля OrderDate находитя в промежутке от 1996-07-04 до 1996-08-07 и ShipperID = 1 или 3*/
SELECT * FROM Orders 
WHERE OrderDate BETWEEN '1996-07-04' AND '1996-08-07' AND ShipperID IN (1, 3)



/*5) Узнать солько заказов было сделано для каждого города(city) из таблицы Customers.*/
SELECT COUNT(CustomerID) AS NumberOfOrders, City
FROM Customers
GROUP BY City;

/*6) Из таблицы (Product) вывести только те продукты у которых поставщик (Supplier): New Orleans Cajun Delights(2) и Tokyo Traders(4) и добавить к выводу продутка Имя поставщика (SupplierName)*/
SELECT Products.ProductName, Suppliers.SupplierName
FROM Products
INNER JOIN Suppliers
ON Products.SupplierID = Suppliers.SupplierID
WHERE Products.SupplierID = '2' OR Products.SupplierID = '4'

/*7) Узнать общую стоимость заказов для пользователя.*/
SELECT Customers.CustomerName, Customers.CustomerID, SUM(Products.Price * OrderDetails.Quantity) AS ResultSum
FROM Orders
INNER JOIN OrderDetails ON Orders.OrderID = OrderDetails.OrderID
INNER JOIN Customers ON Orders.CustomerID = Customers.CustomerID
INNER JOIN Products ON OrderDetails.ProductID = Products.ProductID
GROUP BY CustomerName;

/*8)Вывести среднюю сумму всех заказов на каждую дату (OrderDate) в таблице (Orders), если средняя сумма заказов в этот день была больше  > 30 и к каждой дате добавить человека, кто в этот день принимал заказ из таблицы Employees*/

SELECT Orders.OrderID, Orders.OrderDate, Orders.EmployeeID, OrderDetails.ProductID, Products.Price, OrderDetails.Quantity, Employees.LastName, Employees.FirstName
FROM OrderDetails
INNER JOIN Products ON OrderDetails.ProductID = Products.ProductID
INNER JOIN Orders ON Orders.OrderID = OrderDetails.OrderID
INNER JOIN Employees ON Orders.EmployeeID = Employees.EmployeeID
GROUP BY Orders.OrderDate HAVING (SUM(OrderDetails.Quantity * Products.Price) / COUNT(OrderDetails.OrderID)) > 30