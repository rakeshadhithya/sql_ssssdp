/*
TABLES:
departments(dept_id, dept_name, location)
projects(project_id, dept_id, project_name)
employees(emp_id, emp_name, dept_id, project_id, manager_id)
sales(sale_id, emp_id, sale_date, sale_amount)
*/

-- Part A – JOINS (10 Questions)
-- 1.	Retrieve all employees along with their department names.
SELECT e.emp_id, e.emp_name, d.dept_name
FROM employees e
 LEFT JOIN departments d ON e.dept_id = d.dept_id;
 
 -- 2.	List all employees and the projects they are working on (show NULL if no project).
SELECT e.emp_id, e.emp_name, p.project_name
FROM employees e 
 LEFT JOIN projects p ON e.project_id = p.project_id;
 
 -- 3.	Show all departments and employees (include departments with no employees).
 SELECT d.dept_name, e.emp_name
 FROM departments d
  LEFT JOIN employees e ON d.dept_id = e.dept_id;
  
-- 4.	Show all projects and employees working on them (include projects without employees).
SELECT p.project_name, e.emp_name
FROM projects p 
 LEFT JOIN employees e ON p.project_id = e.project_id;
 
-- 5.   Retrieve employees along with both department and project details.
SELECT e.emp_id, e.emp_name, d.dept_name, p.project_name
FROM employees e
 LEFT JOIN departments d ON e.dept_id = d.dept_id
 LEFT JOIN projects p ON e.project_id = p.project_id;
 
 -- 6.	Find employees who are working on projects belonging to a different department than their own.
SELECT e.emp_name, e.dept_id AS emp_dept_id, p.dept_id AS project_dept_id, p.project_name
FROM employees e 
 LEFT JOIN projects p ON e.project_id = p.project_id
WHERE e.dept_id != p.dept_id;

-- 7.	List all employees along with their manager’s name (self-join).
SELECT e.emp_name AS employee, m.emp_name AS manager
FROM employees e
 JOIN employees m ON e.manager_id = m.emp_id;
 
-- 8.	Show the number of employees working in each department.
SELECT d.dept_id, d.dept_name, COUNT(e.emp_id)
FROM departments d
 LEFT JOIN employees e ON d.dept_id = e.dept_id
GROUP BY d.dept_id, d.dept_name;

-- 9.	Show the departments which do not have any employees.
SELECT d.dept_id, d.dept_name
FROM departments d
 LEFT JOIN employees e ON d.dept_id = e.dept_id
GROUP BY d.dept_id, d.dept_name
HAVING COUNT(e.emp_id) = 0;

-- 10.	Generate all possible combinations of department and project names (cross join).
SELECT d.dept_name, p.project_name
FROM departments d
 JOIN projects p;      -- no ON condition, you can also use CROSS JOIN
 
 



-- Part B – Window Functions (5 Questions)
/*
TABLES:
employees(emp_id, emp_name, dept_id, project_id, manager_id)
sales(sale_id, emp_id, sale_date, sale_amount)
*/

/*
For each employee (PARTITION BY emp_id),
Arrange rows by sale_date (ORDER BY sale_date),
Then take the previous row’s sale_amount
partition by and order by works on the result set of current query, you can use any coulumn not just selected ones
*/

-- 1.	For each employee’s sales, show the previous sale amount (using LAG).
SELECT e.emp_name, s.sale_amount AS curr_sale,
		LAG(s.sale_amount) OVER (PARTITION BY s.emp_id ORDER BY s.sale_date) AS prev_sale
FROM sales s 
  JOIN employees e ON s.emp_id = e.emp_id;

-- 2.	For each employee’s sales, show the next sale amount (using LEAD).
SELECT e.emp_name, s.sale_amount AS curr_sale,
		LEAD(s.sale_amount) OVER (PARTITION BY s.emp_id ORDER BY s.sale_date) AS next_sale
FROM sales s 
  JOIN employees e ON s.emp_id = e.emp_id;
  
-- 3.	Show the difference between each employee’s current sale and their previous sale.
SELECT e.emp_name,
	   s.sale_amount - LAG(s.sale_amount) OVER (PARTITION BY s.emp_id ORDER BY s.sale_date) AS sale_diff
FROM sales s
  JOIN employees e ON s.emp_id = e.emp_id;
  
-- 4.	Assign a row number to each sale of every employee ordered by sale_date.
SELECT e.emp_name, s.sale_date,
	   ROW_NUMBER() OVER (PARTITION BY s.emp_id ORDER BY s.sale_date) AS sale_no
FROM sales s
  JOIN employees e ON s.emp_id = e.emp_id;
  
-- 5.	Find the highest sale made by each employee using a window function (not GROUP BY).
SELECT DISTINCT e.emp_name, MAX(sale_amount) OVER (PARTITION BY s.emp_id) AS max_sale
FROM sales s
  JOIN employees e ON s.emp_id = e.emp_id;