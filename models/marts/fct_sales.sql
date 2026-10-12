
{{ config(materialized='table', schema='marts') }}

SELECT
    o.order_id,
    o.order_date,
    o.updated_at,
    c.customer_name,
    c.country,
    p.product_name,
    p.category,
    o.quantity,
    p.unit_price,
    o.quantity * p.unit_price AS revenue

FROM {{ ref('stg_orders') }} o

LEFT JOIN {{ ref('stg_customers') }} c
    ON o.customer_id = c.customer_id

LEFT JOIN {{ ref('stg_products') }} p
    ON o.product_id = p.product_id

WHERE o.status = 'Completed'
  AND o.quantity IS NOT NULL
  AND c.customer_id IS NOT NULL
