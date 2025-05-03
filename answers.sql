-- -------------------------------------
-- Assignment: Database Design and Normalization
-- Author: [Your Name]
-- Task: Achieve 1NF and 2NF
-- -------------------------------------

-- Clean up if tables already exist
DROP TABLE IF EXISTS ProductDetail;
DROP TABLE IF EXISTS ProductDetail_1NF;
DROP TABLE IF EXISTS OrderDetails;
DROP TABLE IF EXISTS Customers;
DROP TABLE IF EXISTS OrderItems;

-- -------------------------------
-- QUESTION 1: Achieving 1NF
-- -------------------------------

-- Original table with multivalued column
CREATE TABLE ProductDetail (
    OrderID INT,
    CustomerName VARCHAR(100),
    Products VARCHAR(255)
);

-- Insert sample data with multiple products per row
INSERT INTO ProductDetail (OrderID, CustomerName, Products) VALUES
(101, 'John Doe', 'Laptop, Mouse'),
(102, 'Jane Smith', 'Tablet, Keyboard, Mouse'),
(103, 'Emily Clark', 'Phone');

-- Normalized table to satisfy 1NF (1 product per row)
CREATE TABLE ProductDetail_1NF (
    OrderID INT,
    CustomerName VARCHAR(100),
    Product VARCHAR(50)
);

-- Insert normalized data manually (1NF)
INSERT INTO ProductDetail_1NF (OrderID, CustomerName, Product) VALUES
(101, 'John Doe', 'Laptop'),
(101, 'John Doe', 'Mouse'),
(102, 'Jane Smith', 'Tablet'),
(102, 'Jane Smith', 'Keyboard'),
(102, 'Jane Smith', 'Mouse'),
(103, 'Emily Clark', 'Phone');

-- -------------------------------
-- QUESTION 2: Achieving 2NF
-- -------------------------------

-- Original 1NF-compliant table with partial dependency
CREATE TABLE OrderDetails (
    OrderID INT,
    CustomerName VARCHAR(100),
    Product VARCHAR(50),
    Quantity INT
);

-- Insert sample data with partial dependency
INSERT INTO OrderDetails (OrderID, CustomerName, Product, Quantity) VALUES
(101, 'John Doe', 'Laptop', 2),
(101, 'John Doe', 'Mouse', 1),
(102, 'Jane Smith', 'Tablet', 3),
(102, 'Jane Smith', 'Keyboard', 1),
(102, 'Jane Smith', 'Mouse', 2),
(103, 'Emily Clark', 'Phone', 1);

-- Step 1: Create Customers table to remove partial dependency
CREATE TABLE Customers (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(100)
);

-- Insert unique order-customer pairs
INSERT INTO Customers (OrderID, CustomerName) VALUES
(101, 'John Doe'),
(102, 'Jane Smith'),
(103, 'Emily Clark');

-- Step 2: Create OrderItems table with proper foreign key
CREATE TABLE OrderItems (
    OrderID INT,
    Product VARCHAR(50),
    Quantity INT,
    FOREIGN KEY (OrderID) REFERENCES Customers(OrderID)
);

-- Insert product-quantity records only (no redundancy)
INSERT INTO OrderItems (OrderID, Product, Quantity) VALUES
(101, 'Laptop', 2),
(101, 'Mouse', 1),
(102, 'Tablet', 3),
(102, 'Keyboard', 1),
(102, 'Mouse', 2),
(103, 'Phone', 1);

-- -------------------------------
-- Final SELECT statements
-- -------------------------------
-- View results from normalization
SELECT * FROM ProductDetail_1NF;
SELECT * FROM Customers;
SELECT * FROM OrderItems;
