-- STEP 1: Create Tables
Category table
CREATE TABLE Category (
    CategoryID SERIAL PRIMARY KEY,
    CategoryName VARCHAR(50) NOT NULL
);

-- --Products table
CREATE TABLE Products (
    ProductID SERIAL PRIMARY KEY,
    ProductName VARCHAR(100) NOT NULL,
    CategoryID INT REFERENCES Category(CategoryID),
    Price DECIMAL(10,2) NOT NULL
);

-- -- Sales table
CREATE TABLE Sales (
    SaleID SERIAL PRIMARY KEY,
    ProductID INT REFERENCES Products(ProductID),
    SaleDate DATE NOT NULL,
    Quantity INT NOT NULL,
    TotalAmount DECIMAL(12,2) NOT NULL
);

-- STEP 2: Insert Sample Data
Insert Categories
INSERT INTO Category (CategoryName)
VALUES 
('Clothing'), 
('Home & Kitchen'),
('Books'), 
('Electronics'), 
('Toys');

-- -- Insert Products
INSERT INTO Products (ProductName, CategoryID, Price)
VALUES
('Smartphone', 1, 500.00),
('Laptop', 1, 1200.00),
('Headphones', 1, 150.00),
('T-Shirt', 2, 20.00),
('Jeans', 2, 40.00),
('Novel', 3, 15.00),
('Cookbook', 3, 25.00),
('Blender', 4, 60.00),
('Microwave', 4, 150.00),
('Toy Car', 5, 10.00),
('Action Figure', 5, 25.00),
('Tablet', 1, 300.00),
('Smartwatch', 1, 200.00),
('Dress', 2, 50.00),
('Sneakers', 2, 80.00),
('Board Game', 5, 35.00),
('Lamp', 4, 40.00),
('Chair', 4, 70.00),
('Notebook', 3, 5.00),
('Pen', 3, 2.00);

-- -- Insert Sales (30 records)
INSERT INTO Sales (ProductID, SaleDate, Quantity, TotalAmount)
VALUES
(1,'2022-01-01', 10, 5000.00),
(2,'2025-01-02', 5, 6000.00),
(3,'2026-05-03', 15, 2250.00),
(4,'2023-06-04', 20, 400.00),
(5,'2025-02-05', 10, 400.00),
(6,'2024-03-06', 12, 180.00),
(7,'2021-11-07', 8, 200.00),
(8,'2025-12-08', 6, 360.00),
(9,'2021-06-09', 4, 600.00),
(10,'2025-08-10', 30, 300.00),
(11,'2023-07-11', 10, 250.00),
(12,'2023-04-12', 7, 2100.00),
(13,'2025-06-13', 5, 1000.00),
(14,'2022-08-14', 6, 300.00),
(15,'2025-11-15', 4, 320.00),
(16,'2024-12-16', 3, 105.00),
(17,'2024-10-17', 2, 80.00),
(18,'2025-09-18', 1, 70.00),
(19,'2021-11-19', 20, 100.00),
(20,'2020-10-20', 25, 50.00),
(1,'2022-01-01', 5, 2500.00),
(2,'2023-05-02', 3, 3600.00),
(3,'2021-04-03', 10, 1500.00),
(4,'2024-02-04', 15, 300.00),
(5,'2022-03-05', 8, 320.00),
(6,'2021-12-06', 5, 75.00),
(7,'2022-02-07', 6, 150.00),
(8,'2024-10-08', 4, 240.00),
(9,'2022-09-09', 2, 300.00),
(10,'2025-12-10', 20, 200.00);

-- STEP 3: Complex Queries
-- -- 1. List products with total quantity sold and total sales amount
SELECT 
    p.ProductName,
    SUM(s.Quantity) AS TotalQuantity,
    SUM(s.TotalAmount) AS TotalSales
FROM Products p
JOIN Sales s ON p.ProductID = s.ProductID
GROUP BY p.ProductName
ORDER BY TotalSales DESC;

-- -- 2. Top 3 products with highest sales last month
SELECT 
    p.ProductName,
    SUM(s.TotalAmount) AS TotalSales
FROM Products p
JOIN Sales s ON p.ProductID = s.ProductID
WHERE s.SaleDate >= date_trunc('month', CURRENT_DATE - interval '1 month')
  AND s.SaleDate < date_trunc('month', CURRENT_DATE)
GROUP BY p.ProductName
ORDER BY TotalSales DESC
LIMIT 3;

-- -- 3. Cumulative sales amount over time (WINDOW function)
SELECT 
    SaleDate,
    SUM(TotalAmount) OVER (ORDER BY SaleDate) AS CumulativeSales
FROM Sales
ORDER BY SaleDate;

-- -- 4. Rank products based on total sales amount
SELECT 
    p.ProductName,
    SUM(s.TotalAmount) AS TotalSales,
    RANK() OVER (ORDER BY SUM(s.TotalAmount) DESC) AS SalesRank
FROM Products p
JOIN Sales s ON p.ProductID = s.ProductID
GROUP BY p.ProductName
ORDER BY SalesRank;

-- -- 5. Products whose sales are above average (Subquery)
SELECT ProductName, TotalSales
FROM (
    SELECT 
        p.ProductName,
        SUM(s.TotalAmount) AS TotalSales
    FROM Products p
    JOIN Sales s ON p.ProductID = s.ProductID
    GROUP BY p.ProductName
) AS ProductSales
WHERE TotalSales > (SELECT AVG(TotalAmount) FROM Sales);


-- STEP 4: Stored Procedure
CREATE OR REPLACE PROCEDURE GetCategorySales(
    IN p_CategoryID INT,
    IN p_StartDate DATE,
    IN p_EndDate DATE
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_TotalSales DECIMAL;
    v_CategoryName VARCHAR;
BEGIN
    SELECT c.CategoryName, SUM(s.TotalAmount)
    INTO v_CategoryName, v_TotalSales
    FROM Sales s
    JOIN Products p ON s.ProductID = p.ProductID
    JOIN Category c ON p.CategoryID = c.CategoryID
    WHERE c.CategoryID = p_CategoryID
      AND s.SaleDate BETWEEN p_StartDate AND p_EndDate
    GROUP BY c.CategoryName;

    RAISE NOTICE 'Category: %, Total Sales: %', v_CategoryName, v_TotalSales;
END;
$$;

-- Call procedure
CALL GetCategorySales(1, '2020-11-01', '2025-12-31');