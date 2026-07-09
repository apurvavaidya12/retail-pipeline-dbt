{% snapshot customer_snapshot %}

{{
    config(
        target_schema='snapshots',
        unique_key='customer_id',

        strategy='check',

        check_cols=[
            'customer_city',
            'customer_state',
            'customer_zip_code_prefix'
        ]
    )
}}

SELECT *
FROM {{ ref('stg_customers') }}

{% endsnapshot %}