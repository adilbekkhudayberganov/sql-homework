SELECT CONCAT(employee_id, '-', first_name, ' ', last_name)  output
FROM employees
WHERE EMPLOYEE_ID = 100;

UPDATE employees
SET phone_number = REPLACE(phone_number, '124', '999')
WHERE phone_number LIKE '%124%';

SELECT 
    first_name AS [First Name],
    LEN(first_name) AS [Name Length]
FROM employees
WHERE LEFT(first_name, 1) IN ('A', 'J', 'M')
ORDER BY first_name;

SELECT 
    manager_id,
    SUM(salary) AS total_salary
FROM employees
WHERE manager_id IS NOT NULL
GROUP BY manager_id;

SELECT 
    manager_id,
    SUM(salary) AS total_salary
FROM employees
GROUP BY manager_id;

SELECT *
FROM cinema
WHERE id % 2 = 1
  AND description <> 'boring'

SELECT *
FROM SingleOrder
ORDER BY CASE WHEN Id = 0 THEN 1 ELSE 0 END

SELECT 
    id,
    COALESCE(ssn, passportid, itin) AS first_non_null_value
FROM person;

SELECT
    FullName,
    PARSENAME(REPLACE(FullName, ' ', '.'), 3) AS Firstname,
    PARSENAME(REPLACE(FullName, ' ', '.'), 2) AS Middlename,
    PARSENAME(REPLACE(FullName, ' ', '.'), 1) AS Lastname
FROM Students;

SELECT *
FROM Orders
WHERE customer_id IN (
    SELECT DISTINCT customer_id
    FROM Orders
    WHERE delivery_state = 'California'
)
AND delivery_state = 'Texas';

SELECT group_col, STRING_AGG(value_col, ', ') AS concatenated_values
FROM DMLTable
GROUP BY group_col;

SELECT group_col, GROUP_CONCAT(value_col ORDER BY value_col SEPARATOR ', ') AS concatenated_values
FROM DMLTable
GROUP BY group_col;

SELECT *
FROM Employees
WHERE LEN(REPLACE(REPLACE(LOWER(first_name + last_name), 'a', ''), 'A', '')) <= 
      LEN(LOWER(first_name + last_name)) - 3;

SELECT 
    department_id,
    COUNT(*) AS total_employees,
    SUM(CASE WHEN DATEDIFF(YEAR, hire_date, GETDATE()) > 3 THEN 1 ELSE 0 END) * 100.0 / COUNT(*) AS percentage_over_3_years
FROM Employees
GROUP BY department_id;

SELECT job_description, 
       MIN(spaceman_id) KEEP (DENSE_RANK FIRST ORDER BY years_experience) AS least_experienced,
       MAX(spaceman_id) KEEP (DENSE_RANK FIRST ORDER BY years_experience DESC) AS most_experienced
FROM Personal
GROUP BY job_description;


