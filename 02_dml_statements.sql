-- DML: INSERT, DELETE, UPDATE, SELECT

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

-- Insert single department
INSERT INTO departments (dept_no, dept_name)
VALUES (1, 'Human Resources');

-- error, because duplicate primary
INSERT INTO departments ( dept_name,dept_no)
VALUES ('Human Resources',1);

-- Insert multiple departments
INSERT INTO departments 
VALUES
(2, 'Finance'),
(3, 'IT'),
(4, 'Marketing');


-- Insert single employee
INSERT INTO employees (emp_no, birth_date, first_name, last_name, gender, hire_date, dept_no)
VALUES (101, '1990-01-01', 'Arun', 'Vasa', 'M', '2020-05-01', 3);

-- Insert multiple employees
INSERT INTO employees (emp_no, birth_date, first_name, last_name, gender, hire_date, dept_no)
VALUES
(102, '1992-03-10', 'Anita', 'Shah', 'F', '2021-06-01', 2),
(103, '1991-07-15', 'John', 'Doe', 'M', '2022-08-01', 1),
(104, '1993-11-25', 'Meera', 'Patel', 'F', '2023-01-10', 4);




-- DIFFERENT WAYS TO INSERT

-- Insert only project_id and project_name
INSERT INTO projects (project_id, project_name)
VALUES (1, 'Data Analytics Training');

 -- Insert project_id, name, and budget only
INSERT INTO projects (project_id, project_name, budget)
VALUES (2, 'AI Research Project', 500000.00);

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




-- UPDATE 

 -- Rename "IT" department to "Technology"
UPDATE departments
SET dept_name = 'Technology'
WHERE dept_no = 3;

-- error, because child table has rows with this foreign key value (on update cascade is not there)
UPDATE departments
SET dept_no = 6
WHERE dept_name = 'Finance';

select * from departments;
select * from employees;



-- DIFFERENT WAYS TO UPDATE

-- Increase the budget of project_id = 2
UPDATE projects
SET budget = 35000.00
WHERE project_id > 0;

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

-- Extend all project end dates by one month
UPDATE projects
SET end_date = DATE_ADD(end_date, INTERVAL 1 MONTH);