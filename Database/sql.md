SQL keywords are not case sensitive
``` sql
-- used to create a batabase
create database mybd;

-- used to drop a databse
drop database mybd;

-- to backup database
backup database testDB
to disk = 'filepath';

-- create a table called persons that contains five columns: PersonID, LastName, FirstName, Address, and City
create table Persons(
    PersonID int,
    LastName varchar(255),
    FirstName varchar(255),
    Address varchar(255),
    City varchar(255)
);

-- create table using another table
create table testtable as
select customername, contactname
from customers;

-- drop a table
drop table table_name;

-- adds an email column to the customers table
alter table customers
add email varchar(255);

-- SQL create constraints
create table table_name (
    column1 datatype constraint,
    column2 datatype constraint,
    column3 datatype constraint,
);

-- not null: ensures that a column cannot have a null value
CREATE TABLE Persons (
    ID int NOT NULL,
    LastName varchar(255) NOT NULL,
    FirstName varchar(255) NOT NULL,
    Age int
);

-- unique: ensures that all values in a column are different
CREATE TABLE Persons (
    ID int NOT NULL UNIQUE,
    LastName varchar(255) NOT NULL,
    FirstName varchar(255),
    Age int
);

-- primary key: a combination of a not null and unique
CREATE TABLE Persons (
    ID int NOT NULL,
    LastName varchar(255) NOT NULL,
    FirstName varchar(255),
    Age int,
    PRIMARY KEY (ID)
);

-- foreign key: prevents actions that would destory links between tables
CREATE TABLE Orders (
    OrderID int NOT NULL,
    OrderNumber int NOT NULL,
    PersonID int,
    PRIMARY KEY (OrderID),
    FOREIGN KEY (PersonID) REFERENCES Persons(PersonID)
);

-- check: ensures that the values in a column satisfies a specific condition
CREATE TABLE Persons (
    ID int NOT NULL,
    LastName varchar(255) NOT NULL,
    FirstName varchar(255),
    Age int,
    CHECK (Age>=18)
);

-- Auto-increment allows a unique number to be generated automatically when a new record is inserted into a table
CREATE TABLE Persons (
    Personid int NOT NULL AUTO_INCREMENT,
    LastName varchar(255) NOT NULL,
    FirstName varchar(255),
    Age int,
    PRIMARY KEY (Personid)
);

-- select dates
select * from orders where orderDate='2008-11-11';

-- a view is a virtual table based on the result-set of an SQL statement
create view Allratings
as
select beer.name, ratings.score, taster.given from beer
join ratings
on ratings.beer = beer.id
join Taster
on taster.id = ratings.taster
order by beer.name, taster.given
;

-- an update statement
update salary
set
    sex = case sex
        when 'm' then 'f'
        else 'm'
    end;
```

