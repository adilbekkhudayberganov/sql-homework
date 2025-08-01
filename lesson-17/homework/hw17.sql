SELECT 
    ac.Region,
    ac.Distributor,
    ISNULL(rs.Sales, 0) AS Sales
FROM AllCombinations ac
LEFT JOIN #RegionSales rs
    ON rs.Region = ac.Region AND rs.Distributor = ac.Distributor
ORDER BY ac.Region, ac.Distributor;

SELECT e.name
FROM Employee e
JOIN (
    SELECT managerId
    FROM Employee
    WHERE managerId IS NOT NULL
    GROUP BY managerId
    HAVING COUNT(*) >= 5
) m ON e.id = m.managerId;

SELECT 
    p.product_name,
    SUM(o.unit) AS unit
FROM Orders o
JOIN Products p ON o.product_id = p.product_id
WHERE o.order_date >= '2020-02-01' AND o.order_date < '2020-03-01'
GROUP BY p.product_id, p.product_name
HAVING SUM(o.unit) >= 100;

WITH VendorOrderCounts AS (
    SELECT 
        CustomerID,
        Vendor,
        COUNT(*) AS OrderCount,
        ROW_NUMBER() OVER (
            PARTITION BY CustomerID 
            ORDER BY COUNT(*) DESC
        ) AS rn
    FROM Orders
    GROUP BY CustomerID, Vendor
)
SELECT CustomerID, Vendor
FROM VendorOrderCounts
WHERE rn = 1;

DECLARE @Check_Prime INT = 91;
DECLARE @i INT = 2;
DECLARE @isPrime BIT = 1;

-- Numbers less than 2 are not prime
IF @Check_Prime < 2
BEGIN
    SET @isPrime = 0;
END
ELSE
BEGIN
    WHILE @i * @i <= @Check_Prime
    BEGIN
        IF @Check_Prime % @i = 0
        BEGIN
            SET @isPrime = 0;
            BREAK;
        END
        SET @i = @i + 1;
    END
END

-- Output the result
IF @isPrime = 1
    PRINT 'This number is prime';
ELSE
    PRINT 'This number is not prime';

WITH SignalCounts AS (
    SELECT 
        Device_id,
        Locations,
        COUNT(*) AS signal_count
    FROM Device
    GROUP BY Device_id, Locations
),
TotalSignals AS (
    SELECT 
        Device_id,
        COUNT(*) AS no_of_signals,
        COUNT(DISTINCT Locations) AS no_of_location
    FROM Device
    GROUP BY Device_id
),
MaxLocation AS (
    SELECT 
        Device_id,
        Locations AS max_signal_location,
        ROW_NUMBER() OVER (PARTITION BY Device_id ORDER BY signal_count DESC) AS rn
    FROM SignalCounts
)

SELECT 
    t.Device_id,
    t.no_of_location,
    m.max_signal_location,
    t.no_of_signals
FROM TotalSignals t
JOIN MaxLocation m
    ON t.Device_id = m.Device_id AND m.rn = 1
ORDER BY t.Device_id;

WITH SalaryWithAvg AS (
    SELECT 
        EmpID, EmpName, Salary, DeptID,
        AVG(Salary) OVER (PARTITION BY DeptID) AS avg_dept_salary
    FROM Employee
)
SELECT EmpID, EmpName, Salary
FROM SalaryWithAvg
WHERE Salary > avg_dept_salary;

WITH TicketMatches AS (
    SELECT 
        t.TicketID,
        COUNT(*) AS matched_numbers
    FROM Tickets t
    JOIN Numbers n ON t.Number = n.Number
    GROUP BY t.TicketID
),
Winnings AS (
    SELECT 
        TicketID,
        CASE 
            WHEN matched_numbers = 3 THEN 100
            WHEN matched_numbers BETWEEN 1 AND 2 THEN 10
            ELSE 0
        END AS prize
    FROM TicketMatches
)
SELECT SUM(prize) AS total_winnings
FROM Winnings;

WITH UsageType AS (
    SELECT 
        User_id,
        Spend_date,
        MAX(CASE WHEN Platform = 'Mobile' THEN 1 ELSE 0 END) AS used_mobile,
        MAX(CASE WHEN Platform = 'Desktop' THEN 1 ELSE 0 END) AS used_desktop,
        SUM(Amount) AS total_amount
    FROM Spending
    GROUP BY User_id, Spend_date
),
Classified AS (
    SELECT 
        Spend_date,
        CASE 
            WHEN used_mobile = 1 AND used_desktop = 1 THEN 'Both'
            WHEN used_mobile = 1 AND used_desktop = 0 THEN 'Mobile'
            WHEN used_mobile = 0 AND used_desktop = 1 THEN 'Desktop'
        END AS Platform,
        total_amount,
        User_id
    FROM UsageType
),
FinalAgg AS (
    SELECT 
        Spend_date,
        Platform,
        SUM(total_amount) AS Total_Amount,
        COUNT(DISTINCT User_id) AS Total_users
    FROM Classified
    GROUP BY Spend_date, Platform
),
AllDatesPlatforms AS (
    -- Ensure all platform types appear for each Spend_date
    SELECT DISTINCT d.Spend_date, p.Platform
    FROM Spending d
    CROSS JOIN (SELECT 'Mobile' AS Platform UNION ALL SELECT 'Desktop' UNION ALL SELECT 'Both') p
)
SELECT 
    ROW_NUMBER() OVER (ORDER BY adp.Spend_date, 
        CASE adp.Platform 
            WHEN 'Mobile' THEN 1
            WHEN 'Desktop' THEN 2
            WHEN 'Both' THEN 3
        END) AS Row,
    adp.Spend_date,
    adp.Platform,
    ISNULL(f.Total_Amount, 0) AS Total_Amount,
    ISNULL(f.Total_users, 0) AS Total_users
FROM AllDatesPlatforms adp
LEFT JOIN FinalAgg f
    ON adp.Spend_date = f.Spend_date AND adp.Platform = f.Platform
ORDER BY adp.Spend_date, adp.Platform;

WITH Numbers AS (
    SELECT 1 AS n
    UNION ALL
    SELECT n + 1
    FROM Numbers
    WHERE n < (SELECT MAX(Quantity) FROM Grouped)
)
SELECT 
    g.Product,
    1 AS Quantity
FROM Grouped g
JOIN Numbers n ON n.n <= g.Quantity
ORDER BY g.Product
OPTION (MAXRECURSION 1000); 
