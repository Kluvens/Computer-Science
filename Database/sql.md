``` sql
-- used to create a batabase
create database mybd;

-- used to drop a databse
drop database mybd;
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

-- select top 10 titles from movies ordered by rating by ascending order
select titel from movies order by rating limit 10

-- select title from movies where title matches the pattern of '%Kate%'
select title from movies where title like '%Kate%';

-- select name, birth_year and death_year from names where name case-insentively matches 'spike lee' and order by name first then birth_year then id by ascending order
select name, birth_year, death_year from names where name ~* 'spike lee' order by name, birth_year, id;

-- select title from movies where id matches in the table where the genre is documentary in movie_genres
select title from Movies where id in (select id from Movie_genres where genre = 'documentary');

-- select title and rating from movies where rating is between 8.5 and 9.5
select title, rating from movies where rating between 8.5 and 9.5;

-- select id renamed as movie_id and select title renamed as movie_name from movies;
select id as movie_id, title as movie_title from movies;

-- join table movies and movie_genres on the condition of movies.id = movie_genres.movie_id and select title from movies, select genre from movie_genres
select movies.title, movie_genres.genre from movies join movie_genres on movies.id = movie_genre.movie_id;

-- select distinct pair of title and rating which satisfies the condition that in movies the rating equals 8.0 and in movies the rating is 8.1
select title, rating from movies where rating = 8.0 union select title, rating from movies where rating = 8.1;

-- count the number of genre and the genre from movie_genres grouped by genre and satisfies the condition of the number of genre is greater than 1000
select count(genre), genre from Movie_genres group by genre having count(genre) > 1000;

-- the exists operator is used to test for the existence of any record in a subquery and the exists operator returns true if the subquery returns one or more records
select title, rating from movies where exists (select id from movies where rating = 8.0);
```

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
