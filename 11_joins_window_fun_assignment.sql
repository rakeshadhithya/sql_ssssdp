-- JOINS, WINDOWS WITHOUT GROUPING

SET SQL_SAFE_UPDATES = 0;

USE ssssdp;
SHOW TABLES;
-- DROP TABLES IF NEEDED
DROP TABLE sales;
DROP TABLE employees;
DROP TABLE departments;
DROP TABLE projects;


CREATE TABLE departments(
	dept_id INT PRIMARY KEY,
    dept_name VARCHAR(50),
    location VARCHAR(50)
);

CREATE TABLE projects(
	project_id INT PRIMARY KEY,
    dept_id INT,
    project_name VARCHAR(50)
);

CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50),
    dept_id INT,
    project_id INT,
    manager_id INT,
    CONSTRAINT fk_dept FOREIGN KEY(dept_id) REFERENCES departments(dept_id),
    CONSTRAINT fk_project FOREIGN KEY(project_id) REFERENCES projects(project_id)
);

CREATE TABLE sales(
	sale_id INT PRIMARY KEY,
    emp_id INT,
    sale_date DATE,
    sale_amount INT,
    CONSTRAINT fk_emp FOREIGN KEY(emp_id) REFERENCES employees(emp_id)
);


INSERT INTO Departments (dept_id, dept_name, location) VALUES
(10, 'HR',        'New York'),
(20, 'Finance',   'London'),
(30, 'IT',        'New York'),
(40, 'Sales',     'Chicago'),
(50, 'Marketing', 'Chicago');

INSERT INTO Projects (project_id, dept_id, project_name) VALUES
(100, 20, 'Budgeting'),
(101, 10, 'Recruitment'),
(102, 30, 'Migration'),
(103, 50, 'Campaign'),
(104, 40, 'Client Acquisition');

INSERT INTO Employees (emp_id, emp_name, dept_id, project_id, manager_id) VALUES
(1, 'Alice',   10, 101, NULL),   -- Manager
(2, 'Bob',     10, 101, 1),      -- Reports to Alice
(3, 'Charlie', 20, 100, 1),      -- Reports to Alice
(4, 'David',   30, 102, 2),      -- Reports to Bob
(5, 'Eve',     40, NULL, 3),     -- No project
(6, 'Frank',   50, 103, 3),      -- Reports to Charlie
(7, 'Grace',   20, 104, 1),      -- Working on project from different dept
(8, 'Hannah',  30, NULL, 4);     -- IT dept, no project

INSERT INTO Sales (sale_id, emp_id, sale_date, sale_amount) VALUES
(1, 2, '2025-01-01', 500),
(2, 2, '2025-01-05', 700),
(3, 2, '2025-01-10', 400),
(4, 3, '2025-01-03', 600),
(5, 3, '2025-01-07', 800),
(6, 3, '2025-01-12', 750),
(7, 5, '2025-01-04', 300),
(8, 5, '2025-01-08', 450),
(9, 6, '2025-01-06', 900),
(10, 6, '2025-01-11', 1200);




-- Part A – JOINS (10 Questions)
-- 1.	Retrieve all employees along with their department names.
SELECT 
	e.*,
    d.dept_name
FROM Employees e 
JOIN Departments d ON e.dept_id = d.dept_id;
 -- 2.	List all employees and the projects they are working on (show NULL if no project).
 SELECT
	e.*,
    p.project_name
FROM Employees e
JOIN Projects p ON e.project_id = p.project_id;
 -- 3.	Show all departments and employees (include departments with no employees).
 SELECT d.*, e.*
 FROM Departments d
 LEFT JOIN Employees e ON d.dept_id = e.dept_id;
-- 4.	Show all projects and employees working on them (include projects without employees).
SELECT p.*, e.*
FROM Projects p 
LEFT JOIN Employees e ON p.project_id = e.project_id;
-- 5.   Retrieve employees along with both department and project details.
SELECT e.*, d.*, p.*
FROM Employees e
LEFT JOIN Departments d ON e.dept_id = d.dept_id
LEFT JOIN Projects p ON e.project_id = p.project_id;
 -- 6.	Find employees who are working on projects belonging to a different department than their own.
SELECT e.*, p.*
FROM Employees e
JOIN Projects p ON e.project_id = p.project_id
WHERE e.dept_id != p.dept_id;
-- 7.	List all employees along with their manager’s name (self-join).
SELECT e1.*, e2.*
FROM Employees e1
JOIN Employees e2 ON e1.manager_id = e2.emp_id;
-- 8.	Show the number of employees working in each department. (
SELECT
	d.dept_id,
    d.dept_name,
    SUM(e.emp_id) AS num_employees
FROM Departments d
LEFT JOIN Employees e ON d.dept_id = e.dept_id
GROUP BY d.dept_id, d.dept_name;
-- 9.	Show the departments which do not have any employees.
SELECT d.*
FROM Departments d
LEFT JOIN Employees e ON d.dept_id = e.dept_id
WHERE e.emp_id IS NULL;
-- 10.	Generate all possible combinations of department and project names (cross join).
SELECT d.*, p.*
FROM Departments d
JOIN Projects p;
 
 



-- Part B – Window Functions (5 Questions)
/*
TABLES:
employees(emp_id, emp_name, dept_id, project_id, manager_id)
sales(sale_id, emp_id, sale_date, sale_amount)
*/

-- 1.	For each employee’s sales, show the previous sale amount (using LAG). (lag on per employee order by date)
SELECT
	e.emp_id,
    s.sale_amount,
    s.sale_date,
    LAG(s.sale_amount, 1) OVER (PARTITION BY e.emp_id ORDER BY s.sale_date DESC) AS prev_sale
FROM Employees e 
JOIN Sales s ON e.emp_id = s.emp_id;
-- 2.	For each employee’s sales, show the next sale amount (using LEAD).
SELECT
	e.emp_id,
    s.sale_date,
    s.sale_amount,
    LEAD(s.sale_amount,1) OVER (PARTITION BY e.emp_id ORDER BY s.sale_date DESC) AS next_sale
FROM Employees e
JOIN Sales s ON e.emp_id = s.emp_id;
-- 3.	Show the difference between each employee’s current sale and their previous sale.
SELECT
	e.emp_id,
    s.sale_amount AS cursale,
    LAG(s.sale_amount, 1) OVER (PARTITION BY e.emp_id ORDER BY s.sale_date DESC) AS prev_sale,
    s.sale_amount - LAG(s.sale_amount, 1) OVER (PARTITION BY e.emp_id ORDER BY s.sale_date DESC) AS sale_diff
FROM Employees e 
JOIN Sales s ON e.emp_id = s.emp_id;
-- 4.	Assign a row number to each sale of every employee ordered by sale_date. (rnk on per employee order by sale_date)
SELECT
	e.emp_id,
    s.sale_id,
    s.sale_date,
    ROW_NUMBER() OVER (PARTITION BY e.emp_id ORDER BY s.sale_date DESC) AS sale_no
FROM Employees e
JOIN Sales s ON e.emp_id = s.emp_id;
-- 5.	Find the highest sale made by each employee using a window function (not GROUP BY).
SELECT DISTINCT
	e.emp_id,
    e.emp_name,
    MAX(s.sale_amount) OVER (PARTITION BY e.emp_id) AS max_sale
FROM Employees e
JOIN Sales s ON e.emp_id = s.emp_id;

