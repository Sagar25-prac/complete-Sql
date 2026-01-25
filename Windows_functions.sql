use SalesDB

-- Window functions 
-- Aggregate fuctions - count,sum,avg,min max.
-- Rank functions - row_number,rank,dense_rank,cume_dist,percent_rank,Ntile.
-- Value (Analytical Functions) - lead,lag,first_value.

-- find the total sales across all orders

select 
sum(sales) Totalsales
from Sales.Orders 

-- find the total sales for each product

select 
PRODUCTid,
sum(sales) Totalsales
from Sales.Orders 
group by PRODUCTid

-- find the total sales for each product and provide details such as orderid and orderdate

select 
productid,
orderid,
orderdate,
sum(sales) over( partition by productid )
from Sales.Orders 


/*
Window function(like sum avg) order clause(Partition clause,order clause and frame clause)
eg:
Avg(sales) over (partition by category order by orderdate rows unbounded preceding)
*/


-- find the total sales across all orders Additionally provide details such order id and order date

select 
orderid,
orderdate,
sum(sales) over () Totalsales
from Sales.Orders

-- find the total sales across all orders AND ind the total sales for each product and provide details such as orderid and orderdate

select 
productid,
orderid,
orderdate,
sales,
sum(sales) over( partition by productid) Totalsalesbyproduct,
SUM(SALES) over () TotalSales
from Sales.Orders 


-- find the total sales across all orders AND ind the total sales for each product and order status  and provide details such as orderid and orderdate

select 
productid,
orderid,
orderdate,
sales,
orderstatus,
sum(sales) over( partition by productid,orderstatus) Totalsalesbyorpr,
SUM(SALES) over () TotalSales
from Sales.Orders 

-- Rank each order based on their sales from highest to lowest

select
orderid,
sales,
Rank() over ( order by sales desc) rank
from Sales.Orders

select
orderid,
sales,
Dense_rank() over(order by sales desc) rank
from Sales.Orders

select OrderID,
DENSE_rank() over ( order by sales desc) rank
from sales.Orders;


WITH ranked as (
		select orderid,
		rank() over (order by sales desc) asra
		from Sales.Orders
	)
select orderid from ranked where asra = 2

/* 
Frame clause 

Avg(sales) over (partition by category order by orderdate Rows Between current row and unbounded following)

Frame types --- Rows and Range
Frame boundary (lower value) --- Current row, N preceding, Unbound preceding.
Frame boundary (highest value) --- Current row,N following, Unbound following

Rule : only used together with order by clause
	   Lower value must be before the higher value
	   
 */


-- running total by month

select * from Sales.Orders  order by orderdate


select format(orderdate,'MMM') Month,
sum(sales) over (order by orderdate rows between unbounded preceding and current row) Running_total
from sales.orders;


With run as (
select  EOMONTH(orderdate) monyear, format(orderdate,'MMM') Month, Sum(sales) sales
from sales.orders
group by format(orderdate,'MMM'),EOMONTH(orderdate)
)

select monyear,month,sum(sales) over ( order by monyear) as runningsales from run


-- rank customers based on thier total sales

select * from Sales.Orders;

with ranks as(
select CustomerID,sum(sales) totalsales
from Sales.Orders 
group by CustomerID)

select customerid,totalsales,rank() over( order by totalsales desc) rank
from ranks

select CustomerID,sum(sales) totalsales, rank() over (order by sum(sales) desc) rank
from Sales.Orders 
group by CustomerID
