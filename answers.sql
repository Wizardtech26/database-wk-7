-- Question 1: Retrieve all columns from the 'employees' table.
INSERT INTO ProductDetail (OrderID, CustomerName, Products)
VALUES
(101, 'John Doe', 'Laptop, Mouse'),
(102, 'Jane Smith', 'Tablet, Keyboard, Mouse'),
(103, 'Emily Clark', 'Phone');

WITH RECURSIVE SplitProducts AS (
    SELECT 
        OrderID,
        CustomerName,
        TRIM(SUBSTRING_INDEX(Products, ',', 1)) AS Product,
        SUBSTRING(Products, LENGTH(SUBSTRING_INDEX(Products, ',', 1)) + 2) AS rest
    FROM ProductDetail
    
    UNION ALL
    
    SELECT 
        OrderID,
        CustomerName,
        TRIM(SUBSTRING_INDEX(rest, ',', 1)),
        SUBSTRING(rest, LENGTH(SUBSTRING_INDEX(rest, ',', 1)) + 2)
    FROM SplitProducts
    WHERE rest <> ''
)
SELECT 
    OrderID, 
    CustomerName, 
    Product
FROM SplitProducts;