SELECT MIN(Price) AS MinPrice
FROM Products;

SELECT MAX(Salary) AS MaxSalary
FROM Employees;

SELECT COUNT(*) AS TotalCustomers
FROM Customers;

SELECT COUNT(DISTINCT Category) AS UniqueCategories
FROM Products;

SELECT SUM(SaleAmount) AS TotalSalesForProduct7
FROM Sales
WHERE ProductID = 7;

SELECT AVG(Age) AS AverageAge
FROM Employees;

SELECT DepartmentName, COUNT(*) AS EmployeeCount
FROM Employees
GROUP BY DepartmentName;

SELECT Category, MIN(Price) AS MinPrice, MAX(Price) AS MaxPrice
FROM Products
GROUP BY Category;

SELECT CustomerID, SUM(SaleAmount) AS TotalSales
FROM Sales
GROUP BY CustomerID;

SELECT DepartmentName, COUNT(*) AS EmployeeCount
FROM Employees
GROUP BY DepartmentName
HAVING COUNT(*) > 5;

SELECT 
    p.Category,
    SUM(s.SaleAmount) AS TotalSales,
    AVG(s.SaleAmount) AS AverageSales
FROM Sales s
JOIN Products p ON s.ProductID = p.ProductID
GROUP BY p.Category;

SELECT COUNT(*) AS HR_EmployeeCount
FROM Employees
WHERE DepartmentName = 'HR';

SELECT 
    DepartmentName,
    MAX(Salary) AS MaxSalary,
    MIN(Salary) AS MinSalary
FROM Employees
GROUP BY DepartmentName;

SELECT 
    DepartmentName,
    AVG(Salary) AS AvgSalary
FROM Employees
GROUP BY DepartmentName;

SELECT 
    DepartmentName,
    AVG(Salary) AS AvgSalary,
    COUNT(*) AS EmployeeCount
FROM Employees
GROUP BY DepartmentName;

SELECT 
    Category,
    AVG(Price) AS AvgPrice
FROM Products
GROUP BY Category
HAVING AVG(Price) > 400;

SELECT 
    EXTRACT(YEAR FROM SaleDate) AS SaleYear,
    SUM(SaleAmount) AS TotalSales
FROM Sales
GROUP BY EXTRACT(YEAR FROM SaleDate)
ORDER BY SaleYear;

SELECT 
    CustomerID,
    COUNT(*) AS OrderCount
FROM Orders
GROUP BY CustomerID
HAVING COUNT(*) >= 3;

SELECT 
    DepartmentName,
    AVG(Salary) AS AvgSalary
FROM Employees
GROUP BY DepartmentName
HAVING AVG(Salary) > 60000;


