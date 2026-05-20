-- ============================================
-- Zepto E-Commerce SQL Analysis Project
-- Dataset: Zepto Product Inventory
-- ============================================

create database zepto_sql_project;

use zepto_sql_project;

drop database zepto_sql_project;

create table zepto(
	sku_id serial primary key,
    category varchar(120),
    name varchar(150) not null,
    mrp numeric(8,2),
    discountpercent numeric(5,2),
    avaiablequantity int,
    discountsellingprice numeric(8,2),
    weightgms int,
    outofstock boolean,
    quantity int
);


-- ============================================
-- SECTION 1: DATA EXPLORATION
-- ============================================

-- Count of rows
select count(*) from zepto;

-- sample data
select * from zepto
limit 10;

-- null values
select * from zepto
where name is null 
or
mrp is null
or
discountPercent is null 
or
availableQuantity is null 
or
discountedSellingPrice is null
or
weightInGms is null
or
outOfStock is null
or
quantity is null;

-- different products category
select distinct category
from zepto
order by category;

-- products in stock vs out of stock
select outOfStock ,count(sku_id)
from zepto
group by outOfStock;

-- Product names present multiple times
SELECT name,COUNT(sku_id) as "Number of sku's"
from zepto
group by name
having count(sku_id) > 1
order by count(sku_id) desc;

-- ============================================
-- SECTION 2: DATA CLEANING
-- ============================================

-- Products with price = 0
select * from zepto
where mrp = 0 or discountedSellingPrice = 0;

delete from zepto
where mrp = 0;

SET SQL_SAFE_UPDATES = 0;

-- convert pasie to rupees
update zepto
set mrp = mrp/100.0,
discountedSellingPrice = discountedSellingPrice/100.0;

select mrp,discountedSellingPrice from zepto;

-- ============================================
-- SECTION 3: BUSINESS INSIGHTS & ANALYSIS
-- ============================================

-- Q1 Find the top 10 best-value products based on the discount percentage.
select distinct name,mrp,discountPercent
from zepto
order by discountPercent desc
limit 10;

-- Q2 What are the products with high mrp but out of stock.
select distinct name, mrp
from zepto
where outOfStock  = True and mrp > 300
order by mrp desc;

-- Q3 Calculate Estimated revenue for each category.
select category,
sum(discountedSellingPrice * availableQuantity) as total_revenue
from zepto
group by category
order by total_revenue;

-- Q4 Find all products where mrp is greater than ₹500 and discount is less than 10%.
select distinct name,mrp,discountPercent
from zepto
where mrp > 500 and discountPercent < 10
order by mrp desc,discountPercent desc; 

-- Q5 Identity the top 5 categories offereing the highest average discount percentage.
select category,
round(avg(discountPercent),2) as avg_discount
from zepto
group by category
order by avg_discount desc
limit 5;

-- Q6 Find the price per gram for products above 100 g and sort by best values.
select distinct name,weightInGms,discountedSellingPrice,
round(discountedSellingPrice/weightInGms,2) as price_per_grm
from zepto
where weightInGms >=100
order by price_per_grm;

-- Q7 Group the products into categories like low,medium , bulk.
select distinct name ,weightInGms,
case when weightInGms < 1000 then "low"
	when weightInGms < 5000 then "medium"
    else "bulk"
    end as weight_category
from zepto;
		
-- Q8 What is the Total inventory weight per category.
select category,
sum(weightInGms * availableQuantity) as total_weight
from zepto
group by category
order by total_weight;


