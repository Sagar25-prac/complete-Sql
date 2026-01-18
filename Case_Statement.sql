-- Case Statement
--  its the conditional statement

-- syntax


/*case
   when condition1 then result1
   when condition2 then result2
 else default result
 End  */


-- Uses cases
-- Categorizing Data

/* create report showing total sales for each of the following categories:
    high (sales over 50),Medium (sales 21-50) and low (sales 20 or less)
    sort the categories form highest sales to lowest */

    select * from sales.Orders
    
    select category,sum(sales) total
    from
    (
        select
        OrderID,
        customerid,
        sales,
        case   
            when sales >= 50 then 'High'
            when sales < 50 and sales >= 20 then 'Medium'
        else 'Low'
        end as category
        from sales.Orders)t
    group by category
    order by total desc

-- Uses cases
-- Mapping

-- Retrive employee details with gender displayed as full text

select  
EmployeeID,
concat(firstname,' ',LastName) Name,
case 
    when gender = 'M' then 'Male'
    else 'Female'
end Gender
from sales.Employees

-- Retrive customers details with abbreviated country code

select 
concat(firstname,' ',LastName) Name,
case
    when country = 'Germany' then 'DE'
    else 'US'
end country
from sales.Customers


-- Uses Cases
-- Null Handling


/* Find the average scores of customers and treat nulls as 0
    additionally provide details such as customerid and lastname */

select * from sales.Customers

select lastname,avg(newscore) newscore
from(
select lastname,
case 
    when score is null then 0
    else score
end newscore
from Sales.Customers) t
group by LastName

-- Uses Cases
-- Conditional Aggregation

-- count how many times each customer has made an order with sales greater than 30

select 
customerid,
sum(
case   
    when sales > 30 then 1
    else 0 
end) totalsales,
count(*) totalorders
from sales.Orders
group by CustomerID

