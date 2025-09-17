/* Constants & Random */
-- PI() : Value of π
SELECT PI();

-- RAND() : Random number between 0 and 1
SELECT RAND() AS random;  -- 0.009479221896714738
-- find random & * 100 to get 2 digits after decimal, *1000 to get 3 digits after decimal, etc.
SELECT ROUND(RAND()*100, 0) AS random_number;  -- round after multiplying to remove whatever after decimal point


/* Rounding & Approximation */
-- CEIL(x) / CEILING(x) : Smallest integer >= x 
SELECT CEIL(45.2) AS ceil_value; -- 46

-- FLOOR(x) : Largest integer <= x        
SELECT FLOOR(45.8) AS floor_value; -- 45

-- ROUND(x, d) : Round number to d decimals
SELECT ROUND(123.4467, 1) AS rounded_value; -- 123.46

-- TRUNCATE(x, d) : Truncate number to d decimals
SELECT TRUNCATE(123.4567, 3) AS truncated_value; -- 123.45


/* Powers & Roots */
-- EXP(x) : Exponential (e^x)
SELECT EXP(2) AS exponential; -- e^2

-- POWER(x, y) or POW(x, y) : x raised to power y
SELECT POWER(3, 4) AS power_value; -- 81

-- SQRT(x) : Square root
SELECT SQRT(49) AS square_root; -- 7


/* Logarithms */
-- LOG(x) : Natural logarithm
SELECT LOG(10) AS natural_log;

-- LN(x) : Natural logarithm (same as LOG(x))
SELECT LN(10) AS natural_log;

-- LOG(b, x) : Logarithm of x base b
SELECT LOG(2, 10) AS log10base2;

-- LOG10(x) : Base-10 logarithm
SELECT LOG10(1000) AS log_base10; -- 3


/* Basic Math */
-- ABS(x) : Absolute value
SELECT -50 AS number, ABS(-50) AS absolute_value;

-- SIGN(x) : Returns -1, 0, or 1 depending on sign
SELECT SIGN(-25), SIGN(0), SIGN(100);

-- MOD(x, y) : Modulus (remainder) . you can use % instead of this
SELECT MOD(17, 4) AS modulus; -- 1



/* Comparison */ -- 
-- GREATEST(x, y, ...) : Largest value
SELECT GREATEST(10, 45, 32, 67, 5) AS greatest_value;

-- LEAST(x, y, ...) : Smallest value
SELECT LEAST(10, 45, 32, 67, 5) AS least_value;


/* Missing but important numeric functions:
- RADIANS(x)  → Convert degrees to radians
- DEGREES(x)  → Convert radians to degrees
- CONV(N, from_base, to_base) → Convert numbers between bases (e.g., binary, hex, decimal)
- CRC32(expr) → Compute 32-bit checksum (useful for hashing/checking data)
*/
