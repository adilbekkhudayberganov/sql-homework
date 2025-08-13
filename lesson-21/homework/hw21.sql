SELECT 
    SaleID,
    ProductName,
    SaleDate,
    SaleAmount,
    ROW_NUMBER() OVER (ORDER BY SaleDate) AS RowNum
FROM ProductSales;

SELECT 
    ProductName,
    SUM(Quantity) AS TotalQuantity,
    DENSE_RANK() OVER (ORDER BY SUM(Quantity) DESC) AS RankByQuantity
FROM ProductSales
GROUP BY ProductName;

SELECT *
FROM (
    SELECT *,
           ROW_NUMBER() OVER (PARTITION BY CustomerID ORDER BY SaleAmount DESC) AS rn
    FROM ProductSales
) t
WHERE rn = 1;

SELECT 
    SaleID,
    SaleDate,
    SaleAmount,
    LEAD(SaleAmount) OVER (ORDER BY SaleDate) AS NextSaleAmount
FROM ProductSales;

SELECT 
    SaleID,
    SaleDate,
    SaleAmount,
    LAG(SaleAmount) OVER (ORDER BY SaleDate) AS PrevSaleAmount
FROM ProductSales;

SELECT *
FROM (
    SELECT *,
           LAG(SaleAmount) OVER (ORDER BY SaleDate) AS PrevSaleAmount
    FROM ProductSales
) t
WHERE SaleAmount > PrevSaleAmount;

SELECT 
    SaleDate,
    SaleAmount,
    LEAD(SaleAmount) OVER (ORDER BY SaleDate) AS NextSaleAmount,
    CASE 
        WHEN LEAD(SaleAmount) OVER (ORDER BY SaleDate) IS NULL THEN NULL
        ELSE (LEAD(SaleAmount) OVER (ORDER BY SaleDate) - SaleAmount) * 100.0 / SaleAmount
    END AS PctChangeToNext
FROM ProductSales;

SELECT 
    ProductName,
    SaleDate,
    SaleAmount,
    CASE 
        WHEN LAG(SaleAmount) OVER (PARTITION BY ProductName ORDER BY SaleDate) IS NULL THEN NULL
        ELSE SaleAmount * 1.0 / LAG(SaleAmount) OVER (PARTITION BY ProductName ORDER BY SaleDate)
    END AS RatioToPrev
FROM ProductSales;

SELECT 
    ProductName,
    SaleDate,
    SaleAmount,
    SaleAmount - FIRST_VALUE(SaleAmount) OVER (PARTITION BY ProductName ORDER BY SaleDate) AS DiffFromFirst
FROM ProductSales;

SELECT *
FROM (
    SELECT *,
           LAG(SaleAmount) OVER (PARTITION BY ProductName ORDER BY SaleDate) AS PrevSale
    FROM ProductSales
) t
WHERE SaleAmount > PrevSale;

SELECT 
    SaleDate,
    SaleAmount,
    SUM(SaleAmount) OVER (ORDER BY SaleDate ROWS UNBOUNDED PRECEDING) AS RunningTotal
FROM ProductSales;

SELECT 
    SaleDate,
    SaleAmount,
    AVG(SaleAmount) OVER (ORDER BY SaleDate ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS MovingAvg3
FROM ProductSales;

SELECT 
    SaleDate,
    SaleAmount,
    SaleAmount - AVG(SaleAmount) OVER () AS DiffFromAvg
FROM ProductSales;

SELECT 
    *,
    DENSE_RANK() OVER (ORDER BY Salary DESC) AS SalaryRank
FROM Employees1;

SELECT *
FROM (
    SELECT *,
           DENSE_RANK() OVER (PARTITION BY Department ORDER BY Salary DESC) AS DeptRank
    FROM Employees1
) t
WHERE DeptRank <= 2;

SELECT *
FROM (
    SELECT *,
           RANK() OVER (PARTITION BY Department ORDER BY Salary ASC) AS SalaryRankAsc
    FROM Employees1
) t
WHERE SalaryRankAsc = 1;

SELECT 
    Department,
    Name,
    Salary,
    SUM(Salary) OVER (PARTITION BY Department ORDER BY HireDate ROWS UNBOUNDED PRECEDING) AS RunningTotal
FROM Employees1;

SELECT 
    Department,
    SUM(Salary) OVER (PARTITION BY Department) AS TotalSalary
FROM Employees1;

SELECT 
    Department,
    AVG(Salary) OVER (PARTITION BY Department) AS AvgSalary
FROM Employees1;

SELECT 
    *,
    Salary - AVG(Salary) OVER (PARTITION BY Department) AS DiffFromDeptAvg
FROM Employees1;

SELECT 
    *,
    AVG(Salary) OVER (ORDER BY HireDate ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) AS MovingAvg3
FROM Employees1;

SELECT SUM(Salary) AS SumLast3
FROM (
    SELECT Salary
    FROM Employees1
    ORDER BY HireDate DESC
    OFFSET 0 ROWS FETCH NEXT 3 ROWS ONLY
) t;


