---Q.1 Write a SQL Query to retrieve all columns for sales made on 2022-11-5
Select * 
from retail_sales
where sale_date = '2022-11-05';

---Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022:
Select * from retail_sales
where category = 'Clothing'
and TO_CHAR(sale_date, 'YYYY-MM') = '2022-11'
and quantiy >= 4;

---Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.:
Select category,
 SUM(total_sale) as net_sale,
 count(*) as total_orders
from retail_sales
group by 1;

--- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.:
Select
Round(AVG(age),2) as avg_age
from retail_sales where category = 'Beauty';

--- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.:
Select transactions_id 
from retail_sales
where total_sale > 1000;

--- Q.6: Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.:
Select 
category,
count(transactions_id) as number_of_transactions,
gender
from retail_sales
Group by category, gender
order by 1;

--- Q.7: Write a SQL query to calculate the average sale for each month. Find out best selling month in each year:
Select * from
( Select
extract(year from sale_date) as year,
extract(month from sale_date) as month,
AVG(total_sale) as total_sale,
rank() over(partition by extract(year from sale_date) order by AVG(total_sale) DESC)
from retail_sales
Group by 1,2 ) as t1
where rank = 1;

--- Q.8: *Write a SQL query to find the top 5 customers based on the highest total sales **:

Select 
customer_id,
SUM(total_sale) as total_sale
from retail_sales
group by 1
order by 2 DESC
LIMIT 5;

--- Q.9: Write a SQL query to find the number of unique customers who purchased items from each category.:
Select 
category,
count(distinct customer_id) as unique_customer
from retail_sales
group by category;

--- Q.10: Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17):
Select shift, Count(total_sale) as number_of_orders from
( Select *,
case
when extract(hour from sale_time) < 12 then 'morning'
when extract(hour from sale_time) > 17 then 'evening'
else 'afternoon'
end as shift
from retail_sales
) group by shift
order by 2 DESC;

--- END OF PROJECT
