SELECT

    order_id,
    order_item_id,
    customer_id,
    product_id,
    seller_id,

    order_purchase_timestamp,
    shipping_limit_date,
    order_estimated_delivery_date,

    price,
    freight_value

FROM {{ ref('int_order_details') }}