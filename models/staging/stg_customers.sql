
{{ config(materialized='view') }}

SELECT
    customer_id,
    TRIM(customer_name) AS customer_name,
    LOWER(TRIM(email)) AS email,
    UPPER(TRIM(country)) AS country
FROM {{ source('raw_data', 'customers') }}
