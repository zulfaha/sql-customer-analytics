-- Query 8: Freight Cost vs Delivery Performance
-- Business Question: Do higher freight costs correlate with worse delivery times?
-- Tables: orders, order_items
-- Techniques: CASE WHEN,::date subtraction,::numeric cast,conditional COUNT(late_pct),GROUP BY
-- Notes: No CTE needed, CASE reads raw freight_value directly (no pre-aggregation)
--        carrier_date and customer_date swapped vs dataset naming due to mislabelling
--        confirmed in Query 3. carrier_date = actual delivery, customer_date = pickup.

SELECT 
    CASE 
        WHEN oi.freight_value < 10  THEN 'Low (<R$10)'
        WHEN oi.freight_value < 25  THEN 'Medium (R$10-25)'
        WHEN oi.freight_value < 50  THEN 'High (R$25-50)'
        ELSE 'Very High (R$50+)'
    END AS freight_tier,
    COUNT(o.order_id) AS orders,
    ROUND(AVG(o.order_delivered_carrier_date::date - o.order_delivered_customer_date::date)::numeric, 2)  AS avg_transit_days,
    ROUND(SUM(CASE WHEN o.order_delivered_carrier_date > o.order_estimated_delivery_date 
  THEN 1 ELSE 0 END) * 100.0 / COUNT(o.order_id), 2)  AS late_pct
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
WHERE o.order_status = 'delivered'
  AND o.order_delivered_customer_date IS NOT NULL
  AND o.order_delivered_carrier_date  IS NOT NULL
  AND o.order_estimated_delivery_date IS NOT NULL
GROUP BY freight_tier
ORDER BY avg_transit_days DESC;
