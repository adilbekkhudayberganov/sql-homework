SELECT Category, COUNT(*) AS TotalProducts
FROM Products
GROUP BY Category;

SELECT AVG(Price) AS AveragePrice
FROM Products
WHERE Category = 'Electronics';

SELECT *
FROM Customers
WHERE City LIKE 'L%';

SELECT ProductName
FROM Products
WHERE ProductName LIKE '%er';

SELECT *
FROM Customers
WHERE Country LIKE '%a';

SELECT MAX(Price) AS HighestPrice
FROM Products;

SELECT ProductName, StockQuantity,
       CASE 
           WHEN StockQuantity < 30 THEN 'Low Stock'
           ELSE 'Sufficient'
       END AS StockStatus
FROM Products;

SELECT Country, COUNT(*) AS TotalCustomers
FROM Customers
GROUP BY Country;

SELECT MIN(Quantity) AS MinQuantity, MAX(Quantity) AS MaxQuantity
FROM Orders;

SELECT DISTINCT o.CustomerID
FROM Orders o
WHERE o.OrderDate BETWEEN '2023-01-01' AND '2023-01-31'
  AND o.CustomerID NOT IN (
    SELECT CustomerID
    FROM Invoices
  );

SELECT ProductName FROM Products
UNION ALL
SELECT ProductName FROM Products_Discounted;

SELECT ProductName FROM Products
UNION
SELECT ProductName FROM Products_Discounted;

SELECT YEAR(OrderDate) AS OrderYear, AVG(TotalAmount) AS AvgOrderAmount
FROM Orders
GROUP BY YEAR(OrderDate);

SELECT ProductName, 
       CASE 
           WHEN Price < 100 THEN 'Low'
           WHEN Price BETWEEN 100 AND 500 THEN 'Mid'
           ELSE 'High'
       END AS PriceGroup
FROM Products;

SELECT district_name,
       MAX(CASE WHEN year = '2012' THEN population END) AS [2012],
       MAX(CASE WHEN year = '2013' THEN population END) AS [2013]
INTO Population_Each_Year
FROM city_population
GROUP BY district_name;

SELECT ProductID, SUM(SaleAmount) AS TotalSales
FROM Sales
GROUP BY ProductID;

SELECT ProductName
FROM Products
WHERE ProductName LIKE '%oo%';

SELECT year,
       MAX(CASE WHEN district_name = 'Bektemir' THEN population END) AS Bektemir,
       MAX(CASE WHEN district_name = 'Chilonzor' THEN population END) AS Chilonzor,
       MAX(CASE WHEN district_name = 'Yakkasaroy' THEN population END) AS Yakkasaroy
INTO Population_Each_City
FROM city_population
GROUP BY year;




