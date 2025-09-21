-- CURRENT : returns the date, time, timestamp(date & time) of the system where the MySQL server is running.

--  CURRENT_DATE : Returns today's date
SELECT CURRENT_DATE();
SELECT CURDATE();
--  CURRENT_TIME : Returns current system time
SELECT CURRENT_TIME();
SELECT CURTIME();
--  CURRENT_TIMESTAMP : Returns current date and time
SELECT CURRENT_TIMESTAMP();
SELECT NOW();
-- synonyms of timestamp: (not so important)
SELECT LOCALTIME();
SELECT LOCALTIMESTAMP();
SELECT SYSDATE();              -- same as NOW but evaluated at execution time




-- EXTRACTION

-- TIME EXTRACTION:
-- TIME() extracts time from full timestap
SELECT NOW() AS full_datetime, TIME(NOW()) AS only_time;
--  HOUR() : extract hour from full timestamp
SELECT NOW() AS full_time, HOUR(NOW()) AS current_hour;
--  MINUTE() : Extract minutes from full timestamp 
SELECT NOW() AS full_time, MINUTE(NOW()) AS current_minute;
--  SECOND() : Extract seconds from full timestamp 
SELECT NOW() AS full_time, SECOND(NOW()) AS current_second;

-- DATE EXTRACTION:
-- DATE() : Extract only the DATE part from a datetime value
SELECT NOW() AS full_datetime, DATE(NOW()) AS only_date;
--  DAYNAME() : Returns weekday name
SELECT first_name, hire_date, DAYNAME(hire_date) AS hire_day_name FROM employees;
--  DAY() / DAYOFMONTH() : Returns the day number of the month 
SELECT first_name, hire_date, DAY(hire_date) AS hire_day_number FROM employees;
SELECT first_name, hire_date, DAYOFMONTH(hire_date) AS hire_day_number FROM employees;
-- DAYOFWEEK(date) → weekday index (1 = Sunday ... 7 = Saturday)
SELECT first_name, hire_date, DAYOFWEEK(hire_date) AS hire_day_number FROM employees;
-- DAYOFYEAR(date) → day number in the year (1–366)
SELECT first_name, hire_date, DAYOFYEAR(hire_date) AS hire_day_number FROM employees;
--  MONTHNAME() : Extract month name from hire_date
SELECT first_name, hire_date, MONTHNAME(hire_date) AS hire_month_name
FROM employees
where MONTHNAME(hire_date)='June';
--  MONTH() : Extract month number from hire_date
--  WEEK() : Week number of the year
SELECT first_name, hire_date, WEEK(hire_date) AS hire_week
FROM employees;
SELECT first_name, hire_date, MONTH(hire_date) AS hire_month
FROM employees;
--  QUARTER() : Extract quarter (1–4) from hire_date
SELECT first_name, hire_date, QUARTER(hire_date) AS hire_quarter
FROM employees;
--  YEAR() : Extract year from hire_date
SELECT first_name, hire_date, YEAR(hire_date) AS hire_year
FROM employees;
-- YEARWEEK(date) → year + week number
SELECT NOW() AS full_datetime, YEARWEEK(NOW()) AS year_week;

-- EXTRACT(unit FROM date) → extract part of a date
SELECT EXTRACT(YEAR FROM NOW());




-- ARITHMETIC

-- TIME ARITHMETIC: (there are no synonyms like time_add, etc like date arithmetic)

-- ADDTIME(expr1, expr2) → add a time(hhmmss) to a time/datetime
SELECT NOW() AS current_time3, ADDTIME(NOW(), '02:30:00') AS after_2hr30min;
/*
OUTPUT:
current_time3          after_2hr30min
2025-09-17 06:38:23	   2025-09-17 09:08:23
*/

-- SUBTIME(expr1, expr2) → subtract a time from a time/datetime
SELECT NOW() AS current_time3, SUBTIME(NOW(), '02:00:00') AS before_2h;
/*
current_time3        before_2h
2025-09-17 16:27:35	 2025-09-17 14:27:35
*/

