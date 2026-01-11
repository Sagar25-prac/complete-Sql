use SalesDB
-- Sql Functions
-- Single row functions (string functions,Numeric functions and date and time functions and null functions)
-- Multi-row functions (Aggregate Functions,Windows Function)

-- String Functions
-- manipulation (concat,upper,lower,trim,replace)
-- calculation(len)
-- string extraction(left,right,substring)

select * from Sales.Customers

select concat(firstname,' ',LastName) as Name
from Sales.Customers

select upper(concat(firstname,' ',LastName))as Name
from Sales.Customers

select lower(concat(firstname,' ',LastName))as Name
from Sales.Customers

select trim(firstname) as name
from Sales.Customers

use MyDatabase

select * from dbo.customers

select first_name from customers
where first_name != trim(first_name)

select '123-456-678',
replace('123-456-678','-','') as clean_phone

select first_name,len(first_name) as lenchar,trim(first_name) as trimname, len(trim(first_name)) as lentrichar
from customers

select first_name,left(first_name,2) as leftname, left(trim(first_name),2) as trimname,right(first_name,2) as rightname
from customers

select first_name,SUBSTRING(trim(first_name),2,len(first_name)) as name
from customers

-- Numeric Functions

select 
3.516,
round(3.516,2) as round_2,
round(3.516,1) as round_1,
round(3.516,0) as round_0

select 
-10,
abs(-10),
abs(10)

-- Date and Time Functions
use SalesDB

select 
OrderID,
OrderDate,
ShipDate,
CreationTime
from sales.Orders


select 
OrderID,
CreationTime,
'2025-08-20' 'hardcoded',
getdate() today
from Sales.Orders

-- Part Extraction (Day,Month,Year,DatePart,DateName,DateTrunc,Eomonth)
-- Format and Casting (Format,Convert,Cast)
-- Calculations (Dateadd,Datediff)
-- Validation (isdate)



select 
OrderID,
OrderDate,
day(orderdate) as 'date',
month(orderdate) as 'month',
year(orderdate) as 'year',
DATEPART(week,OrderDate) as 'week',
DATEPART(mm,orderdate) as 'month',
DATEPART(quarter,orderdate) as 'quarter',
creationtime,
DATEPART(hour,CreationTime) as 'Time',
DATENAME(mm,OrderDate) as 'monthname',
DATENAME(WEEKDAY,OrderDate) as 'dayname',
DATETRUNC(minute,CreationTime) as 'trundatetime',
DATETRUNC(hour,CreationTime) as 'trundate',
DATETRUNC(month,CreationTime) as 'trundate',
DATETRUNC(year,CreationTime) as 'trundate',
eomonth(orderdate) as 'end month'
from sales.Orders

select 
year(orderdate) as 'year',
datename(MONTH,orderdate) as 'month',
count(*) as orders
from sales.orders
group by year(orderdate),datename(MONTH,orderdate)

select * from sales.Orders
where month(orderdate) = 2
