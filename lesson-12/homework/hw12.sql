SELECT p.firstName, p.lastName, a.city, a.state
FROM Person p
LEFT JOIN Address a ON p.personId = a.personId;

SELECT e.name AS Employee
FROM Employee e
JOIN Employee m ON e.managerId = m.id
WHERE e.salary > m.salary;

SELECT email
FROM Person
GROUP BY email
HAVING COUNT(*) > 1;

DELETE FROM Person
WHERE id NOT IN (
    SELECT MIN(id)
    FROM Person
    GROUP BY email
);

SELECT DISTINCT g.ParentName
FROM girls g
WHERE g.ParentName NOT IN (
    SELECT ParentName FROM boys
);

SELECT 
    custid,
    SUM(val) AS total_sales_over_50,
    MIN(qty) AS least_weight
FROM Sales.Orders
WHERE qty > 50
GROUP BY custid;

SELECT 
    c1.Item AS [Item Cart 1],
    c2.Item AS [Item Cart 2]
FROM Cart1 c1
FULL OUTER JOIN Cart2 c2 ON c1.Item = c2.Item;


SELECT name AS Customers
FROM Customers
WHERE id NOT IN (
    SELECT customerId FROM Orders
);

SELECT 
    s.student_id,
    s.student_name,
    subj.subject_name,
    COUNT(e.subject_name) AS attended_exams
FROM Students s
CROSS JOIN Subjects subj
LEFT JOIN Examinations e
    ON s.student_id = e.student_id AND subj.subject_name = e.subject_name
GROUP BY s.student_id, s.student_name, subj.subject_name
ORDER BY s.student_id, subj.subject_name;


