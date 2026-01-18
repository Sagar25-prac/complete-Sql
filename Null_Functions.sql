select * from 
sales.orders

--Time gap Analysis
-- Find the number of days between each order and previous order

select
orderid,
OrderDate currentdate,
lag(orderdate) over (order by orderdate) previousdate,
datediff(day,lag(orderdate) over (order by orderdate),OrderDate) numberofdays
from sales.Orders

select 
isdate(OrderDate)
from Sales.Orders

select isdate('2025')

-- Null functions
-- Null to Values isnull and coalesce
-- Values to Null Nullif
-- Null Validation Is NUll and Is Not Null

select * from Sales.Orders
-- isnull
Select *,
isnull(shipaddress,'unknown') ship_address,
isnull(billaddress,isnull(shipaddress,'unknown')) bill_address
from sales.orders

-- coalesce

select *,
coalesce(BillAddress,shipaddress,'Unkown') test
from Sales.Orders

-- find avg sccore of the customers
select * from sales.Customers

select
CustomerID,
score,
Avg(score) over() Avgscr,
Avg(coalesce(score,0)) over() Avgscr1
from Sales.Customers

-- Display the full name of customers in single field
-- by merging their first and last name
-- and add 10 bonuspoints to each customers score.

select *,
CONCAT(firstname,' ',lastname) full_name,
(firstname+lastname) fullname1,
(firstname + coalesce(lastname,'')) fullname2,
(score+10) new_score
from Sales.Customers
order by lastname

-- find the sales price for each order by dividing sales by quantity

select *,
sales / nullif(Quantity,0) price1, -- to get value as null
(sales/case when Quantity = 0 then 1 else Quantity end) price -- to get nominator value by converting o of denominator to 1
from sales.Orders

-- Identify the customers who have no lastname

select *
from sales.Customers
where LastName is null

-- -- Identify the only customers who have  lastname


select *
from sales.Customers
where LastName is not null

-- list all details for customers who have not placed any orders

select *
from sales.Customers

select *
from sales.orders

select a.customerid, a.firstname,a.lastname
from sales.Customers a
left join sales.Orders b on a.CustomerID = b.CustomerID 
where b.CustomerID is null

-- Null is lie we dont know the value
-- Empty String is a string value has Zero characters
-- Blank string is a string which has 1 or more spaces

