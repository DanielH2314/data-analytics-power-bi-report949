SELECT
    dim_store.store_type,
    SUM(orders.product_quantity * dim_product.sale_price) AS total_sales,
    COUNT(orders.order_date) AS total_orders,
    (SUM(orders.product_quantity * dim_product.sale_price) / (SELECT SUM(orders.product_quantity * dim_product.sale_price) FROM orders JOIN dim_product ON orders.product_code = dim_product.product_code)) * 100 AS percentage_of_total_sales
FROM dim_store 
JOIN orders ON dim_store.store_code = orders.store_code
JOIN dim_product ON orders.product_code = dim_product.product_code
GROUP BY dim_store.store_type
