
{{ config(materialized='view') }}

SELECT
    product_id,
    INITCAP(TRIM(product_name)) AS product_name,
    TRIM(category) AS category,
    unit_price
FROM {{ source('raw_data', 'products') }}
