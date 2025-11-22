-- LENGTH, TRIM, SEARCH, SUBSTRING, MODIFICATION

/* Length */
-- LENGTH(str) : Returns length in bytes
SELECT first_name, LENGTH(first_name) AS name_length
FROM employees;



/* Trimming & Spaces */
-- LTRIM(str) : Removes leading spaces
SELECT LTRIM('    SQL Training  ') AS trimmed_text;

-- RTRIM(str) : Removes trailing spaces
SELECT RTRIM('MySQL Basics     ') AS trimmed_text;

-- TRIM(str) : Removes both leading and trailing spaces
SELECT TRIM('   SQL Functions   ') AS trimmed_text;

-- SPACE(n) : Returns string of n spaces
SELECT CONCAT('Hello', SPACE(5), 'World') AS spaced_text;



-- NOTE: THERE IS NO 0 BASED INDEXING IN ANYWHERE IN SQL, ONLY COUNT BASED
/* Search */
-- INSTR(str, substr) : Returns position of substring
SELECT email, INSTR(email, 'e') AS at_position
FROM employees;

-- FIND_IN_SET(str, strlist) : Finds position of a string in a comma-separated list
SELECT FIND_IN_SET('IT', 'HR,Finance,IT,Marketing') AS position;


/* Substrings */
-- LEFT(str, n) : Returns leftmost n characters
SELECT last_name, LEFT(last_name, 1) AS short_last_name
FROM employees;

-- RIGHT(str, n) : Returns rightmost n characters
SELECT email, RIGHT(email, 10) AS domain
FROM employees;

-- SUBSTR(str, pos, len) or SUBSTRING(str, pos, len) : Extract substring
SELECT first_name, SUBSTR(first_name, 2, 3) AS mid_name_part
FROM employees;

-- SUBSTRING_INDEX(str, delim, count) : Part of string before/after delimiter
/*
Positive N = "left part up to the Nth occurrence from the left."
Negative N = "right part after the Nth occurrence from the right."
*/
SELECT email,
       SUBSTRING_INDEX(email, '@', 1) AS username,  -- upto first occurence from left
       SUBSTRING_INDEX(email, '@', -1) AS domain    -- upto first occurence from right
FROM employees;


/* Modification */
-- CONCAT(str, ...) : Concatenate strings
SELECT CONCAT(first_name, ' +', last_name) AS full_name
FROM employees;

-- REPEAT(str, n) : Repeats string n times
SELECT REPEAT('Hi ', 3) AS repeated_text;

-- REPLACE(str, from_str, to_str) : Replace substring
SELECT email, REPLACE(email, 'example.com', 'company.org') AS updated_email
FROM employees;

-- REVERSE(str) : Reverse string
SELECT first_name, REVERSE(first_name) AS reversed_name
FROM employees;

/* Case Conversion */
-- LCASE(str) or LOWER(str) : Convert to lowercase
SELECT first_name, LCASE(first_name) AS lower_case_name
FROM employees;

-- LOWER(str) : Same as LCASE()
SELECT LOWER(last_name) AS lower_name
FROM employees;

-- UCASE(str) or UPPER(str) : Converts to uppercase
SELECT first_name, UPPER(first_name) AS upper_case_name
FROM employees;





/* Miscellaneous */
-- Rare/less common functions (optional but exist):

ASCII(str) → returns numeric ASCII value of first character.

ORD(str) → returns numeric value of first character.

BIN(x) / HEX(str) → for binary/hex representations.

FORMAT(x, d) → formats numbers as strings with commas.

QUOTE(str) → returns string enclosed in quotes for SQL.

-- LPAD(str, len, padstr) : Left-pad string
SELECT LPAD('SQL', 6, '*') AS padded_left;

-- RPAD(str, len, padstr) : Right-pad string
SELECT RPAD('SQL', 6, '*') AS padded_right;

-- FIELD(str, str1, str2, ...) : Index of str in list
SELECT FIELD('HR', 'Finance', 'HR', 'IT') AS position;

-- ELT(N, str1, str2, ...) : Return Nth string
SELECT ELT(2, 'HR', 'Finance', 'IT') AS department;


