Basic-Level Tasks (10)

CREATE TABLE Employees ( EmpID INT, Name VARCHAR(50),  Salary DECIMAL(10, 2));
Select * from Employees
INSERT INTO Employees VALUES (1, 'Aziza Abdullayeva', 6000);
INSERT INTO Employees VALUES (2, 'Laylo Karimova', 50000);
INSERT INTO Employees (EmpID, Name, Salary) 
VALUES (3, 'Ali Vohidov', 55000),
(4, 'Zarina Akhmedova', 6000);
UPDATE Employees SET Salary = 7000 WHERE EmpID = 1;
DELETE FROM Employees WHERE EmpID = 2;

Give a brief definition for difference between DELETE, TRUNCATE, and DROP.
DELETE Purpose: Removes specific rows from a table. TRUNCATE Purpose: Removes all rows from a table quickly.

Modify the Name column in the Employees table to VARCHAR(100).
ALTER TABLE Employees ALTER COLUMN Name VARCHAR(100);
ALTER TABLE Employees ADD Department VARCHAR(50);
ALTER TABLE Employees ALTER COLUMN Salary FLOAT;
CREATE TABLE Departments ( DepartmentID INT PRIMARY KEY, DepartmentName VARCHAR(50));
Select * from Departments
TRUNCATE TABLE Employees;
Select * from Employees



Intermediate-Level Tasks (6)

INSERT INTO Departments (DepartmentID, DepartmentName)
SELECT 1, 'Human Resources' UNION ALL
SELECT 2, 'Finance' UNION ALL
SELECT 3, 'IT Support' UNION ALL
SELECT 4, 'Marketing' UNION ALL
SELECT 5, 'Logistics';
Select * from Departments

UPDATE Employees SET Department = 'Management' WHERE Salary > 5000;
Select * from Employees
TRUNCATE TABLE Employees
ALTER TABLE Employees DROP COLUMN Department;
EXEC sp_rename 'Employees', 'StaffMembers';
Select * from StaffMembers
DROP TABLE Departments;


Advanced-Level Tasks (9)
CREATE TABLE Products (ProductID INT PRIMARY KEY, ProductName VARCHAR(100), Category VARCHAR(50), Price DECIMAL(10, 2),
StockQuantity INT);
Select * from Products
ALTER TABLE Products ADD CONSTRAINT chk_Price_Positive CHECK (Price > 0);
ALTER TABLE Products ADD StockQuantity INT DEFAULT 50;
ALTER TABLE Products ADD CONSTRAINT DF_StockQuantity_Default DEFAULT 50 FOR StockQuantity;
EXEC sp_rename 'Products.Category', 'ProductCategory', 'COLUMN';
INSERT INTO Products (ProductID, ProductName, ProductCategory, Price, StockQuantity)
VALUES (1, 'Wireless Mouse', 'Electronics', 25.99, 100);

INSERT INTO Products (ProductID, ProductName, ProductCategory, Price, StockQuantity)
VALUES (2, 'Notebook', 'Stationery', 3.50, 200);

INSERT INTO Products (ProductID, ProductName, ProductCategory, Price, StockQuantity)
VALUES (3, 'Water Bottle', 'Accessories', 12.75, 150);

INSERT INTO Products (ProductID, ProductName, ProductCategory, Price, StockQuantity)
VALUES (4, 'Bluetooth Speaker', 'Electronics', 45.00, 80);

INSERT INTO Products (ProductID, ProductName, ProductCategory, Price, StockQuantity)
VALUES (5, 'Desk Lamp', 'Furniture', 30.25, 60);
Select * from Products
SELECT * INTO Products_Backup FROM Products;
EXEC sp_rename 'Products', 'Inventory';
Select * from Inventory
ALTER TABLE Inventory ALTER COLUMN Price FLOAT;
ALTER TABLE Inventory DROP CONSTRAINT chk_Price_Positive;
ALTER TABLE Inventory ALTER COLUMN Price FLOAT;
ALTER TABLE Inventory ADD CONSTRAINT chk_Price_Positive CHECK (Price > 0);
CREATE TABLE Inventory_New (
    ProductCode INT IDENTITY(1000, 5) PRIMARY KEY,
    ProductID INT,
    ProductName VARCHAR(100),
    ProductCategory VARCHAR(50),
    Price FLOAT,
    StockQuantity INT);
  select * from Inventory_New
  DROP TABLE Inventory;
  EXEC sp_rename 'Inventory_New', 'Inventory';
  Select * from Inventory
