# Retail Sales Analysis SQL Project
   # Project Overview
Project Title: Retail Sales Analysis

This project is designed to demonstrate SQL skills and techniques typically used by data analysts to explore, clean, and analyze retail sales data. The project involves setting up a retail sales database, performing exploratory data analysis (EDA), and answering specific business questions through SQL queries. This project is ideal for those who are starting their journey in data analysis and want to build a solid foundation in SQL.

   # Objectives
Set up a retail sales database: Create and populate a retail sales database with the provided sales data.
Data Cleaning: Identify and remove any records with missing or null values.
Exploratory Data Analysis (EDA): Perform basic exploratory data analysis to understand the dataset.
Business Analysis: Use SQL to answer specific business questions and derive insights from the sales data.

# 📊 Project Structure

## 1. Database Setup

- **Database Creation**: The project starts by creating a database named `p1_retail_db`.

- **Table Creation**: A table named `retail_sales` is created to store the sales data. The table structure includes columns for transaction ID, sale date, sale time, customer ID, gender, age, product category, quantity sold, price per unit, cost of goods sold (COGS), and total sale amount.

```sql
CREATE DATABASE p1_retail_db;

CREATE TABLE retail_sales (
    transactions_id INT PRIMARY KEY,
    sale_date DATE,
    sale_time TIME,
    customer_id INT,
    gender VARCHAR(10),
    age INT,
    category VARCHAR(35),
    quantity INT,
    price_per_unit FLOAT,
    cogs FLOAT,
    total_sale FLOAT
 );
```
## 2.  Data Exploration & Cleaning
- **Record Count**: Determine the total number of records in the dataset.
- **Customer Count**: Find out how many unique customers are in the dataset.
- **Category Count**: Identify all unique product categories in the dataset.
- **Null Value Check**: Check for any null values in the dataset and delete records with missing data.
  
```sql
SELECT COUNT(*) FROM retail_sales;

SELECT COUNT(DISTINCT customer_id) FROM retail_sales;

SELECT DISTINCT category FROM retail_sales;

SELECT * FROM retail_sales
WHERE 
    sale_date IS NULL OR sale_time IS NULL OR customer_id IS NULL OR 
    gender IS NULL OR age IS NULL OR category IS NULL OR 
    quantity IS NULL OR price_per_unit IS NULL OR cogs IS NULL;

DELETE FROM retail_sales
WHERE 
    sale_date IS NULL OR sale_time IS NULL OR customer_id IS NULL OR 
    gender IS NULL OR age IS NULL OR category IS NULL OR 
    quantity IS NULL OR price_per_unit IS NULL OR cogs IS NULL;
```
## 3. Data Analysis & Findings
- The following SQL queries were developed to answer specific business questions:
+ **Q.1 Write a SQL Query to retrieve all columns for sales made on 2022-11-5**
```sql
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
```
--- **Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.:**
```sql
Select
Round(AVG(age),2) as avg_age
from retail_sales where category = 'Beauty';
```
--- **Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.:**

```sql
Select transactions_id 
from retail_sales
where total_sale > 1000;
```
--- **Q.6: Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.:**

```sql
Select 
category,
count(transactions_id) as number_of_transactions,
gender
from retail_sales
Group by category, gender
order by 1;
```
--- **Q.7: Write a SQL query to calculate the average sale for each month. Find out best selling month in each year:**
```sql
Select * from
( Select
extract(year from sale_date) as year,
extract(month from sale_date) as month,
AVG(total_sale) as total_sale,
rank() over(partition by extract(year from sale_date) order by AVG(total_sale) DESC)
from retail_sales
Group by 1,2 ) as t1
where rank = 1;
```
--- **Q.8: *Write a SQL query to find the top 5 customers based on the highest total sales: **

```sql
Select 
customer_id,
SUM(total_sale) as total_sale
from retail_sales
group by 1
order by 2 DESC
LIMIT 5;
```
--- **Q.9: Write a SQL query to find the number of unique customers who purchased items from each category.:**

```sql
Select 
category,
count(distinct customer_id) as unique_customer
from retail_sales
group by category;
```
--- Q.10: **Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17): **
```sql
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
```
## 4. Findings
- **Customer Demographics:** The dataset includes customers from various age groups, with sales distributed across different categories such as Clothing and Beauty.
- **High-Value Transactions:** Several transactions had a total sale amount greater than 1000, indicating premium purchases.
- **Sales Trends:** Monthly analysis shows variations in sales, helping identify peak seasons.
- **Customer Insights:** The analysis identifies the top-spending customers and the most popular product categories.
## 5. Reports
- **Sales Summary:** A detailed report summarizing total sales, customer demographics, and category performance.
- **Trend Analysis:** Insights into sales trends across different months and shifts.
- **Customer Insights:** Reports on top customers and unique customer counts per category.
## 6. Conclusion
**This project serves as a comprehensive introduction to SQL for data analysts, covering database setup, data cleaning, exploratory data analysis, and business-driven SQL queries. The findings from this project can help drive business decisions by understanding sales patterns, customer behavior, and product performance.**
