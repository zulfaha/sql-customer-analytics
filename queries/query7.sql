-- Query 7: Payment Method Analysis
-- Business Question: How do customers pay, and does payment method affect order value?
-- Tables: payments
-- Techniques: COUNT DISTINCT, window function OVER(), AVG, SUM, GROUP BY
-- Notes: COUNT DISTINCT on order_id because one order can have multiple payment rows
--        boleto is a Brazilian cash-based bank slip
--        'not_defined' rows excluded from meaningful analysis (only 3 records)

SELECT 
    payment_type,
    COUNT(DISTINCT order_id) AS order_count,
    ROUND(COUNT(DISTINCT order_id) * 100.0 / SUM(COUNT(DISTINCT order_id)) OVER (), 2) AS pct_of_orders,
    ROUND(AVG(payment_value), 2) AS avg_order_value,
    ROUND(SUM(payment_value), 2) AS total_value
FROM payments
GROUP BY payment_type
ORDER BY order_count DESC;
