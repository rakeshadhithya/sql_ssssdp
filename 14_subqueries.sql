-- use same table as used for 13. conditional statements
-- subqueries usecase: questions that require 2 or more queries

-- Find products more expensive than the average price.
SELECT product_name, price
FROM Products
WHERE price > (SELECT AVG(price) FROM Products);

-- Find product(s) with the maximum price.
SELECT product_id, product_name, price
FROM Products
WHERE (price, stock) = (
    SELECT MAX(price), MIN(stock) FROM Products
);



-- Correlated Subquery. (when inner query needs outer values)

-- Find products that have a price higher than the average price in their category.
SELECT p1.product_name, p1.category, p1.price
FROM Products p1
WHERE p1.price > (
    SELECT AVG(p2.price)
    FROM Products p2
    WHERE p2.category = p1.category
);

-- select categories that have at least one product priced > 1000
SELECT DISTINCT category
FROM Products p
WHERE EXISTS (
    SELECT 1 FROM Products WHERE category = p.category AND price > 1000
);
