select 
    order_month, 
    avg(total_sales_amount) as avg_order_value
from RAW.transformed_sales_data
where order_year = 2023
group by order_month
order by order_month;
