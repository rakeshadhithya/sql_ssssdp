-- use same table as 13_conditional_statements

-- VIEW: a view is a stored query, it behaves like a table when you query it, it does not store data only the query structure, used for simplicity and resusability
-- vs cte: view is stored query persists in the database until dropped whereas cte is temporary result set not stored anywhere exists only for current query

-- View for High-Value Products
CREATE VIEW HighValueProducts AS
SELECT product_id, product_name, price
FROM Products
WHERE price > 1000;

show tables;    -- HighValueProducts(views) can be seen along with regular tables because they are stored in the same information_schema database as special type(view type) of tables
                -- to see only views, check last written section

drop table HighValueProducts;    -- gives error as unknown table
drop view HighValueProducts;     -- drops the view now

select product_name from HighValueProducts
where price >1000;







-- PROCEDURE: A stored procedure is a set of SQL statements that can be executed by calling it explicitly. It can perform actions like modifying data in the database and handling business logic.
-- mysql uses ; as default demiliter for each statement, but inside begin and end we write multiple statements with ; so we change delimiter to avoid syntax errors

-- IN for select
DELIMITER //                                  -- Change delimiter to '//' (or any other unique string)
CREATE PROCEDURE GetProductsByCategory(IN cat VARCHAR(50))
BEGIN
    SELECT product_id, product_name, price, stock
    FROM Products
    WHERE category = cat;                     -- without delimiter change statement ends here but we need to end at END
END // 
DELIMITER ;                                    -- Restore the delimiter back to semicolon (`;`)
CALL GetProductsByCategory('Accessories');     -- prints the result set of stored procedure
DROP PROCEDURE GetProductsByCategory;         

-- IN, IN for update
DELIMITER //
CREATE PROCEDURE UpdateStock(IN prod_id INT, IN qty INT)
BEGIN
    UPDATE Products
    SET stock = stock - qty
    WHERE product_id = prod_id;
END // 
DELIMITER ;
select * from Products where product_id=3;   -- verify stock, call the below line and recheck
CALL UpdateStock(3, 5);                      -- updates values through stored procedure

-- OUT to find
DELIMITER //
CREATE PROCEDURE getProductName(OUT pname VARCHAR(100), IN pid INT)     -- make sure param names are diff from col names to avoid null errors
BEGIN
    SELECT product_name INTO pname FROM products WHERE product_id = pid
    LIMIT 1;          -- when setting value for out parameters from select statement it should have only row
END //
DELIMITER ;
drop procedure getProductName;
SET @name = '' ;
CALL getProductName(@name, 1);      -- executes stored procedure and stores out parameter in @name
SELECT @name;

-- INOUT to update variable
DELIMITER //
CREATE PROCEDURE increment(INOUT num INT, IN val INT)
BEGIN
    SET num = num + val;  -- no need to use @
END//
DELIMITER ;
SET @n = 10;              -- without @ throws error unknown system variable
CALL increment(@n, 5);
SELECT @n;


-- functions and triggers at last

/*
| Feature            | Stored Procedure                                                  | Function                                                                 |
| -------------------| ------------------------------------------------------------------| ------------------------------------------------------------------------ |
| Parameters allowed | `IN`, `OUT`, `INOUT`  (must pass variables for OUT/INOUT to store | `IN` only                                                                |
| Return type        | Can return result sets (via `SELECT`) or nothing                  | Must return exactly one scalar value (via `RETURN` )                     |
| Call style         | Called using `CALL proc_name()`                                   | Can be used inside `SELECT`, `WHERE`, `ORDER BY`, etc. (cannot use CALL) |
| Transactions       | Can use COMMIT, ROLLBACK, SAVEPOINT                               | Can't use transaction statements                                         |
*/

