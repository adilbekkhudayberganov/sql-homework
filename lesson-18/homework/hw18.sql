CREATE TABLE #MonthlySales (
    ProductID INT,
    TotalQuantity INT,
    TotalRevenue DECIMAL(18,2)
);

INSERT INTO #MonthlySales (ProductID, TotalQuantity, TotalRevenue)
SELECT 
    s.ProductID,
    SUM(s.Quantity) AS TotalQuantity,
    SUM(s.Quantity * p.Price) AS TotalRevenue
FROM Sales s
JOIN Products p ON s.ProductID = p.ProductID
WHERE YEAR(s.SaleDate) = YEAR(GETDATE())
  AND MONTH(s.SaleDate) = MONTH(GETDATE())
GROUP BY s.ProductID;

SELECT * FROM #MonthlySales;

CREATE VIEW vw_ProductSalesSummary AS
SELECT 
    p.ProductID,
    p.ProductName,
    p.Category,
    SUM(s.Quantity) AS TotalQuantitySold
FROM Products p
LEFT JOIN Sales s ON p.ProductID = s.ProductID
GROUP BY p.ProductID, p.ProductName, p.Category;

CREATE FUNCTION fn_GetTotalRevenueForProduct (@ProductID INT)
RETURNS DECIMAL(18,2)
AS
BEGIN
    DECLARE @TotalRevenue DECIMAL(18,2);

    SELECT @TotalRevenue = SUM(s.Quantity * p.Price)
    FROM Sales s
    JOIN Products p ON s.ProductID = p.ProductID
    WHERE s.ProductID = @ProductID;

    RETURN ISNULL(@TotalRevenue, 0);
END;

CREATE FUNCTION fn_GetSalesByCategory (@Category VARCHAR(50))
RETURNS TABLE
AS
RETURN
(
    SELECT 
        p.ProductName,
        SUM(s.Quantity) AS TotalQuantity,
        SUM(s.Quantity * p.Price) AS TotalRevenue
    FROM Products p
    LEFT JOIN Sales s ON p.ProductID = s.ProductID
    WHERE p.Category = @Category
    GROUP BY p.ProductName
);

CREATE FUNCTION fn_IsPrime (@Number INT)
RETURNS VARCHAR(3)
AS
BEGIN
    DECLARE @i INT = 2;
    IF @Number <= 1 RETURN 'No';

    WHILE @i <= SQRT(@Number)
    BEGIN
        IF @Number % @i = 0 RETURN 'No';
        SET @i += 1;
    END
    RETURN 'Yes';
END;

CREATE FUNCTION fn_GetNumbersBetween (@Start INT, @End INT)
RETURNS TABLE
AS
RETURN
(
    WITH Numbers AS (
        SELECT @Start AS Number
        UNION ALL
        SELECT Number + 1
        FROM Numbers
        WHERE Number < @End
    )
    SELECT Number FROM Numbers
);

CREATE FUNCTION getNthHighestSalary(@N INT)
RETURNS INT
AS
BEGIN
    DECLARE @Result INT;

    WITH Ranked AS (
        SELECT DISTINCT salary, 
               DENSE_RANK() OVER (ORDER BY salary DESC) AS rnk
        FROM Employee
    )
    SELECT @Result = salary
    FROM Ranked
    WHERE rnk = @N;

    RETURN @Result;
END;

SELECT id, COUNT(*) AS num
FROM (
    SELECT requester_id AS id, accepter_id AS friend_id
    FROM RequestAccepted
    UNION ALL
    SELECT accepter_id AS id, requester_id AS friend_id
    FROM RequestAccepted
) AS AllFriends
GROUP BY id
ORDER BY num DESC
OFFSET 0 ROWS FETCH NEXT 1 ROWS ONLY;

CREATE VIEW vw_CustomerOrderSummary AS
SELECT 
    c.customer_id,
    c.name,
    COUNT(o.order_id) AS total_orders,
    SUM(o.amount) AS total_amount,
    MAX(o.order_date) AS last_order_date
FROM Customers c
LEFT JOIN Orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.name;

SELECT 
    RowNumber,
    FIRST_VALUE(TestCase) OVER (
        PARTITION BY grp 
        ORDER BY RowNumber
    ) AS Workflow
FROM (
    SELECT *,
           SUM(CASE WHEN TestCase IS NOT NULL THEN 1 ELSE 0 END) 
           OVER (ORDER BY RowNumber) AS grp
    FROM Gaps
) t
ORDER BY RowNumber;


