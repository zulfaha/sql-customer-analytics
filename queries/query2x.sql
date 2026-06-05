SELECT 
    p.product_category_name,
    o.order_status,
    COUNT(*) AS order_count,
    ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER(PARTITION BY p.product_category_name), 2) AS pct_of_category
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
JOIN products p ON oi.product_id = p.product_id
WHERE o.order_status = 'canceled'
GROUP BY p.product_category_name, o.order_status
ORDER BY order_count DESC;

This joins three tables, filters to
cancelled only, and shows which categories dominate cancellations.
 
  