``` sql
-- select everything from movies;
select * from movies;

-- select columns called id, title, start_year and rating from movies
select id, title, start_year, rating from movies;

-- column called start_year from movies but every distinct element only shows up once
select distinct start_year from movies;

-- select movie_id and genre from movie_genres and the genre is either drama or documentary
select movie_id, genre from Movie_genres where genre = 'drama' or genre = 'documentary';

-- select movie_id and genre from movie_genres and the genre is not crime
select movie_id, genre from Movie_genres where not genre = 'crime';

-- select title and rating from movies and the table is ordered by rating in descending order
select title, rating from movies order by rating DESC;

-- select title from movies where values in orig_title is not null
select title from movies where orig_title is not null;

-- select all fields from customers where country is not 'Germany'
select * from customers where not country='Germany';

-- select top 10 titles from movies ordered by rating by ascending order
select titel from movies order by rating limit 10

-- select title from movies where title matches the pattern of '%Kate%'
select title from movies where title like '%Kate%';

-- select name, birth_year and death_year from names where name case-insentively matches 'spike lee' and 
-- order by name first then birth_year then id by ascending order
select name, birth_year, death_year from names where name ~* 'spike lee' order by name, birth_year, id;

-- select title from movies where id matches in the table where the genre is documentary in movie_genres
select title from Movies where id in (select id from Movie_genres where genre = 'documentary');

-- select title and rating from movies where rating is between 8.5 and 9.5
select title, rating from movies where rating between 8.5 and 9.5;

-- select title and rating from movies where rating is not 8.0
select title, rating from movies where rating <> 8.0;

-- select id renamed as movie_id and select title renamed as movie_name from movies;
select id as movie_id, title as movie_title from movies;

-- selects all customers from the customers table, sorted ascending by the country and descending by the customername column
select * from customers order by country ASC, customername DESC;

-- join table movies and movie_genres on the condition of movies.id = movie_genres.movie_id and 
-- select title from movies, select genre from movie_genres
select movies.title, movie_genres.genre from movies join movie_genres on movies.id = movie_genre.movie_id;

-- select distinct pair of title and rating which satisfies the condition that 
-- in movies the rating equals 8.0 and in movies the rating is 8.1
select title, rating from movies where rating = 8.0 union select title, rating from movies where rating = 8.1;

-- count the number of genre and the genre from movie_genres grouped by genre and 
-- satisfies the condition of the number of genre is greater than 1000
select count(genre), genre from Movie_genres group by genre having count(genre) > 1000;

-- the exists operator is used to test for the existence of any record in a subquery and 
-- the exists operator returns true if the subquery returns one or more records
select title, rating from movies where exists (select id from movies where rating = 8.0);

-- select title, rating and a message as remarks from movies
-- the message is defined as below
-- if the rating is greater than 8.0 then it is 'the movie is very good'
-- if the rating equals 8.0 then it is 'good'
-- if the rating is lower than 8.0 then it is 'needs more'
select title, rating, 
case
    when rating > 8.0 then 'The movie is very good'
    when rating = 8.0 then 'GOOD'
    when rating < 8.0 then 'Needs more'
end as remarks
from Movies;

-- The insert into statement is used to insert new records in a table
insert into customers (customername, contactname, address, city, postalcode, country)
values ('Cardinal', 'Tom', 'Skagen', 'Stavanger', '4006', 'Norway');

-- The update statement is used to modify the existing records in a table
update customers
set contactname = 'Alfred Schmidt', City = 'Frankfurt'
where customerID = 1;

-- The delete statement is used to delete existing records in a table
delete from customers where customerName = 'Alfreds Futterkiste';

-- finds the price of the cheapest product
select min(price) as smallestprice from products;

-- selects all customers that are from the same countries as the suppliers
select * from customers where country in (select country from suppilers);

-- difference between in operator and exists operator
-- in: determines whether a specified value matches any value in a subquery or a list
-- exists: specifies a subquery to test for the existence of rows

-- matches customers that are from the same city
select A.customername as customername1, B.customersname as customername2, A.city
from customers A, customers B
where A.cutomerID <> B.customerID
and A.city = B.city
order by A.city;

-- lists the productname if it finds ANY records in the orderdetails table has quantity equal to 10
select productname
from products
where productID = ANY(
    select productID
    from orderdetails
    where quantity = 10);
    
-- The select into statement copies data from one table into a new table
select customerName, contactName into  customerBackup from customers;

-- The insert into select statement copies data from one table and inserts it into another table
insert into customers (customerName, city, country)
select supplierName, city, country from suppliers;

-- goes through conditions and returns a value when the first condition is met
select orderID, quantity
case
    when quantity > 30 then 'The quantity is greater than 30'
    when quantity = 30 then 'The quantity is 30'
    else 'The quantity is under 30'
end as quantityText
from orderDetails;

-- The ifnull() function lets you return an alternative value if an expression is NULL
select productname, unitprice * (unitsinstock + ifnull(unitsonorder, 0)) from products;

-- The SQL EXCEPT clause is used to combine two select statements and 
-- returns rows from the first select statement that are not returned by the seconde statement
-- I want to get movie title and rating from movies where rating is between 8.0 and 9.0
select title, rating from movies where rating > 8.0
EXCEPT
select title, rating from movies where rating > 9.0;

-- select all movie titles and rating where rating is above the average
with teminfo(averageValue) as (select avg(rating) from movies)
select title, rating, runtime from movies, teminfo where movies.rating > teminfo.averageValue;

-- sql countif
select count(case when rating = 8.0 then 1 end) from movies;

-- delete duplicate emails in database
delete p1 from person p1, person p2
where p1.email = p2.email and p1.id > p2.id;

-- find the second highest salary
select max(salary) as SecondHighestSalary from Employee where salary < (select max(salary) from Employee)
```

![image](https://user-images.githubusercontent.com/95273765/207810280-83b5f4a7-1ae3-469b-9ed7-e1ff6316d89c.png)

``` sql
full sql query syntax:
select expressions
from Table
join Table
on condition
where condition
group by attributes
having conditionOnGroup
order by attributes
```
