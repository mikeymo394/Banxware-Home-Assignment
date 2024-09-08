
  create or replace   view home_assignment.RAW.transformed_sales_data
  
   as (
    with sales as (
    select 
        order_id,
        order_date,
        customer_id,
        product_id,
        product_name,
        quantity,
        price,
        order_status,
        -- Cast order_date to DATE
        cast(order_date as date) as order_date_casted,
        -- Extract year, month, day from the casted date
        extract(year from cast(order_date as date)) as order_year,
        extract(month from cast(order_date as date)) as order_month,
        extract(day from cast(order_date as date)) as order_day,
        -- Calculate total sales amount
        quantity * price as total_sales_amount
    from home_assignment.RAW.sales
)

select * from sales
  );

