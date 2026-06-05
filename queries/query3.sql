-- Query 3: Average Delivery Time by State
-- Business Question: Does delivery performance vary by geography?
-- Tables used: orders, customers
-- Limitation: Does not prove delivery time causes churn

SELECT 
    order_status,
    COUNT(*) AS order_count,
    ROUND(AVG(EXTRACT(DAY FROM AGE(order_delivered_customer_date, order_purchase_timestamp))), 2) AS avg_days
FROM orders
WHERE order_delivered_customer_date IS NOT NULL
GROUP BY order_status;
