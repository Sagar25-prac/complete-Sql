-- DDL Commands
/* Create a new table called persons
with columns: id, person_name , birth_date,phone */

create table persons(
	id int Not null,
	person_name varchar(50) Not Null,
	birth_date date,
	phone varchar(15) not null
	constraint pk_persons primary key (id)
)

select * from persons

-- Add a new column called email to person table

alter table persons
add email varchar(50) not null

-- Remove column phone from persons table 

alter table persons
drop column phone

--Delete the table persons from the database

drop table persons

-- DML Commands

-- Manually adding values to columns of data
insert into sales.customers (customerid, firstname, country,score) -- Order should be same with values
values (6,'Sagar','India', null),
(7,'Kushal',Null,100)

select * from sales.Customers

-- using query to insert data from one table to another
-- first lets create a table persons for which we will insert the data from customers
create table persons(
	id int Not null,
	person_name varchar(50) Not Null,
	birth_date date,
	phone varchar(15) not null
	constraint pk_persons primary key (id)
)
-- insert the data from customers table to persons table
Insert into persons(id,person_name,birth_date,phone)
select 
customerid, firstname,null,'unknown'
from sales.customers

select * from persons

--inorder to change the contents of already existing rows

-- update the sagars score to 100
select * from sales.Customers

update sales.Customers
set score = 100
where firstname = 'Sagar'

-- update kushal score and country
update sales.Customers
set score = 200,
	country = 'India'
where firstname = 'kushal'

-- update all customers with null score to 0
update sales.Customers
set score = 0
where score is null

-- Delete rows from customers table
-- remove all customers with id greater than 5

delete from sales.Customers
where customerid>5

--remove all the data from persons
-- we are using truncate to delate all the data the table which is faster method

truncate table persons




