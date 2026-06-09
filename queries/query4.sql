-- Query 4: On-Time Delivery Performance by State
-- Business Question: Which states receive orders on time vs late, and by how much?
-- Tables: orders, customers
-- Techniques: CASE WHEN (conditional counting), ::date subtraction,::numeric cast, percentage calculation, NULL filtering
-- Notes: avg_days_vs_promise is negative = early, positive = late
--        CASE WHEN acts as a conditional counter (1 if true, 0 if false, SUM adds them up)

SELECT 
    c.customer_state,
    COUNT(o.order_id) AS delivered_orders,
    SUM(CASE WHEN o.order_delivered_customer_date <= o.order_estimated_delivery_date THEN 1 ELSE 0 END) AS on_time_orders,
    ROUND(SUM(CASE WHEN o.order_delivered_customer_date <= o.order_estimated_delivery_date 
    THEN 1 ELSE 0 END) * 100.0 / COUNT(o.order_id), 2)  AS on_time_pct,
    ROUND(AVG(o.order_delivered_customer_date::date - o.order_estimated_delivery_date::date), 2) AS avg_days_vs_promise
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
WHERE o.order_status = 'delivered'
  AND o.order_delivered_customer_date  IS NOT NULL
  AND o.order_estimated_delivery_date  IS NOT NULL
GROUP BY c.customer_state
ORDER BY on_time_pct ASC;


--THEN 1 yes Else 0 no