--  TIMEDIFF(expr1, expr2) → difference between two time/datetime values
SELECT TIMEDIFF('2025-09-12 12:00:00', '2025-09-13 10:30:00') AS time_difference;
/*
OUTPUT:
time_difference
-22:30:00
*/



-- DATE ARITHMETIC:

-- ADDDATE(date, INTERVAL expr unit) / DATE_ADD() → add interval
SELECT first_name, hire_date, ADDDATE(hire_date, INTERVAL 15 DAY) AS plus_15_days
FROM employees;
/*
OUTPUT: first two rows
first_name  hire_date   plus_15_days
Arun        2021-06-15  2021_06_30
Priya       2020-03-10  2020-03-25
*/
-- DATE_ADD: same as ADDDATE
SELECT first_name, hire_date, DATE_ADD(hire_date, INTERVAL 2 MONTH) AS plus_2_months
FROM employees;
/*
OUTPUT: first two rows
first_name  hire_date    plus_2_months
Arun	    2021-06-15	 2021-08-15
Priya	    2020-03-10	 2020-05-10
*/

-- SUBDATE(date, INTERVAL expr unit) / DATE_SUB() → subtract interval
SELECT DATE(NOW()) AS today, SUBDATE(DATE(NOW()), INTERVAL 3 MONTH) AS 3month_before;
/*
today       3month_before
2025-09-17	2025-06-17
*/

-- DATEDIFF(date1, date2) → difference in days between dates
SELECT first_name, DATEDIFF(DATE_ADD(CURDATE(), INTERVAL 2 MONTH), hire_date) AS days_in_company
FROM employees;
/*
OUTPUT: first 2 rows
first_name   days_in_company
Arun	     1616
Priya	     2078
*/


-- TIMESTAMP ARITHMETIC: (no sub)
-- TIMESTAMPADD(unit, int, datetime_expr) → add interval (ANSI style)
-- TIMESTAMPDIFF(unit, datetime1, datetime2) → difference between datetimes




-- MAKING & FORMATTING (making not there for timestamp)

--  MAKETIME(hour, minute, second) : Create a time
SELECT MAKETIME(12, 45, 30) AS custom_time; -- Returns 12:45:30

--  MAKEDATE(year, day_of_year) : Create a date with day number of year
SELECT MAKEDATE(2025, 100) AS hundredth_day_2025; -- Returns 2025-04-10

-- STR_TO_DATE(str, format) → parse a string into a date using a format
SELECT STR_TO_DATE('12-09-2025', '%d-%m-%Y') AS formatted_date;  -- returns 2025-09-12


-- DATE_FORMAT(date, format) → format a date/datetime as a string using a format
SELECT DATE_FORMAT('2025-09-17 14:35:22', '%W, %M %d %Y %H:%i:%s') AS formatted;
-- Result: Wednesday, September 17 2025 14:35:22

-- GET_FORMAT(type, format) → return a predefined format string for date/time/datetime in specified way
SELECT DATE_FORMAT('2025-09-17 14:35:22', GET_FORMAT(DATETIME, 'USA')) AS formatted;
-- Result: 09.17.2025 14:35:22


/*
styles: 
'ISO' → International standard (YYYY-MM-DD / YYYY-MM-DD HH:MM:SS)
'USA' → US style (MM.DD.YYYY, 12-hour time with AM/PM)
'EUR' → European style (DD.MM.YYYY, 24-hour time)
'JIS' → Japanese Industrial Standard (YYYY-MM-DD)
'INTERNAL' → MySQL’s internal default format
*/
/*
fomat specifiers
Code   Meaning              Example (2025-09-17 14:35:22)
%Y     Year (4-digit)       2025
%y     Year (2-digit)       25
%m     Month (01–12)        09
%M     Full month name      September
%d     Day of month (01–31) 17
%H     Hour (00–23)         14
%h     Hour (01–12)         02
%i     Minutes (00–59)      35
%s     Seconds (00–59)      22
%p     AM / PM              PM
%W     Weekday name         Wednesday
%a     Abbreviated weekday  Wed
*/
