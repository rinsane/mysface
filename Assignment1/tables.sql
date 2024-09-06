-- Show all databases
SHOW DATABASES;
DROP DATABASE Company;

-- Crete database Company
CREATE DATABASE Company;

-- Using database Company
USE Company;

-- Showing tables in Company
SHOW TABLES;

-- Select user, host, and plugin information for the 'root' user in the MySQL user table
SELECT user, host, plugin 
FROM mysql.user 
WHERE user = 'root';

-- Create Employee table
CREATE TABLE Employee (
    employee_id INT PRIMARY KEY,          -- Primary key constraint to uniquely identify each employee
    employee_name VARCHAR(100) NOT NULL,  -- NOT NULL constraint to ensure employee name is provided
    department_id INT NOT NULL            -- NOT NULL constraint to ensure department_id is provided
);

-- Create EmployeeManager table
CREATE TABLE EmployeeManager (
    employee_id INT,                      -- Foreign key reference to Employee table
    manager_id INT,                       -- Foreign key reference to Employee table
    PRIMARY KEY (employee_id, manager_id),-- Composite primary key on both columns to ensure uniqueness
    FOREIGN KEY (employee_id) 
        REFERENCES Employee(employee_id) 
        ON DELETE CASCADE,                -- Cascade delete to remove associations when an employee is deleted
    FOREIGN KEY (manager_id) 
        REFERENCES Employee(employee_id)  -- Foreign key to ensure manager exists in Employee table
);

-- Create Customer table
CREATE TABLE Customer (
    customer_id INT PRIMARY KEY,          -- Primary key to uniquely identify each customer
    customer_name VARCHAR(100) NOT NULL   -- NOT NULL constraint to ensure customer name is provided
);

-- Create Product table
CREATE TABLE Product (
    product_id INT PRIMARY KEY,           -- Primary key to uniquely identify each product
    product_name VARCHAR(100) NOT NULL,   -- NOT NULL constraint to ensure product name is provided
    price DECIMAL(10, 2) NOT NULL         -- Using DECIMAL for monetary values, NOT NULL to ensure price is provided
);

-- Create Orders table
CREATE TABLE Orders (
    order_id INT PRIMARY KEY,             -- Primary key to uniquely identify each order
    customer_id INT NOT NULL,             -- Foreign key reference to Customer table, NOT NULL constraint
    product_id INT NOT NULL,              -- Foreign key reference to Product table, NOT NULL constraint
    amount DECIMAL(10, 2) NOT NULL,       -- Using DECIMAL for monetary values, NOT NULL to ensure amount is provided
    FOREIGN KEY (customer_id) 
        REFERENCES Customer(customer_id) 
        ON DELETE CASCADE,                -- Cascade delete to remove orders when a customer is deleted
    FOREIGN KEY (product_id) 
        REFERENCES Product(product_id) 
        ON DELETE CASCADE                 -- Cascade delete to remove orders when a product is deleted
);

-- Create Sales table
CREATE TABLE Sales (
    sale_id INT PRIMARY KEY,              -- Primary key to uniquely identify each sale
    employee_id INT NOT NULL,             -- Foreign key reference to Employee table, NOT NULL constraint
    amount DECIMAL(10, 2) NOT NULL,       -- Using DECIMAL for monetary values, NOT NULL to ensure amount is provided
    FOREIGN KEY (employee_id) 
        REFERENCES Employee(employee_id) 
        ON DELETE CASCADE                 -- Cascade delete to remove sales when an employee is deleted
);

-- Data Insertion for Employee table
INSERT INTO Employee (employee_id, employee_name, department_id)
VALUES 
    (1, 'Alice', 101),
    (2, 'Bob', 102),
    (3, 'Charlie', 103),
    (4, 'David', 104),
    (5, 'Eve', 105);

-- Data Insertion for EmployeeManager table
INSERT INTO EmployeeManager (employee_id, manager_id)
VALUES 
    (1, 3), 
    (2, 3), 
    (3, 4), 
    (4, 3);

-- Data Insertion for Customer table
INSERT INTO Customer (customer_id, customer_name)
VALUES 
    (201, 'John Doe'),
    (202, 'Jane Smith'),
    (203, 'Bob Johnson'),
    (204, 'Alice Williams'),
    (205, 'Eve Adams');

-- Data Insertion for Product table
INSERT INTO Product (product_id, product_name, price)
VALUES 
    (101, 'Laptop', 1000),
    (102, 'Smartphone', 800),
    (103, 'Tablet', 500),
    (104, 'Monitor', 300),
    (105, 'Keyboard', 100);

-- Data Insertion for Orders table
INSERT INTO Orders (order_id, customer_id, product_id, amount)
VALUES 
    (1, 201, 101, 1000),
    (2, 202, 102, 1600),
    (3, 203, 103, 1000),
    (4, 204, 101, 1000),
    (5, 205, 104, 300),
    (6, 201, 102, 800);

-- Data Insertion for Sales table
INSERT INTO Sales (sale_id, employee_id, amount)
VALUES 
    (1, 1, 500),
    (2, 2, 1500),
    (3, 1, 1000),
    (4, 3, 700),
    (5, 5, 1200);
