SELECT 
    Id,
    LTRIM(RTRIM(LEFT(Name, CHARINDEX(',', Name) - 1))) AS Name,
    LTRIM(RTRIM(SUBSTRING(Name, CHARINDEX(',', Name) + 1, LEN(Name)))) AS Surname
FROM TestMultipleColumns
WHERE CHARINDEX(',', Name) > 0;

SELECT *
FROM TestPercent
WHERE Strs LIKE '%[%]%';

SELECT 
    Id,
    value AS Part
FROM Splitter
CROSS APPLY STRING_SPLIT(Vals, '.');

SELECT 
    TRANSLATE('1234ABC123456XYZ1234567890ADS', '0123456789', 'XXXXXXXXXX') AS ReplacedString;

SELECT *
FROM testDots
WHERE LEN(Vals) - LEN(REPLACE(Vals, '.', '')) > 2;

SELECT 
    texts,
    LEN(texts) - LEN(REPLACE(texts, ' ', '')) AS SpaceCount
FROM CountSpaces;

SELECT 
    E.Name AS EmployeeName,
    E.Salary AS EmployeeSalary,
    M.Name AS ManagerName,
    M.Salary AS ManagerSalary
FROM Employee E
JOIN Employee M ON E.ManagerId = M.Id
WHERE E.Salary > M.Salary;

SELECT 
    EMPLOYEE_ID,
    FIRST_NAME,
    LAST_NAME,
    HIRE_DATE,
    DATEDIFF(YEAR, HIRE_DATE, GETDATE()) AS YearsOfService
FROM Employees
WHERE DATEDIFF(YEAR, HIRE_DATE, GETDATE()) BETWEEN 10 AND 15;

SELECT 
    val,
    LEFT(val, PATINDEX('%[a-zA-Z]%', val + 'a') - 1) AS IntegerPart,
    STUFF(val, 1, PATINDEX('%[a-zA-Z]%', val + 'a') - 1, '') AS CharacterPart
FROM (
    SELECT 'rtcfvty34redt' AS val
) AS Sample;

SELECT 
    val,
    REPLACE(val, REPLACE(TRANSLATE(val, '0123456789', REPLICATE('X',10)), 'X', ''), '') AS CharactersOnly,
    REPLACE(val, TRANSLATE(val, 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz', REPLICATE('X',52)), 'X') AS NumbersOnly
FROM YourTable;

SELECT w1.Id
FROM Weather w1
JOIN Weather w2 ON DATEDIFF(DAY, w2.RecordDate, w1.RecordDate) = 1
WHERE w1.Temperature > w2.Temperature;


SELECT 
    player_id,
    MIN(login_date) AS first_login
FROM Activity
GROUP BY player_id;

SELECT fruit
FROM (
    SELECT fruit, ROW_NUMBER() OVER (ORDER BY fruit) AS rn
    FROM fruits
) AS Ranked
WHERE rn = 3;

WITH Numbers AS (
    SELECT TOP (LEN('sdgfhsdgfhs@121313131'))
        ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS n
    FROM sys.all_objects
)
SELECT 
    SUBSTRING('sdgfhsdgfhs@121313131', n, 1) AS Character
FROM Numbers;

SELECT 
    p1.id,
    p1.name,
    CASE 
        WHEN p1.code = 0 THEN p2.code
        ELSE p1.code
    END AS code
FROM p1
JOIN p2 ON p1.id = p2.id;

SELECT 
    EmployeeID,
    FirstName,
    LastName,
    HIRE_DATE,
    DATEDIFF(YEAR, HIRE_DATE, GETDATE()) AS YearsOfService,
    CASE
        WHEN DATEDIFF(YEAR, HIRE_DATE, GETDATE()) < 1 THEN 'New Hire'
        WHEN DATEDIFF(YEAR, HIRE_DATE, GETDATE()) BETWEEN 1 AND 5 THEN 'Junior'
        WHEN DATEDIFF(YEAR, HIRE_DATE, GETDATE()) BETWEEN 6 AND 10 THEN 'Mid-Level'
        WHEN DATEDIFF(YEAR, HIRE_DATE, GETDATE()) BETWEEN 11 AND 20 THEN 'Senior'
        ELSE 'Veteran'
    END AS EmploymentStage
FROM Employees;

SELECT 
    Vals,
    LEFT(Vals, PATINDEX('%[^0-9]%', Vals + 'x') - 1) AS LeadingInteger
FROM GetIntegers
WHERE Vals LIKE '[0-9]%';


