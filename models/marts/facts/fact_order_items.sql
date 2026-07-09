{{
    config(
        materialized='incremental',
        unique_key='fact_order_item_key'
    )
}}

SELECT

    {{ dbt_utils.generate_surrogate_key([
    'order_id',
    'order_item_id'
    ]) }} AS fact_order_item_key,

    order_id,
    order_item_id,
    customer_id,
    product_id,
    seller_id,

    order_purchase_timestamp,
    shipping_limit_date,
    order_estimated_delivery_date,

    price,
    freight_value,
    {{ generate_load_timestamp() }} AS dbt_loaded_at

FROM {{ ref('int_order_details') }}


{% if is_incremental() %}

WHERE order_purchase_timestamp >
(
    SELECT MAX(order_purchase_timestamp)
    FROM {{ this }}
)

{% endif %}