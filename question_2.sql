SELECT EXTRACT(MONTH FROM orders.order_date::date) AS month,
       SUM(orders.product_quantity * dim_product.sale_price) 
FROM orders 
JOIN dim_product  ON orders.product_code = dim_product.product_code
WHERE EXTRACT(YEAR FROM orders.order_date::date) = 2022
GROUP BY month
ORDER BY SUM(orders.product_quantity * dim_product.sale_price) DESC