/*
EXTRA (NOT IMPORTANT)
information_schema is the system database that contains meta data about all the objects in all the databases
Tables: information_schema.tables                          -- table containing information about all tables in all db's                 
Views: information_schema.views                            -- table containing information about all views in all db's
Columns: information_schema.columns                        -- table containing information about all columns in all db's
Stored Procedures/Functions: information_schema.routines   -- table containing information about all routines in all db's
Triggers: information_schema.triggers                      -- table containing information about all triggers in all db's
Indexes: information_schema.statistics                     -- table containing information about all indexes in all db's
Constraints: information_schema.table_constraints          -- table containing information about all constraints in all db's
*/

select * from information_schema.tables;     -- tables in all databases
select * from information_schema.tables      -- tables in ssssdp
where table_schema = "ssssdp";
-- use table_type = 'VIEW' to see only views or use information_schema.views

select * from information_schema.columns
where table_schema = 'ssssdp';

select * from information_schema.routines
where routine_schema = 'ssssdp';

select * from information_schema.triggers
where trigger_schema = 'ssssdp';

select * from information_schema.statistics
where index_schema = 'ssssdp';                         -- you can also use table_schema 

select * from information_schema.table_constraints
where constraint_schema = 'ssssdp';




/*
Function Characteristics:
DETERMINISTIC: Function always returns the same result for the same input parameters (e.g., calculations).
NOT DETERMINISTIC: Function may return different results based on external factors (e.g., querying a table).
READS SQL DATA: Function only reads data from the database.
MODIFIES SQL DATA: Function modifies data in the database (e.g., performs UPDATE or INSERT).
NO SQL: Function doesn't use any SQL statements at all.
*/

-- FUNCTION: A function is set of sql statements that can be executed to compute and return a value. Functions are often used in SELECT queries or expressions.
-- Change delimiter to `$$` (or any other unique string)
DELIMITER $$
-- Create function to update stock
CREATE FUNCTION updateStock(product_id INT, percentage DECIMAL(5, 2))  -- declare functionname & parameters
RETURNS DECIMAL(10, 2)                                                 -- declare return type
DETERMINISTIC                                                          -- declare characteristic type
BEGIN
    DECLARE new_stock DECIMAL(10, 2);                                  -- declare function variable

    -- Calculate the new stock by applying the percentage increase     -- perform operations and store value in function variable
    SELECT stock * (1 + percentage / 100)
    INTO new_stock
    FROM products
    WHERE product_id = product_id;

    -- Update the product's stock
    UPDATE products
    SET stock = new_stock
    WHERE product_id = product_id;

    -- Return the updated stock
    RETURN new_stock;                                                    -- return function variable
END $$
-- Restore the delimiter back to semicolon (`;`)
DELIMITER ;
SELECT updateStock(1, 10);




/*
A trigger is an automatic action that occurs when certain events happen in the database (like before/after INSERT, UPDATE, or DELETE). It is commonly used for enforcing business rules or automatically updating related data when a change occurs.
*/
DELIMITER $$
-- Create a BEFORE INSERT trigger
CREATE TRIGGER before_insert_product
BEFORE INSERT ON products
FOR EACH ROW
BEGIN
    -- Check if stock is not provided (i.e., NULL), and set a default value
    IF NEW.stock IS NULL THEN    -- use only NEW not table name
        SET NEW.stock = 100;
    END IF;
END $$
DELIMITER ;


-- more examples:
DELIMITER $$

-- BEFORE UPDATE Trigger to prevent stock from being updated to a value less than 1
CREATE TRIGGER before_update_stock
BEFORE UPDATE ON products
FOR EACH ROW
BEGIN
    IF NEW.stock < 1 THEN                          -- If new stock is less than 1, raise an error
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Stock cannot be less than 1';
    END IF;
END $$
DELIMITER ;


DELIMITER $$

-- AFTER UPDATE Trigger to update related table after product update
CREATE TRIGGER after_update_product
AFTER UPDATE ON products
FOR EACH ROW
BEGIN
    -- Update the related inventory table with new stock
    UPDATE inventory
    SET stock = NEW.stock
    WHERE product_id = NEW.product_id;
END $$

DELIMITER ;





