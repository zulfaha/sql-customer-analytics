SELECT 
    order_status,
    COUNT(*) AS order_count,
    ROUND(AVG(EXTRACT(DAY FROM AGE(order_delivered_customer_date, order_purchase_timestamp))), 2) AS avg_days
FROM orders
WHERE order_delivered_customer_date IS NOT NULL
GROUP BY order_status;
