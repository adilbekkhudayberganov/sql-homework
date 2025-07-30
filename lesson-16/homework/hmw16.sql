WITH NumbersCTE AS (
    SELECT 1 AS Number
    UNION ALL
    SELECT Number + 1
    FROM NumbersCTE
    WHERE Number < 1000
)
SELECT * FROM NumbersCTE
OPTION (MAXRECURSION 1000)

SELECT 
    E.EmployeeID,
    E.FirstName,
    E.LastName,
    T.TotalSales
FROM Employees E
JOIN (
    SELECT EmployeeID, SUM(SalesAmount) AS TotalSales
    FROM Sales
    GROUP BY EmployeeID
) T ON E.EmployeeID = T.EmployeeID;

WITH AvgSalaryCTE AS (
    SELECT AVG(Salary) AS AvgSalary
    FROM Employees
)
SELECT * FROM AvgSalaryCTE;

SELECT 
    P.ProductID,
    P.ProductName,
    T.MaxSale
FROM Products P
JOIN (
    SELECT ProductID, MAX(SalesAmount) AS MaxSale
    FROM Sales
    GROUP BY ProductID
) T ON P.ProductID = T.ProductID;

WITH Doubles AS (
    SELECT 1 AS Number
    UNION ALL
    SELECT Number * 2
    FROM Doubles
    WHERE Number * 2 < 1000000
)
SELECT * FROM Doubles
OPTION (MAXRECURSION 100);

WITH SalesCount AS (
    SELECT EmployeeID, COUNT(*) AS SaleCount
    FROM Sales
    GROUP BY EmployeeID
    HAVING COUNT(*) > 5
)
SELECT 
    E.EmployeeID,
    E.FirstName,
    E.LastName,
    SC.SaleCount
FROM Employees E
JOIN SalesCount SC ON E.EmployeeID = SC.EmployeeID;

WITH HighSales AS (
    SELECT ProductID
    FROM Sales
    WHERE SalesAmount > 500
    GROUP BY ProductID
)
SELECT 
    P.ProductID,
    P.ProductName,
    P.Price
FROM Products P
JOIN HighSales HS ON P.ProductID = HS.ProductID;

WITH AvgSal AS (
    SELECT AVG(Salary) AS AvgSalary FROM Employees
)
SELECT 
    E.EmployeeID,
    E.FirstName,
    E.LastName,
    E.Salary
FROM Employees E
JOIN AvgSal A ON E.Salary > A.AvgSalary;

SELECT TOP 5 
    E.EmployeeID,
    E.FirstName,
    E.LastName,
    T.OrderCount
FROM Employees E
JOIN (
    SELECT EmployeeID, COUNT(*) AS OrderCount
    FROM Sales
    GROUP BY EmployeeID
) T ON E.EmployeeID = T.EmployeeID
ORDER BY T.OrderCount DESC;

SELECT 
    P.CategoryID,
    SUM(T.SalesAmount) AS TotalSales
FROM Products P
JOIN (
    SELECT ProductID, SalesAmount
    FROM Sales
) T ON P.ProductID = T.ProductID
GROUP BY P.CategoryID;

WITH FactorialCTE AS (
    SELECT Number, 1 AS Fact, Number AS Original
    FROM Numbers1
    WHERE Number = 1

    UNION ALL

    SELECT f.Number, f.Fact * n.Number, f.Original
    FROM FactorialCTE f
    JOIN Numbers1 n ON f.Fact * n.Number <= POWER(f.Number, f.Number) 
                   AND n.Number = f.Fact + 1
)
SELECT Original AS Number, MAX(Fact) AS Factorial
FROM FactorialCTE
GROUP BY Original;

WITH RecursiveCTE AS (
    SELECT 
        Id,
        CAST(SUBSTRING(String, 1, 1) AS VARCHAR(1)) AS CharPart,
        SUBSTRING(String, 2, LEN(String)) AS Remaining
    FROM Example
    WHERE LEN(String) > 0

    UNION ALL

    SELECT
        Id,
        CAST(SUBSTRING(Remaining, 1, 1) AS VARCHAR(1)),
        SUBSTRING(Remaining, 2, LEN(Remaining))
    FROM RecursiveCTE
    WHERE LEN(Remaining) > 0
)
SELECT Id, CharPart FROM RecursiveCTE
ORDER BY Id
OPTION (MAXRECURSION 1000);

WITH MonthlySales AS (
    SELECT 
        FORMAT(SaleDate, 'yyyy-MM') AS SaleMonth,
        SUM(SalesAmount) AS TotalSales
    FROM Sales
    GROUP BY FORMAT(SaleDate, 'yyyy-MM')
),
SalesDiff AS (
    SELECT 
        curr.SaleMonth,
        curr.TotalSales,
        LAG(curr.TotalSales) OVER (ORDER BY curr.SaleMonth) AS PrevMonthSales,
        curr.TotalSales - LAG(curr.TotalSales) OVER (ORDER BY curr.SaleMonth) AS SalesDifference
    FROM MonthlySales curr
)
SELECT * FROM SalesDiff;

SELECT 
    E.EmployeeID,
    E.FirstName,
    E.LastName,
    T.Quarter,
    T.TotalSales
FROM Employees E
JOIN (
    SELECT 
        EmployeeID,
        DATEPART(QUARTER, SaleDate) AS Quarter,
        SUM(SalesAmount) AS TotalSales
    FROM Sales
    GROUP BY EmployeeID, DATEPART(QUARTER, SaleDate)
    HAVING SUM(SalesAmount) > 45000
) T ON E.EmployeeID = T.EmployeeID;
