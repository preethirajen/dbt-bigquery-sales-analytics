
{{ config(materialized='view') }}

WITH cleaned AS (
    SELECT
        order_id,
        customer_id,
        product_id,
        quantity,
        order_date,
        updated_at,
        INITCAP(TRIM(status)) AS status
    FROM {{ source('raw_data', 'orders') }}
),

deduplicated AS (
    SELECT *
    FROM cleaned
    QUALIFY ROW_NUMBER() OVER (
        PARTITION BY order_id
        ORDER BY updated_at DESC, order_date DESC
    ) = 1
)

SELECT *
FROM deduplicated
