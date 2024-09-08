select 
    customer_id, 
    sum(total_sales_amount) as total_sales
from RAW.transformed_sales_data
where order_year = 2023
group by customer_id
order by total_sales desc
limit 5;
