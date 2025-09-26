-- Assignment : Joins and Window Functions

USE ssssdp;
SHOW TABLES;
DROP TABLE employees;

/*
Employees
Column	Description
emp_id	Unique ID for each employee
emp_name	Employee name
dept_id	Department where the employee works
project_id	Project assigned to the employee
manager_id	Manager of the employee (self join key)
*/
CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50),
    dept_id INT,
    project_id INT,
    manager_id INT
);


/*
Departments
Column	Description
dept_id	Unique ID for each department
dept_name	Department name
location	City where the department is located
*/
CREATE TABLE departments(
	dept_id INT PRIMARY KEY,
    dept_name VARCHAR(50),
    location VARCHAR(50)
);


/*
Projects
Column	Description
project_id	Unique ID for each project
dept_id	Department responsible for the project
project_name	Project name
*/
CREATE TABLE projects(
	project_id INT PRIMARY KEY,
    dept_id INT,
    project_name VARCHAR(50)
);

/*
Sales
Column	Description
sale_id	Unique ID for each sale
emp_id	Employee who made the sale
sale_date	Date of the sale
sale_amount	Amount of the sale
*/
CREATE TABLE sales(
	sale_id INT PRIMARY KEY,
    emp_id INT,
    sale_date DATE,
    sale_amount INT
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
