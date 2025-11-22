use ssssdp;

show tables;
drop table products;

CREATE TABLE Products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50),
    price DECIMAL(10,2),
    stock INT
);

INSERT INTO Produ cts (product_id, product_name, category, price, stock) VALUES
(1, 'Laptop A', 'Electronics', 800.00, 50),
(2, 'Laptop B', 'Electronics', 1200.00, 20),
(3, 'Smartphone X', 'Electronics', 600.00, 100),
(4, 'Smartphone Y', 'Electronics', 750.00, 40),
(5, 'Tablet A', 'Electronics', 300.00, 70),
(6, 'Tablet B', 'Electronics', 450.00, 30),
(7, 'Headphones', 'Accessories', 100.00, 200),
(8, 'Keyboard', 'Accessories', 50.00, 150),
(9, 'Mouse', 'Accessories', 25.00, 300),
(10, 'Monitor 24"', 'Electronics', 200.00, 60),
(11, 'Monitor 32"', 'Electronics', 400.00, 25),
(12, 'Printer', 'Electronics', 150.00, 35),
(13, 'Router', 'Electronics', 80.00, 90),
(14, 'External HDD', 'Accessories', 120.00, 85),
(15, 'USB Drive', 'Accessories', 20.00, 500),
(16, 'Chair', 'Furniture', 150.00, 40),
(17, 'Desk', 'Furniture', 250.00, 30),
(18, 'Bookshelf', 'Furniture', 180.00, 25),
(19, 'Lamp', 'Furniture', 60.00, 70),
(20, 'Sofa', 'Furniture', 700.00, 10),
(21, 'Coffee Table', 'Furniture', 120.00, 15),
(22, 'TV 50"', 'Electronics', 900.00, 12),
(23, 'TV 65"', 'Electronics', 1400.00, 8),
(24, 'Smartwatch', 'Electronics', 250.00, 45),
(25, 'Gaming Console', 'Electronics', 500.00, 20);

Select * from products;





-- -------------------------------------------------------------------------------------------------
-- Use IF(x,y,z) for stock status classification (single condition)
SELECT product_name, stock,
       IF(stock < 20, 'Low Stock', 'Available') AS stock_status
FROM Products;


-- Use CASE WHEN for price range classification (multiple conditions)
SELECT product_name, price,
       CASE 
           WHEN price < 100 THEN 'Budget'
           WHEN price BETWEEN 100 AND 500 THEN 'Mid-Range'
           WHEN price BETWEEN 501 AND 1000 THEN 'Premium'
           ELSE 'Luxury'
       END AS price_category
FROM Products;

--  Combine CASE WHEN with category (aggregation).  (first case when is found for each row to complete from clause, then normal flow. groupby, select etc)
-- default else is null
SELECT category,
       COUNT(CASE WHEN price > 500 THEN 5    END) AS expensive_products,              -- for count, value does not matter since it's not adding but counting
       COUNT( CASE WHEN price <= 500 THEN product_name END) AS affordable_products
FROM Products
GROUP BY category;

SELECT category,
       COUNT(CASE WHEN price > 500 THEN product_name  END) AS expensive_products,
       COUNT(CASE WHEN price <= 500 THEN product_name END) AS affordable_products
FROM Products
GROUP BY category;



-- Use IF inside aggregation.   (first all rows are found with IF to complete from clause then normal sql flow group, having, order, select etc)
SELECT category,
       count(IF(stock < 50, 1, null)) AS low_stock_count,
       SUM(IF(stock >= 50, 1, 0)) AS sufficient_stock_count
FROM Products
GROUP BY category;


-- classifying based on two parameters
SELECT product_name, price,
       CASE 
           WHEN category = 'Electronics' AND price > 1000 THEN 'Eligible for 15% Discount'
           WHEN category = 'Furniture' AND stock < 20 THEN 'Eligible for 10% Discount'
           ELSE 'No Discount'
       END AS discount_policy
FROM Products;
