SELECT dim_product.category, SUM(orders.product_quantity * (dim_product.sale_price - dim_product.cost_price)) AS total_profit
FROM orders 
JOIN dim_store  ON orders.store_code = dim_store.store_code
JOIN dim_product  ON orders.product_code = dim_product.product_code
WHERE dim_store.full_region = 'Wiltshire, UK' 
      AND EXTRACT(YEAR FROM orders.order_date::date) = 2021
GROUP BY dim_product.category
ORDER BY total_profit DESC
