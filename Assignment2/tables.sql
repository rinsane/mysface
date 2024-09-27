-- Show all databases
SHOW DATABASES;
DROP DATABASE Company2;

-- Create database Company
CREATE DATABASE Company2;

-- Using database Company
USE Company2;

-- Creating Employees Table
CREATE TABLE Employees (
    emp_id INT PRIMARY KEY,
    name VARCHAR(100),
    age INT,
    department_id INT,
    salary DECIMAL(10, 2)
);

-- Inserting Sample Data into Employees
INSERT INTO Employees (emp_id, name, age, department_id, salary) VALUES
(1, 'John Doe', 35, 101, 55000.00),
(2, 'Jane Smith', 28, 102, 48000.00),
(3, 'Samuel Johnson', 45, 101, 62000.00),
(4, 'Emily Davis', 30, 103, 50000.00);

-- Creating Departments Table
CREATE TABLE Departments (
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(100),
    location VARCHAR(100)
);

-- Inserting Sample Data into Departments
INSERT INTO Departments (dept_id, dept_name, location) VALUES
(101, 'HR', 'New York'),
(102, 'Engineering', 'San Francisco'),
(103, 'Marketing', 'Los Angeles');

-- Creating Projects Table
CREATE TABLE Projects (
    proj_id INT PRIMARY KEY,
    proj_name VARCHAR(100),
    dept_id INT,
    budget DECIMAL(10, 2),
    FOREIGN KEY (dept_id) REFERENCES Departments(dept_id)
);

-- Inserting Sample Data into Projects
INSERT INTO Projects (proj_id, proj_name, dept_id, budget) VALUES
(201, 'Project A', 101, 150000.00),
(202, 'Project B', 102, 200000.00),
(203, 'Project C', 103, 180000.00);

-- Creating Works_On Table
CREATE TABLE Works_On (
    emp_id INT,
    proj_id INT,
    hours DECIMAL(5, 2),
    FOREIGN KEY (emp_id) REFERENCES Employees(emp_id),
    FOREIGN KEY (proj_id) REFERENCES Projects(proj_id),
    PRIMARY KEY (emp_id, proj_id)
);

-- Inserting Sample Data into Works_On
INSERT INTO Works_On (emp_id, proj_id, hours) VALUES
(1, 201, 35.5),
(2, 202, 40.0),
(3, 201, 28.0),
(4, 203, 32.5);

-- Creating Salaries Table
CREATE TABLE Salaries (
    emp_id INT,
    year INT,
    annual_salary DECIMAL(10, 2),
    FOREIGN KEY (emp_id) REFERENCES Employees(emp_id),
    PRIMARY KEY (emp_id, year)
);

-- Inserting Sample Data into Salaries
INSERT INTO Salaries (emp_id, year, annual_salary) VALUES
(1, 2022, 54000.00),
(1, 2023, 55000.00),
(2, 2022, 47000.00),
(2, 2023, 48000.00),
(3, 2022, 61000.00),
(3, 2023, 62000.00),
(4, 2022, 49000.00),
(4, 2023, 50000.00);

