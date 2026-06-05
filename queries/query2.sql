



SELECT 
    order_status,
    COUNT(*) AS order_count,
    ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (), 2) AS pct_of_all_orders
FROM orders
GROUP BY order_status
ORDER BY order_count DESC;
