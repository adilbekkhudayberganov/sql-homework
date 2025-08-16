SELECT 
    Id, 
    Dt,
    RIGHT('0' + CAST(MONTH(Dt) AS VARCHAR(2)), 2) AS MonthPrefixedWithZero
FROM Dates;

SELECT 
    COUNT(DISTINCT Id) AS Distinct_Ids,
    rID,
    SUM(MaxVals) AS TotalOfMaxVals
FROM (
    SELECT Id, rID, MAX(Vals) AS MaxVals
    FROM MyTabel
    GROUP BY Id, rID
) t
GROUP BY rID;

SELECT Id, Vals
FROM TestFixLengths
WHERE LEN(Vals) BETWEEN 6 AND 10;

SELECT t.ID, t.Item, t.Vals
FROM TestMaximum t
WHERE Vals = (
    SELECT MAX(Vals) FROM TestMaximum WHERE ID = t.ID
);

SELECT Id, SUM(MaxVals) AS SumofMax
FROM (
    SELECT Id, DetailedNumber, MAX(Vals) AS MaxVals
    FROM SumOfMax
    GROUP BY Id, DetailedNumber
) t
GROUP BY Id;

SELECT 
    Id, a, b,
    NULLIF(a - b, 0) AS Output
FROM TheZeroPuzzle;

SELECT SUM(QuantitySold * UnitPrice) AS TotalRevenue
FROM Sales;

SELECT AVG(UnitPrice) AS AvgUnitPrice
FROM Sales;

SELECT COUNT(*) AS TotalTransactions
FROM Sales;

SELECT MAX(QuantitySold) AS MaxUnitsSold
FROM Sales;

SELECT Category, SUM(QuantitySold) AS TotalUnits
FROM Sales
GROUP BY Category;

SELECT Region, SUM(QuantitySold * UnitPrice) AS TotalRevenue
FROM Sales
GROUP BY Region;

SELECT TOP 1 Product, SUM(QuantitySold * UnitPrice) AS Revenue
FROM Sales
GROUP BY Product
ORDER BY Revenue DESC;

SELECT 
    SaleDate,
    SUM(QuantitySold * UnitPrice) AS DailyRevenue,
    SUM(SUM(QuantitySold * UnitPrice)) 
        OVER (ORDER BY SaleDate) AS RunningTotal
FROM Sales
GROUP BY SaleDate
ORDER BY SaleDate;

SELECT 
    Category,
    SUM(QuantitySold * UnitPrice) AS CategoryRevenue,
    CAST(100.0 * SUM(QuantitySold * UnitPrice) /
         SUM(SUM(QuantitySold * UnitPrice)) OVER() AS DECIMAL(5,2)) AS ContributionPct
FROM Sales
GROUP BY Category;

SELECT s.SaleID, s.Product, s.QuantitySold, s.UnitPrice, s.SaleDate,
       c.CustomerName, c.Region
FROM Sales s
JOIN Customers c ON s.CustomerID = c.CustomerID;

SELECT c.CustomerID, c.CustomerName
FROM Customers c
LEFT JOIN Sales s ON c.CustomerID = s.CustomerID
WHERE s.SaleID IS NULL;

SELECT c.CustomerID, c.CustomerName,
       SUM(s.QuantitySold * s.UnitPrice) AS TotalRevenue
FROM Sales s
JOIN Customers c ON s.CustomerID = c.CustomerID
GROUP BY c.CustomerID, c.CustomerName;

SELECT TOP 1 c.CustomerName,
       SUM(s.QuantitySold * s.UnitPrice) AS TotalRevenue
FROM Sales s
JOIN Customers c ON s.CustomerID = c.CustomerID
GROUP BY c.CustomerName
ORDER BY TotalRevenue DESC;

SELECT c.CustomerID, c.CustomerName,
       COUNT(s.SaleID) AS TotalSales
FROM Customers c
LEFT JOIN Sales s ON c.CustomerID = s.CustomerID
GROUP BY c.CustomerID, c.CustomerName;

SELECT DISTINCT p.ProductID, p.ProductName
FROM Products p
JOIN Sales s ON p.ProductName = s.Product;

SELECT TOP 1 ProductName, SellingPrice
FROM Products
ORDER BY SellingPrice DESC;

SELECT ProductName, Category, SellingPrice
FROM Products p
WHERE SellingPrice > (
    SELECT AVG(SellingPrice)
    FROM Products
    WHERE Category = p.Category
);


