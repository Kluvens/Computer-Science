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


```
