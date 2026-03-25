-- Zepto Data Exploration & Debugging Queries
-- This file contains intermediate queries used during data cleaning and validation


--  Initial Data Check
SELECT COUNT(*) AS total_rows FROM zepto;

SELECT * 
FROM zepto 
LIMIT 10;

DESCRIBE zepto;


--  Fix column naming issue (BOM issue)
ALTER TABLE zepto
CHANGE `ï»¿Category` category VARCHAR(120);


--  Check for NULL values
SELECT * 
FROM zepto
WHERE category IS NULL
   OR name IS NULL
   OR mrp IS NULL
   OR discountPercent IS NULL
   OR availableQuantity IS NULL
   OR discountedSellingPrice IS NULL
   OR weightInGms IS NULL
   OR outOfStock IS NULL
   OR quantity IS NULL;


--  Explore unique categories
SELECT DISTINCT category 
FROM zepto
ORDER BY category;


--  Stock status distribution
SELECT outOfStock, COUNT(*) AS total_products
FROM zepto
GROUP BY outOfStock;


--  Check duplicate product names
SELECT 
    name, 
    COUNT(*) AS number_of_skus
FROM zepto 
GROUP BY name
HAVING COUNT(*) > 1
ORDER BY number_of_skus DESC;


--  Price conversion check (Paise → Rupees)
SELECT 
    name,
    mrp/100 AS mrp_rupees,
    discountedSellingPrice/100 AS selling_price_rupees
FROM zepto;

-- Discount calculation check
SELECT 
    name,
    (mrp - discountedSellingPrice)/100 AS discount_rupees
FROM zepto
ORDER BY discount_rupees DESC
LIMIT 10;


--  Debugging: Stock condition testing

-- Check stock values
SELECT DISTINCT outOfStock FROM zepto;

-- Count out-of-stock products
SELECT COUNT(*) 
FROM zepto
WHERE outOfStock = 'TRUE';

-- Verify price range for out-of-stock products
SELECT 
    MIN(mrp) AS min_price,
    MAX(mrp) AS max_price
FROM zepto
WHERE outOfStock = 'TRUE';


-- Observation:
-- outOfStock is stored as STRING ('TRUE'/'FALSE')
-- mrp values are stored in PAISE and require conversion (/100) 