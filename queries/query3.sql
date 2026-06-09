-- Query 3: Delivery Performance by State
-- Business Question: Which states get slow,expensive delivery?
-- Tables: orders, customers, order_items
-- Techniques: DATE subtraction (::date),::numeric cast,AVG/MIN/MAX,GROUP BY, NULL filtering
-- Notes: Columns cast to ::date because they are stored as timestamps in PostgreSQL
--        ::numeric cast required for ROUND() to accept AVG output in PostgreSQL


SELECT 
    order_delivered_carrier_date,
    order_delivered_customer_date
FROM orders
WHERE order_status = 'delivered'
LIMIT 5;

SELECT 
    c.customer_state,
    COUNT(o.order_id) AS delivered_orders,
   ROUND(AVG(o.order_delivered_carrier_date::date - o.order_delivered_customer_date::date), 2) AS avg_transit_days,
    ROUND(MIN(o.order_delivered_carrier_date::date - o.order_delivered_customer_date::date)::numeric, 2) AS min_transit_days,
    ROUND(MAX(o.order_delivered_carrier_date::date - o.order_delivered_customer_date::date)::numeric, 2) AS max_transit_days,
    ROUND(AVG(oi.freight_value)::numeric, 2) AS avg_freight_cost
FROM orders o
JOIN customers   c  ON o.customer_id = c.customer_id
JOIN order_items oi ON o.order_id    = oi.order_id
WHERE o.order_status = 'delivered'
  AND o.order_delivered_carrier_date    IS NOT NULL
  AND o.order_delivered_customer_date   IS NOT NULL
GROUP BY c.customer_state
ORDER BY avg_transit_days DESC;
