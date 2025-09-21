-- MySQL Functions Assignment

use ssssdp;

show tables;
drop table dept;
drop table emp;

CREATE TABLE employees (
    emp_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    department VARCHAR(50),
    hire_date DATE,
    email VARCHAR(100),
    salary DECIMAL(10,2)
);

INSERT INTO employees (first_name, last_name, department, hire_date, email, salary) VALUES
('Arun', 'Vasa', 'IT', '2021-06-15', 'arun.vasa@example.com', 55000.00),
('Priya', 'Sharma', 'HR', '2020-03-10', 'priya.sharma@example.com', 48000.00),
('Rahul', 'Patel', 'Finance', '2019-11-25', 'rahul.patel@example.com', 60000.00),
('Neha', 'Reddy', 'IT', '2022-01-05', 'neha.reddy@example.com', 53000.00),
('Kiran', 'Singh', 'Marketing', '2023-07-20', 'kiran.singh@example.com', 45000.00);



-- Date & Time Functions
-- 1 Show current date, time, and timestamp separately.
SELECT CURDATE() AS today_date;
SELECT CURTIME() AS cur_time;
SELECT NOW() AS cur_timestamp ;

-- 2 Display each employee’s hire year, month number, and month name.
SELECT YEAR(hire_date) AS hire_year, MONTH(hire_date) AS hire_month, MONTHNAME(hire_date) AS month_name
FROM employees;

-- 3 Find which quarter each employee was hired in.
SELECT emp_id, first_name, QUARTER(hire_date)
FROM employees;

-- 4 Display hire dates with their corresponding week numbers.
SELECT emp_id, first_name, hire_date, WEEK(hire_date) AS week_num
FROM employees;

-- 5 Show the 200th day of the year 2025 using MAKEDATE.
SELECT MAKEDATE(2025, 200) AS dt;

-- 6 Create a time value '09:15:00' using MAKETIME.
SELECT MAKETIME(09, 15, 00) AS tm;

-- 7 Find out the difference in time between '14:45:00' and '09:30:00'.
SELECT TIMEDIFF('14:45:00', '09:30:00') AS diff;

-- 8 Convert '15/08/2025' into a proper date using STR_TO_DATE.
SELECT STR_TO_DATE('15-08-2025', '%d-%m-%Y') AS dt;

-- 9 Show employee hire date and extract day, month, year separately.
SELECT emp_id, hire_date, DAY(hire_date) AS dy, MONTH(hire_date) AS mnth, YEAR(hire_date) AS yr
FROM employees;

-- 10 Find employees hired in the month of January.
SELECT emp_id, first_name, MONTH(hire_date) AS hire_month
FROM employees
WHERE MONTH(hire_date) = 1;





-- String Functions
-- 1 Concatenate first name and last name into one column.
SELECT emp_id, CONCAT(first_name, ' ', last_name) AS full_name
FROM employees;

-- 2 Display first 3 characters of last name.
SELECT last_name, RIGHT(last_name, 3)
FROM employees AS last_3_chars;

-- 3 Show names in upper and lower case.
SELECT UPPER(CONCAT(first_name,' ', last_name)) AS full_name
FROM employees;

-- 4 Find position of '@' in each email.
SELECT emp_id, INSTR(email, '@') AS pos
FROM employees;

-- 5 Replace domain 'example.com' with 'company.org'.
SELECT email AS prev_email, REPLACE(email, 'example.com', 'company.org') AS after_modification
FROM employees;

-- 6 Reverse the first name of each employee.
SELECT first_name AS prev_name, REVERSE(first_name) AS after_reversal
FROM employees;

-- 7 Show the length of each employee email.
SELECT emp_id, email, LENGTH(email) AS email_length
FROM employees;

-- 8 Trim spaces from ' SQL Practice '.
SELECT TRIM('     SQL Practice     ') AS after_trim;

-- 9 Extract the last 4 characters from email addresses (domain).
SELECT email, RIGHT(email, 4) AS domain
FROM employees;

-- 10 Display employees whose last name starts with 'S'.
SELECT emp_id, last_name
FROM employees
WHERE last_name LIKE 's%';





-- Numeric Functions
-- 1 Show absolute value of -1000.
SELECT ABS(-1000) AS abs_value;

-- 2 Find the ceiling and floor values of 123.45.
SELECT 123.45 AS n, CEIL(123.45) AS ceil_n, FLOOR(123.45) AS floor_n;

-- 3 Round the number 98.7654 to 2 decimals.
SELECT 98.7654 AS n, ROUND(98.7654, 2) AS round_n;

-- 4 Show modulus when 55 is divided by 6.
SELECT 55 AS n, MOD(55, 6) AS mod_n;

-- 5 Find square root of 121.
SELECT 121 AS n, SQRT(121) AS sqrt_n;

-- 6 Raise 2 to the power of 8.
SELECT 6 AS n, 8 AS r, POW(6, 8) AS n_power_r;

-- 7 Find natural log and base-10 log of 1000.
SELECT 1000 AS n, LN(1000) AS natural_log, LOG10(1000) AS base_10;

-- 8 Display the sign of -45, 0, and 20.
SELECT SIGN(-45), SIGN(0), SIGN(20);

-- 9 Show 3 random numbers between 0 and 1.
SELECT RAND() AS random_1, RAND() AS random_2, RAND() AS random_3;

-- 10 Find highest and lowest salary from employees table.
SELECT MAX(salary) AS highest_sal, MIN(salary) AS lowest_sal
FROM employees;

-- 11 Display employee salary truncated to 2 decimals.
SELECT salary, TRUNCATE(salary, 2) AS turnc
FROM employees;

-- 12 Add a random bonus (between 500 and 2000) to each employee’s salary.
SELECT emp_id, salary, ROUND(500 + RAND() * (2000 - 500)) ;