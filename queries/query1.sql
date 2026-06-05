-- Query 1: Customer Distribution by State
-- Business Question: Where are our customers concentrated geographically?
-- Tables: customers
-- Techniques: GROUP BY, COUNT, ORDER BY

SELECT 
    customer_state,
    COUNT(*) AS customer_count
FROM customers
GROUP BY customer_state
ORDER BY customer_count DESC;
