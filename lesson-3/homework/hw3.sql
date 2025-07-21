1. Define and explain the purpose of BULK INSERT in SQL Server
  
BULK INSERT is a Transact-SQL command used to import a large volume of data from a text file (like CSV or TSV) into a SQL Server table quickly and efficiently.

Purpose:

To transfer data from flat files to SQL Server tables.

Useful for importing external data (e.g., from Excel, exports, logs).

Much faster than inserting records one by one.

  2. List four file formats that can be imported into SQL Server
CSV (Comma-Separated Values)

TXT (Plain text file with delimiters like tab or pipe)

XML (via OPENXML, BULK INSERT with format file, or XML data type)

JSON (using OPENJSON or SQL Server Integration Services)

3. Create a table Products
sql
Copy
Edit
CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(50),
    Price DECIMAL(10,2)
);

4. Insert three records into the Products table
sql
Copy
Edit
INSERT INTO Products (ProductID, ProductName, Price) VALUES
(1, 'Laptop', 799.99),
(2, 'Smartphone', 499.50),
(3, 'Headphones', 89.99);

5. Explain the difference between NULL and NOT NULL
NULL means the column can have no value (i.e., unknown or missing).

NOT NULL means the column must have a value; it cannot be left empty.

Constraint	Meaning
NULL	Allows empty (null) values
NOT NULL	Requires a value in every row

6. Add a UNIQUE constraint to the ProductName column
sql
Copy
Edit
ALTER TABLE Products
ADD CONSTRAINT UQ_ProductName UNIQUE (ProductName);

7. Write a comment in a SQL query explaining its purpose
sql
Copy
Edit
-- This query retrieves all products with a price above $100
SELECT * FROM Products
WHERE Price > 100;

8. Add CategoryID column to the Products table
sql
Copy
Edit
ALTER TABLE Products
ADD CategoryID INT;

9. Create a Categories table
sql
Copy
Edit
CREATE TABLE Categories (
    CategoryID INT PRIMARY KEY,
    CategoryName VARCHAR(50) UNIQUE
);

10. Explain the purpose of the IDENTITY column in SQL Server
An IDENTITY column is used to auto-generate incremental numeric values for each new row.
It's commonly used for primary keys.

Syntax:

sql
Copy
Edit
ProductID INT IDENTITY(1,1) PRIMARY KEY
1,1 means start at 1 and increment by 1.

It simplifies data entry by eliminating the need to manually specify unique IDs.

1. Use BULK INSERT to import data into the Products table from a text file
Assume you have a text file C:\Data\products.txt with data in the format:
ProductID,ProductName,Price,CategoryID

sql
Copy
Edit
BULK INSERT Products
FROM 'C:\Data\products.txt'
WITH (
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    FIRSTROW = 2 -- skip header row if present
);

2. Create a FOREIGN KEY in the Products table referencing Categories
sql
Copy
Edit
ALTER TABLE Products
ADD CONSTRAINT FK_Products_Categories
FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID);

 3. Explain the difference between PRIMARY KEY and UNIQUE KEY
Feature	PRIMARY KEY	UNIQUE KEY
Purpose	Uniquely identifies each row	Ensures uniqueness of values
NULL Allowed?	❌ Not allowed	✅ One NULL (or multiple in some DBMS)
Number Allowed	Only one per table	Can be multiple per table
Default Index	Clustered (by default)	Non-clustered (by default)

4. Add a CHECK constraint to ensure Price > 0
sql
Copy
Edit
ALTER TABLE Products
ADD CONSTRAINT CHK_Price_Positive CHECK (Price > 0);

5. Modify the Products table to add a Stock column (INT, NOT NULL)
If there are existing rows, you must provide a default value:

sql
Copy
Edit
ALTER TABLE Products
ADD Stock INT NOT NULL DEFAULT 0;

 6. Use ISNULL to replace NULL values in the Price column with 0
sql
Copy
Edit
SELECT 
    ProductID,
    ProductName,
    ISNULL(Price, 0) AS Price,
    Stock
FROM Products;

7. Describe the purpose and usage of FOREIGN KEY constraints
A FOREIGN KEY enforces referential integrity between two tables by ensuring that a value in one table (child) must exist in another table (parent).

Purpose:

Ensures consistency and validity of data between related tables.

Prevents orphan records (e.g., product with invalid category).

Usage Example:

sql
Copy
Edit
FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID)

