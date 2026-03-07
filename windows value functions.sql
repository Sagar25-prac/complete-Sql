use SalesDB

-- lead access value from next rows
-- lag access value from previous rows


-- Analyse the month ocver month performance by finfing the percentage change in sales bwtwwen currrent and previous month

--select * from sales.Orders;

;with query as
	(select 
	month(orderdate) ordermonth,
	sum(sales) curr_mon_sal,
	lag(sum(sales)) over (order by month(orderdate)) previous_month
from sales.Orders
group by month(orderdate))

select
	*,
	curr_mon_sal - previous_month as MoM_change,
	round(cast((curr_mon_sal - previous_month) as float)/previous_month * 100,0) MoM_per
from query


--Customer Retention analysis

-- In order to analyse customer loyalty,
--rank customers based on the average days between their ordres

--select * from Sales.Orders
;with query_1 as
	 (select 
		orderid,
		customerid,
		orderdate as currentorder,
		lead(orderdate) over(partition by customerid order by orderdate) nextorder,
		datediff(day,orderdate,lead(orderdate) over(partition by customerid order by orderdate)) diffdays
		from sales.Orders
	
	)

select
	customerid,
	avg(diffdays) avgdays,
	rank() over (order by isnull(avg(diffdays),999999)) rankavg
from query_1
group by customerid

-- find the highest and lowest sales for each product

select 
	productid,
	min(sales) minsales,
	max(sales) maxsales
from Sales.Orders
group by productid