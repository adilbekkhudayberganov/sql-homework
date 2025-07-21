SELECT DISTINCT
    CASE WHEN col1 < col2 THEN col1 ELSE col2 END AS col1,
    CASE WHEN col1 < col2 THEN col2 ELSE col1 END AS col2
FROM InputTbl;

SELECT * 
FROM TestMultipleZero
WHERE NOT (ISNULL(A, 0) = 0 AND ISNULL(B, 0) = 0 AND ISNULL(C, 0) = 0 AND ISNULL(D, 0) = 0);

SELECT TOP 1 * 
FROM section1
ORDER BY id ASC;

SELECT TOP 1 * 
FROM section1
ORDER BY id DESC;

SELECT * 
FROM section1
WHERE name LIKE 'b%';
