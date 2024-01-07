SELECT dim_store.store_type,
       SUM(orders.product_quantity * dim_product.sale_price) AS total_revenue
FROM orders 
JOIN dim_store ON orders.store_code = dim_store.store_code
JOIN dim_product  ON orders.product_code = dim_product.product_code
WHERE EXTRACT(YEAR FROM orders.order_date::date) = 2022
      AND dim_store.country_code = 'DE'
GROUP BY dim_store.store_type
ORDER BY total_revenue DESC
