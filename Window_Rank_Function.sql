-- Windows function - Ranking

-- Top/Bottom Analysis : Row_number,Rank,Dense_Rank,NTile

-- Distribution Analysis : Cume_dist,Percent_Rank


select * from Sales.Orders

-- Row_Number

SELECT ORDERID,sales,row_number() over (order by sales desc) rn
from  Sales.Orders

-- Rank 

SELECT ORDERID,sales,rank() over (order by sales desc) rn
from  Sales.Orders

-- Dense_Rank

SELECT ORDERID,sales,dense_rank() over (order by sales desc) rn
from  Sales.Orders

-- overall
select orderid,sales,drnk
from(
select 
	orderid,
	sales,
	row_number() over(order by sales desc) rn,
	rank() over(order by sales desc) rnk,
	DENSE_RANK() over(order by sales desc) drnk
from sales.Orders) t

where drnk = 2


-- find the top highest sales for each product
SELECT
	OrderID,
	ProductID,
	sales,
	rn
from(
	select
    OrderID,
	ProductID,
	sales,
	row_number() over(partition by productid order by sales desc) rn
    from sales.Orders
	) t
where rn = 1

-- find the lowest 2 customers based on their total sales

select
	*
from(
	select 
	CustomerID,
	sum(sales) sales,
	row_number() over(order by sum(sales)) rn
	from Sales.Orders
	group by CustomerID
)t
where rn in (1,2)


-- Assign unique IDs to the rows of the 'orders Archive'

select * from sales.OrdersArchive

select 
row_number() over (order by orderid) unique_id,
*
from Sales.OrdersArchive


-- Identify duplicate rows in the table 'order archive' and return a clean result without any duplicates

select
	*
from
	(select
		row_number() over (partition by orderid order by CreationTime) rn,
		*
		from Sales.OrdersArchive
		) t
where rn = 1

-- NTILE : Divides the rows into specified number of approximately equal groups(Buckets)

select 
orderid,
sales,
NTILE(1) over (order by sales desc) oneb,
NTILE(2) over (order by sales desc) twob,
NTILE(3) over (order by sales desc) threeb
from sales.Orders

-- Use case 

-- Data Segmentation : Divides a datset into distinct subsets based on criteria

-- segment all orders into 3 categories: High,Medium and low sales

select * from Sales.Orders

select
	orderid,
	sales,
	case bn
		when  1 then 'High'
		when  2 then 'Medium'
		else 'Low'
		end category
from(
select orderid,
sales,
ntile(3) over(order by sales desc) bn
from sales.Orders) t

-- Equalizing the load

-- In order to exort the data divide the orders into 2 groups

Select 
NTILE(2) over( order by orderid) Buckets,
*
from 
sales.orders

-- Percentage based on ranking

-- cume_dist

select 
	OrderID,
	sales,
(cume_dist() over(order by sales desc)*100) parttowhole
from sales.Orders


-- Percent Rank

select 
	OrderID,
	sales,
(PERCENT_RANK() over(order by sales desc)*100) Parttowhole,
(cume_dist() over(order by sales desc)*100) parttowholec
from sales.Orders

-- Find the products that fall within 40% of the prices

select 
	*
from
(
select
	product,
	price,
	cume_dist() over(order by price desc) distrank
from sales.products) t
where distrank<= 0.4

