-- Zepto SQL Data Analysis Project

-- Data Exploration
SELECT COUNT(*) AS total_rows FROM zepto;

SELECT * 
FROM zepto 
LIMIT 10;

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

--  Unique categories
SELECT DISTINCT category 
FROM zepto
ORDER BY category;

------------------------------------------------------------

-- 🟢 Q1: Top 10 best-value products (highest discount %)
SELECT 
    name,
    mrp/100 AS original_price,
    discountedSellingPrice/100 AS selling_price,
    discountPercent
FROM zepto
ORDER BY discountPercent DESC
LIMIT 10;

------------------------------------------------------------

-- 🟢 Q2: High MRP products that are out of stock
SELECT 
    name,
    mrp/100 AS price_rupees,
    discountPercent
FROM zepto
WHERE outOfStock = 'TRUE'
  AND mrp > 30000
ORDER BY price_rupees DESC;

------------------------------------------------------------

--  Q3: Estimated revenue per category
SELECT 
    category,
    ROUND(SUM((discountedSellingPrice * quantity) / 100), 2) AS total_revenue_rupees
FROM zepto
GROUP BY category
ORDER BY total_revenue_rupees DESC;

------------------------------------------------------------

--  Q4: Products with MRP > ₹500 and discount < 10%
SELECT 
    category,
    name, 
    mrp/100 AS price_rupees, 
    discountPercent
FROM zepto
WHERE mrp > 50000
  AND discountPercent < 10
ORDER BY price_rupees DESC;

------------------------------------------------------------

--  Q5: Top 5 categories with highest average discount
SELECT 
    category,
    ROUND(AVG(discountPercent), 2) AS avg_discount
FROM zepto
GROUP BY category
ORDER BY avg_discount DESC
LIMIT 5;

------------------------------------------------------------

--  Q6: Price per gram (best value products above 100g)
SELECT 
    name, 
    category,
    weightInGms, 
    ROUND((discountedSellingPrice / 100) / weightInGms, 4) AS price_per_gram
FROM zepto
WHERE weightInGms >= 100
ORDER BY price_per_gram ASC
LIMIT 10;

------------------------------------------------------------

--  Q7: Categorize products by weight
SELECT 
    name,
    category,
    weightInGms,
    CASE 
        WHEN weightInGms < 1000 THEN 'Low'
        WHEN weightInGms BETWEEN 1000 AND 5000 THEN 'Medium'
        ELSE 'Bulk'
    END AS weight_category
FROM zepto;

------------------------------------------------------------

--  Q8: Total inventory weight per category (in kg)
SELECT 
    category,
    ROUND(SUM(weightInGms * availableQuantity) / 1000, 2) AS total_weight_kg
FROM zepto
GROUP BY category
ORDER BY total_weight_kg DESC;