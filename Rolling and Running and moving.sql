

-- Running and Rolling total

-- Running total : Aggregates all values from begining up to the current point without dropping off older data
-- Rolling total : Aggregate all values within a fixed time window (eg.30 days)


-- Moving Average

-- Calculate the moving average of sales for each product over time

select * from Sales.Orders

select productid,
orderdate,
sales,
avg(sales) over (partition by productid) Avgbyproduct,
avg(sales) over (partition by productid order by orderdate) Movingavg
from sales.orders

-- Calculate the moving average of sales for each product over time,including only the next order

select productid,
orderdate,
sales,
avg(sales) over (partition by productid) Avgbyproduct,
avg(sales) over (partition by productid order by orderdate) Movingavg,
avg(sales) over (partition by productid order by orderdate rows between current row and 1 following) rollimgavg
from sales.orders
