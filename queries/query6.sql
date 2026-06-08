-- Query 6: Customer Purchase Frequency 
-- Business Question: What proportion of customers are one-time vs repeat buyers?
-- Tables: orders, customers
-- Techniques: CTE, CASE WHEN, COUNT DISTINCT, window function OVER()
-- Notes: customer_unique_id used (not customer_id) because the dataset assigns
--        a new customer_id per order — unique_id identifies returning customers
--        CTE required because cant GROUP BY an aggregated value in one step

--Step 1 (CTE):    Count orders per customer → temporary table

WITH customer_orders AS (
    SELECT 
        c.customer_unique_id,
        COUNT(DISTINCT o.order_id)  AS order_count
    FROM orders o
    JOIN customers c ON o.customer_id = c.customer_id
    WHERE o.order_status NOT IN ('canceled', 'unavailable')
    GROUP BY c.customer_unique_id)

/* 
Step 2 (CASE):   Label each customer as one-time,2 orders, 3-5, 6+
Step 3 (GROUP):  Count how many customers are in each label
Step 4 (OVER):   Calculate each label's % of total customers
*/

SELECT 
    CASE 
        WHEN order_count = 1  THEN '1 order (one-time)'
        WHEN order_count = 2  THEN '2 orders'
        WHEN order_count BETWEEN 3 AND 5 THEN '3-5 orders'
        ELSE '6+ orders'
    END  AS customer_segment,
    COUNT(*)  AS customer_count,
    ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (), 2) AS pct_of_customers
FROM customer_orders
GROUP BY customer_segment
ORDER BY customer_count DESC;
