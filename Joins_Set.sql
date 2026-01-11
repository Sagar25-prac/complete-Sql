-- Joins - it joins two table based on the keys 
-- Set - it append two tables based on columns

-- Why to use joins?
-- Recombine data 
-- Data Enrichment "Getting extra data which means extra information"
-- Also to check existence of the data

-- Join Types
-- Basic Joins 
-- No Join,Inner Join,Left Join,Right Join,Full Join
-- Advanced Joins
-- Left Anti Join,Right Anti Join,Full Anti Join,Cross Join

-- No Join

Select * from Sales.Customers;

Select * from Sales.Orders;

-- Inner Join

select A.CustomerID,A.FirstName,A.Country,count(b.orderid) as 'Orders'
from Sales.Customers A
Inner join Sales.Orders B 
on A.CustomerID = B.CustomerID
group by  A.CustomerID,A.FirstName,A.Country

-- Left Join

select A.FirstName,A.Country,count(B.OrderID) as 'Orders'
from Sales.Customers A
left join sales.Orders B
on A.CustomerID = B.CustomerID
group by A.FirstName,A.Country

-- Right Join

select b.orderid,b.sales,count(a.customerid) as 'customer'
from Sales.Customers A
Right join sales.Orders B
on A.CustomerID = B.CustomerID
group by b.orderid,b.sales

-- Full Join

select A.*,B.* 
from Sales.Customers A
Full join sales.Orders B
on A.CustomerID = B.CustomerID

--Anti Full Join

Select *
from Sales.Orders o
full join Sales.Customers c
on c.CustomerID = o.CustomerID
where c.CustomerID is null or o.CustomerID is null

select A.FirstName,A.Country,B.OrderID
from Sales.Customers A
left join sales.Orders B
on A.CustomerID = B.CustomerID
where b.CustomerID is not null

-- cross join

select * from Sales.Customers
cross join Sales.Orders

-- Multiple joins
Select * from Sales.Customers;
Select * from Sales.Orders;
Select * from Sales.Products
Select * from Sales.Employees

select  o.OrderID,o.Sales,c.FirstName as 'Customer First Name',c.LastName as 'Customer Last Name',p.Product,p.Price,e.FirstName as 'Employee First Name',e.LastName as 'Employee Last Name'
from sales.Orders o
left join Sales.Customers c on o.CustomerID = c.CustomerID
left join Sales.Products p  on o.ProductID = p.ProductID
left join Sales.Employees e on o.SalesPersonID = e.EmployeeID


select  o.OrderID,o.Sales, concat(c.firstname,' ',c.LastName) as 'Customer Name',p.product,p.Price, CONCAT(e.firstname, ' ',e.lastname) as 'Sales Person Name'
from sales.Orders o
left join Sales.Customers c on o.CustomerID = c.CustomerID
left join Sales.Products p  on o.ProductID = p.ProductID
left join Sales.Employees e on o.SalesPersonID = e.EmployeeID;

-- Set operator

--union

select concat(c.firstname,' ',c.LastName) as 'Name'
from Sales.Customers c
union  -- without duplicates
select CONCAT(e.firstname, ' ',e.lastname)
from Sales.Employees e;

-- union all

select concat(c.firstname,' ',c.LastName) as 'Name'
from Sales.Customers c
union all -- With duplicates
select CONCAT(e.firstname, ' ',e.lastname)
from Sales.Employees e
order by 1;

--Expect

select CONCAT(e.firstname, ' ',e.lastname) as 'Name'
from Sales.Employees e
Except
select concat(c.firstname,' ',c.LastName)
from Sales.Customers c
order by 1;

--Intersect

select CONCAT(e.firstname, ' ',e.lastname) as 'Name'
from Sales.Employees e
intersect
select concat(c.firstname,' ',c.LastName)
from Sales.Customers c
order by 1;





