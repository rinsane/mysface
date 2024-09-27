-- View showing employee names and their managers' names:

CREATE VIEW EmployeeManagerView AS
SELECT e1.employee_name AS employee, e2.employee_name AS manager
FROM EmployeeManager em
JOIN Employee e1 ON em.employee_id = e1.employee_id
JOIN Employee e2 ON em.manager_id = e2.employee_id;

-- View showing the total sales made by each employee:

CREATE VIEW EmployeeSalesTotal AS
SELECT e.employee_name, SUM(s.amount) AS total_sales
FROM Sales s
JOIN Employee e ON s.employee_id = e.employee_id
GROUP BY e.employee_name;

-- View displaying the list of customers and the total amount of their orders:

CREATE VIEW CustomerOrderTotal AS
SELECT c.customer_name, SUM(o.amount) AS total_orders
FROM Orders o
JOIN Customer c ON o.customer_id = c.customer_id
GROUP BY c.customer_name;

-- View showing product names and their sales total:

CREATE VIEW ProductSalesTotal AS
SELECT p.product_name, SUM(o.amount) AS total_sales
FROM Orders o
JOIN Product p ON o.product_id = p.product_id
GROUP BY p.product_name;

-- View that shows the sales made by employees for each product:

CREATE VIEW EmployeeProductSales AS
SELECT e.employee_name, p.product_name, SUM(o.amount) AS sales
FROM Orders o
JOIN Sales s ON o.customer_id = s.employee_id
JOIN Employee e ON s.employee_id = e.employee_id
JOIN Product p ON o.product_id = p.product_id
GROUP BY e.employee_name, p.product_name;

-- View showing employees who do not have a manager:

CREATE VIEW EmployeesWithoutManager AS
SELECT e.employee_name
FROM Employee e
LEFT JOIN EmployeeManager em ON e.employee_id = em.employee_id
WHERE em.manager_id IS NULL;

-- View displaying orders made by customers along with the products they ordered:

CREATE VIEW CustomerOrdersProducts AS
SELECT c.customer_name, p.product_name, o.amount
FROM Orders o
JOIN Customer c ON o.customer_id = c.customer_id
JOIN Product p ON o.product_id = p.product_id;

-- View that shows the total amount of sales per product:

CREATE VIEW ProductTotalSales AS
SELECT p.product_name, SUM(s.amount) AS total_sales
FROM Sales s
JOIN Orders o ON s.employee_id = o.customer_id
JOIN Product p ON o.product_id = p.product_id
GROUP BY p.product_name;

-- View that displays all employees with more than one manager:

CREATE VIEW EmployeesWithMultipleManagers AS
SELECT e.employee_name
FROM EmployeeManager em
JOIN Employee e ON em.employee_id = e.employee_id
GROUP BY e.employee_name
HAVING COUNT(em.manager_id) > 1;

-- View showing the orders where the amount is greater than the average order amount:

CREATE VIEW OrdersAboveAverage AS
SELECT o.order_id, c.customer_name, o.amount
FROM Orders o
JOIN Customer c ON o.customer_id = c.customer_id
WHERE o.amount > (SELECT AVG(amount) FROM Orders);

-- View displaying the names of customers who have not made any orders:

CREATE VIEW CustomersWithoutOrders AS
SELECT c.customer_name
FROM Customer c
LEFT JOIN Orders o ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL;

-- View showing the top 3 products with the highest sales amounts:

CREATE VIEW Top3ProductsBySales AS
SELECT p.product_name, SUM(o.amount) AS total_sales
FROM Orders o
JOIN Product p ON o.product_id = p.product_id
GROUP BY p.product_name
ORDER BY total_sales DESC
LIMIT 3;

-- View showing all employees who haven't made any sales:

CREATE VIEW EmployeesWithoutSales AS
SELECT e.employee_name
FROM Employee e
LEFT JOIN Sales s ON e.employee_id = s.employee_id
WHERE s.sale_id IS NULL;

-- View that shows the highest sale made by each employee:

CREATE VIEW EmployeeHighestSale AS
SELECT e.employee_name, MAX(s.amount) AS highest_sale
FROM Sales s
JOIN Employee e ON s.employee_id = e.employee_id
GROUP BY e.employee_name;

-- View showing customers and their most expensive order:

CREATE VIEW CustomerMostExpensiveOrder AS
SELECT c.customer_name, MAX(o.amount) AS most_expensive_order
FROM Orders o
JOIN Customer c ON o.customer_id = c.customer_id
GROUP BY c.customer_name;

SHOW FULL TABLES WHERE TABLE_TYPE = 'VIEW';

-- viewing the views:
SELECT * FROM EmployeeManagerView;
SELECT * FROM EmployeeManagerView;
SELECT * FROM EmployeeSalesTotal;
SELECT * FROM CustomerOrderTotal;
SELECT * FROM ProductSalesTotal;
SELECT * FROM EmployeeProductSales;
SELECT * FROM EmployeesWithoutManager;
SELECT * FROM CustomerOrdersProducts;
SELECT * FROM ProductTotalSales;
SELECT * FROM EmployeesWithMultipleManagers;
SELECT * FROM OrdersAboveAverage;
SELECT * FROM CustomersWithoutOrders;
SELECT * FROM Top3ProductsBySales;
SELECT * FROM EmployeesWithoutSales;
SELECT * FROM EmployeeHighestSale;