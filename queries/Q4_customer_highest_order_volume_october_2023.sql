select 
    customer_id, 
    count(order_id) as order_count
from RAW.transformed_sales_data
where order_year = 2023
and order_month = 10
group by customer_id
order by order_count desc
limit 1;
