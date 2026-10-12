{{
    config(
        materialized='incremental',
        schema='marts',
        unique_key='order_id',
        incremental_strategy='merge'
    )
}}

SELECT *
FROM {{ ref('fct_sales') }}

{% if is_incremental() %}

WHERE updated_at >= (
    SELECT COALESCE(
        MAX(updated_at),
        TIMESTAMP '1900-01-01 00:00:00+00'
    )
    FROM {{ this }}
)

{% endif %}