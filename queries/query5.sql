-- Query 5: Revenue by Product Category (Top 15)
-- Business Question: Which product categories drive the most revenue?
-- Tables: order_items, orders, products
-- Techniques: COALESCE, COUNT DISTINCT, SUM, AVG, GROUP BY, LIMIT
-- Notes: order_items is the base table as price data lives there
--        COALESCE replaces NULL category names with 'Unknown'
--        COUNT DISTINCT on order_id to avoid counting the same orders twice

SELECT 
    COALESCE(p.product_category_name, 'Unknown') AS category,
    COUNT(DISTINCT o.order_id) AS total_orders,
    ROUND(SUM(oi.price), 2) AS total_revenue,
    ROUND(AVG(oi.price), 2) AS avg_item_price
FROM order_items oi
JOIN orders   o ON oi.order_id   = o.order_id
JOIN products p ON oi.product_id = p.product_id
WHERE o.order_status NOT IN ('canceled', 'unavailable')
GROUP BY p.product_category_name
ORDER BY total_revenue DESC
LIMIT 15;
