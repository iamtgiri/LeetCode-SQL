-- File: 1251-AverageSellingPrice.sql
--
-- Question: Average Selling Price
--
-- Tables:
-- Prices
-- +---------------+------------+------------+--------+
-- | product_id    | start_date | end_date   | price  |
-- +---------------+------------+------------+--------+
-- (product_id, start_date, end_date) is the primary key.
-- Each product has distinct (non-overlapping) price periods.
--
-- UnitsSold
-- +---------------+---------------+--------+
-- | product_id    | purchase_date | units  |
-- +---------------+---------------+--------+
-- Contains information on the number of units sold per date.
-- 
-- Task:
-- Find the average selling price for each product.
-- Formula: 
--   average_price = (Σ (price * units)) / (Σ units)
-- If a product has no sales, average_price = 0.
-- The result should be rounded to two decimal places.
--
-- Example:
-- For product 1:
--   (100 units * $5) + (15 units * $20) = 500 + 300 = 800
--   Total units = 115
--   Average = 800 / 115 = 6.9565 → 6.96
--
-- Approach (Detailed):
-- 1. Join `Prices` and `UnitsSold` on `product_id`, ensuring the sale date (`purchase_date`)
--    falls within the product's active price range (`start_date` ≤ `purchase_date` ≤ `end_date`).
-- 2. For each joined row, compute the total revenue (price × units).
-- 3. Aggregate by `product_id` to get:
--       - total revenue = SUM(price * units)
--       - total units = SUM(units)
-- 4. Compute average_price = total_revenue / total_units.
-- 5. Use `ROUND()` to round the result to two decimal places.
-- 6. Include products with no sales using LEFT JOIN from Prices to UnitsSold,
--    and replace NULL results with 0 using COALESCE.
--
-- Solution:
SELECT
    p.product_id,
    ROUND(
        COALESCE(SUM(u.units * p.price) / SUM(u.units), 0),
        2
    ) AS average_price
FROM
    Prices p
    LEFT JOIN UnitsSold u ON p.product_id = u.product_id
    AND u.purchase_date BETWEEN p.start_date AND p.end_date
GROUP BY
    p.product_id;