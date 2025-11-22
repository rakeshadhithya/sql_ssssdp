-- DML: INSERT, DELETE, UPDATE, SELECT(next page)

use ssssdp;
 
-- necessary for cleanup
show tables;

-- drop all tables
DROP TABLE company_employees;
DROP TABLE company_departments;
DROP TABLE departments;
DROP TABLE employees;            


CREATE TABLE departments (
    dept_no     INT PRIMARY KEY,
    dept_name   VARCHAR(50) NOT NULL UNIQUE
);
CREATE TABLE employees (
    emp_no      INT PRIMARY KEY,
    birth_date  DATE NOT NULL,
    first_name  VARCHAR(14) NOT NULL,
    last_name   VARCHAR(16) NOT NULL,
    gender      CHAR(1) NOT NULL CHECK (gender IN ('M', 'F')),
    hire_date   DATE NOT NULL,
    dept_no     INT,
    CONSTRAINT fk_dept FOREIGN KEY (dept_no) REFERENCES departments(dept_no)
); 

CREATE TABLE projects (
    project_id   INT PRIMARY KEY,
    project_name VARCHAR(100),
    start_date   DATE,
    end_date     DATE,
    budget       DECIMAL(12,2)
);



select * from departments;
select * from employees;


-- INSERT 

-- DIFFERENT WAYS TO INSERT (analogy: tuples matching, defulat tuple for table is full columns)

-- Insert only project_id and project_name only
INSERT INTO projects (project_id, project_name)
VALUES (1, 'Data Analytics Training');

-- error, because duplicate primary
INSERT INTO departments ( dept_name,dept_no)
VALUES ('Human Resources',1);

-- insert all cols
INSERT INTO projects
VALUES (3, 'Marketing Campaign', '2025-01-01', '2025-06-30', 200000.00);

-- Insert by jumbling column order
INSERT INTO projects (project_name, budget, project_id, end_date, start_date)
VALUES ('Website Redesign', 150000.00, 4, '2025-12-31', '2025-02-01');

-- Insert partially with jumbled order
INSERT INTO projects (project_name, project_id, end_date, start_date)
VALUES ('Website Redesign', 5, '2025-12-31', '2025-02-01');

TRUNCATE projects;

-- Insert multiple columns
INSERT INTO projects (project_id, project_name, start_date, end_date, budget) VALUES
(1, 'Data Migration', '2024-01-10', '2024-06-30', 50000.00),
(2, 'Website Redesign', '2024-02-01', '2024-05-15', 30000.00),
(3, 'AI Chatbot', '2024-03-20', '2024-09-10', 80000.00);




-- DELETE
DELETE FROM projects
WHERE project_id = 3




-- UPDATE (SET single or multiple col expressions)

-- Increase the budget of project_id = 2
UPDATE projects
SET budget = 35000.00
WHERE project_id = 0;

select * from projects;
-- Update project_name and end_date for project_id = 1
UPDATE projects
SET project_name = 'Cloud Data Migration',
    end_date = '2024-07-15'
WHERE project_id = 1;

-- Add 10% extra budget for all projects starting before March 2024
UPDATE projects
SET budget = budget * 1.10
WHERE project_id >1;
/*
10% of a number → gives just the 10% part. 10% of 200 = 200 × 0.10 = 20
number × 1.10 → gives the original number plus its 10%. 200 × 1.10 = 200 + 20 = 220
*/

-- Extend all project end dates by one month
UPDATE projects
SET end_date = DATE_ADD(end_date, INTERVAL 1 MONTH);