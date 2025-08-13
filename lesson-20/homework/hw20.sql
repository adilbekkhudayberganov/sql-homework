SELECT DISTINCT s1.CustomerName
FROM #Sales s1
WHERE EXISTS (
    SELECT 1
    FROM #Sales s2
    WHERE s2.CustomerName = s1.CustomerName
      AND s2.SaleDate >= '2024-03-01'
      AND s2.SaleDate < '2024-04-01'
);

SELECT TOP 1 Product
FROM #Sales
GROUP BY Product
ORDER BY SUM(Quantity * Price) DESC;

SELECT MAX(SaleAmount) AS SecondHighestSale
FROM (
    SELECT DISTINCT Quantity * Price AS SaleAmount
    FROM #Sales
) t
WHERE SaleAmount < (
    SELECT MAX(Quantity * Price) FROM #Sales
);

SELECT MonthName, TotalQuantity
FROM (
    SELECT DATENAME(MONTH, SaleDate) AS MonthName,
           SUM(Quantity) AS TotalQuantity
    FROM #Sales
    GROUP BY DATENAME(MONTH, SaleDate), MONTH(SaleDate)
) t
ORDER BY MONTH(MonthName);

SELECT DISTINCT s1.CustomerName
FROM #Sales s1
WHERE EXISTS (
    SELECT 1
    FROM #Sales s2
    WHERE s1.CustomerName <> s2.CustomerName
      AND s1.Product = s2.Product
);


SELECT Name,
       SUM(CASE WHEN Fruit = 'Apple' THEN 1 ELSE 0 END) AS Apple,
       SUM(CASE WHEN Fruit = 'Orange' THEN 1 ELSE 0 END) AS Orange,
       SUM(CASE WHEN Fruit = 'Banana' THEN 1 ELSE 0 END) AS Banana
FROM Fruits
GROUP BY Name;

WITH CTE AS (
    SELECT ParentId, ChildID
    FROM Family
    UNION ALL
    SELECT c.ParentId, f.ChildID
    FROM CTE c
    JOIN Family f ON c.ChildID = f.ParentId
)
SELECT * FROM CTE
ORDER BY ParentId, ChildID;

SELECT *
FROM #Orders o
WHERE DeliveryState = 'TX'
  AND EXISTS (
      SELECT 1
      FROM #Orders o2
      WHERE o2.CustomerID = o.CustomerID
        AND o2.DeliveryState = 'CA'
  );

UPDATE r
SET fullname = PARSENAME(REPLACE(SUBSTRING(address, CHARINDEX('name=', address) + 5, 100), ' ', '.'), 1)
FROM #residents r
WHERE fullname IS NULL
  OR fullname NOT IN (SELECT value FROM STRING_SPLIT(address, ' ') WHERE value LIKE 'name=%');


SELECT 'Tashkent - Samarkand - Khorezm' AS Route, 100 + 400 AS Cost
UNION ALL
SELECT 'Tashkent - Jizzakh - Samarkand - Bukhoro - Khorezm',
       100 + 50 + 200 + 300;

WITH grp AS (
    SELECT *,
           SUM(CASE WHEN Vals = 'Product' THEN 1 ELSE 0 END)
             OVER (ORDER BY ID) AS grp_id
    FROM #RankingPuzzle
)
SELECT *
FROM grp;

SELECT *
FROM #EmployeeSales e
WHERE SalesAmount > (
    SELECT AVG(SalesAmount)
    FROM #EmployeeSales
    WHERE Department = e.Department
);

SELECT *
FROM #EmployeeSales e
WHERE EXISTS (
    SELECT 1
    FROM #EmployeeSales e2
    WHERE e2.SalesMonth = e.SalesMonth
      AND e2.SalesYear = e.SalesYear
    GROUP BY e2.SalesMonth, e2.SalesYear
    HAVING MAX(e2.SalesAmount) = e.SalesAmount
);

SELECT DISTINCT e.EmployeeName
FROM #EmployeeSales e
WHERE NOT EXISTS (
    SELECT DISTINCT SalesMonth, SalesYear
    FROM #EmployeeSales
    EXCEPT
    SELECT SalesMonth, SalesYear
    FROM #EmployeeSales e2
    WHERE e2.EmployeeName = e.EmployeeName
);

SELECT Name
FROM Products
WHERE Price > (SELECT AVG(Price) FROM Products);


SELECT Name
FROM Products
WHERE Stock < (SELECT MAX(Stock) FROM Products);

SELECT Name
FROM Products
WHERE Category = (SELECT Category FROM Products WHERE Name = 'Laptop');

SELECT Name
FROM Products
WHERE Price > (
    SELECT MIN(Price) FROM Products WHERE Category = 'Electronics'
);

SELECT Name
FROM Products p
WHERE Price > (
    SELECT AVG(Price)
    FROM Products
    WHERE Category = p.Category
);

SELECT DISTINCT p.Name
FROM Products p
JOIN Orders o ON p.ProductID = o.ProductID;

SELECT p.Name
FROM Products p
JOIN Orders o ON p.ProductID = o.ProductID
GROUP BY p.Name
HAVING SUM(o.Quantity) > (
    SELECT AVG(qty_sum)
    FROM (
        SELECT SUM(Quantity) qty_sum
        FROM Orders
        GROUP BY ProductID
    ) t
);

SELECT Name
FROM Products p
WHERE NOT EXISTS (
    SELECT 1 FROM Orders o WHERE o.ProductID = p.ProductID
);

SELECT TOP 1 p.Name
FROM Products p
JOIN Orders o ON p.ProductID = o.ProductID
GROUP BY p.Name
ORDER BY SUM(o.Quantity) DESC;
