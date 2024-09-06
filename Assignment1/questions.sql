-- Show all databases
SHOW DATABASES;

-- Create database Company
CREATE DATABASE Company;

-- Using database Company
USE Company;

-- Q1. Find Employees Who Have More Than One Manager
-- Description: Retrieve the names of employees who have more than one manager.

-- Relational Algebra:
-- EMP_MANAGERS = π_employee_id, manager_id(EmployeeManager)
-- EMP_MULTI_MANAGERS = σ_count(*)>1(γ_employee_id, count(manager_id)(EMP_MANAGERS))
-- RESULT = π_employee_name(EMP_MULTI_MANAGERS ⨝ Employee)

SELECT e.employee_name
FROM Employee e
JOIN EmployeeManager em ON e.employee_id = em.employee_id
GROUP BY em.employee_id
HAVING COUNT(em.manager_id) > 1;


-- Q2. Find Products That Have Never Been Ordered
-- Description: List all product names that have never been included in any order.

-- Relational Algebra:
-- PRODUCT_ORDER = π_product_id(Order)
-- PRODUCT_NO_ORDER = Product - PRODUCT_ORDER
-- RESULT = π_product_name(PRODUCT_NO_ORDER)

SELECT product_name
FROM Product
WHERE product_id NOT IN (SELECT DISTINCT product_id FROM Orders);


-- Q3. Get the Top 5 Customers by Total Sales
-- Description: Find the top 5 customers by the total amount of their purchases.

-- Relational Algebra:
-- SALES = γ_customer_id, sum(amount)(Order)
-- TOP5_SALES = τ_sum(amount)(SALES)
-- RESULT = π_customer_id(ρ_TOP5_SALES(TOP5_SALES))

SELECT customer_id, SUM(amount) AS total_sales
FROM Orders
GROUP BY customer_id
ORDER BY total_sales DESC
LIMIT 5;


-- Q4. Find Employees Who Have Never Made a Sale
-- Description: List all employee names who have never made a sale.

-- Relational Algebra:
-- EMP_SALES = π_employee_id(Sales)
-- EMP_NO_SALES = Employee - EMP_SALES
-- RESULT = π_employee_name(EMP_NO_SALES)

SELECT employee_name
FROM Employee
WHERE employee_id NOT IN (SELECT DISTINCT employee_id FROM Sales);


-- Q5. List Customers Who Have Purchased All Products
-- Description: Find customers who have purchased all available products.

-- Relational Algebra:
-- CUSTOMER_PRODUCTS = π_customer_id, product_id(Order)
-- ALL_PRODUCTS = π_product_id(Product)
-- RESULT = γ_customer_id, COUNT(product_id)(CUSTOMER_PRODUCTS) ÷ COUNT(ALL_PRODUCTS)

SELECT customer_id
FROM Orders
GROUP BY customer_id
HAVING COUNT(DISTINCT product_id) = (SELECT COUNT(*) FROM Product);


-- Q6. Find All Managers With No Direct Reports
-- Description: Retrieve the names of all managers who do not have any direct reports.

-- Relational Algebra:
-- MANAGERS = π_manager_id(EmployeeManager)
-- ALL_EMPLOYEES = π_employee_id(Employee)
-- MANAGERS_NO_REPORTS = MANAGERS - ALL_EMPLOYEES
-- RESULT = π_manager_name(MANAGERS_NO_REPORTS ⨝ Employee)

SELECT e.employee_name
FROM Employee e
LEFT JOIN EmployeeManager em ON e.employee_id = em.manager_id
WHERE em.employee_id IS NULL;


-- Q7. Find the Department With the Most Employees
-- Description: Identify the department that has the highest number of employees.

-- Relational Algebra:
-- EMP_COUNT = γ_department_id, COUNT(employee_id)(Employee)
-- MAX_EMP_COUNT = τ_COUNT(employee_id)(EMP_COUNT)
-- RESULT = π_department_id(MAX_EMP_COUNT)

SELECT department_id
FROM Employee
GROUP BY department_id
ORDER BY COUNT(employee_id) DESC
LIMIT 1;


-- Q8. List All Products Purchased by More Than 100 Customers
-- Description: Find all product names that have been purchased by more than 100 unique customers.

-- Relational Algebra:
-- PRODUCT_CUSTOMERS = γ_product_id, COUNT(DISTINCT customer_id)(Order)
-- RESULT = σ_COUNT(customer_id)>100(PRODUCT_CUSTOMERS) ⨝ Product

SELECT p.product_name
FROM Product p
JOIN Orders o ON o.product_id = p.product_id
GROUP BY o.product_id
HAVING COUNT(DISTINCT customer_id) > 100;


-- Q9. Find Customers Who Have Only Ordered the Most Expensive Product
-- Description: Retrieve the customer names who have exclusively ordered the most expensive product.

-- Relational Algebra:
-- MAX_PRICE = MAX(π_price(Product))
-- MAX_PRODUCT = σ_price=MAX_PRICE(Product)
-- EXCLUSIVE_CUSTOMERS = π_customer_id(Order ⨝ MAX_PRODUCT)
-- ALL_CUSTOMERS = π_customer_id(Order)
-- RESULT = EXCLUSIVE_CUSTOMERS - ALL_CUSTOMERS

WITH MaxPriceProduct AS (
    SELECT product_id
    FROM Product
    WHERE price = (SELECT MAX(price) FROM Product)
)
SELECT customer_id
FROM Orders
WHERE product_id IN (SELECT product_id FROM MaxPriceProduct)
GROUP BY customer_id
HAVING COUNT(DISTINCT product_id) = 1;


-- Q10. List Employees Who Are Also Customers
-- Description: Find employees who are also listed as customers.

-- Relational Algebra:
-- EMPLOYEE_CUSTOMERS = Employee ⋈ Customer
-- RESULT = π_employee_id, employee_name(EMPLOYEE_CUSTOMERS)

SELECT e.employee_id, e.employee_name
FROM Employee e
JOIN Customer c ON e.employee_id = c.customer_id;
