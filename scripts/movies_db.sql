-----MORE PRACTICE with Snowflake---------------
-----Create table, database, warehouse in snowflake and upload csv file
-----Then create UDF to query the tables
-----pipe the output of the sql file into csv


create or replace database moviedb;

select current_database(), current_schema();



create or replace table movies (
  movieid string,
  title string ,
  genres string,
  primary key (movieid) 
  );

create or replace warehouse moviedb_wh with
  warehouse_size='X-SMALL'
  auto_suspend = 180
  auto_resume = true
  initially_suspended=true;


  put file:///Users/deborahedds/Downloads/movies1.csv @moviedb.public.%movies;

  list @moviedb.public.%movies;


copy into movies
from @%movies
file_format = (type = csv field_optionally_enclosed_by='"' skip_header =1)
pattern = '.*movies1.csv.gz'
on_error = 'skip_file';



create or replace table ratings (
  userid string,
  movieid string, 
  rating number ,
  timestamp string,
  primary key  (userid),
  foreign key (movieid) references movies(movieid)
  );


  put file:///Users/deborahedds/Downloads/ml-latest-small/ratings.csv @moviedb.public.%ratings;

  list @moviedb.public.%ratings;

copy into ratings
from @%ratings
file_format = (type = csv field_optionally_enclosed_by='"' skip_header=1)
pattern = '.*ratings.csv.gz'
on_error = 'skip_file';




-----CREATE UDF to retrieve average rating of movies when given the title 


 CREATE or replace function get_avg_rating(movie_title string)
    returns table (title string, avg_rating Number)
    as
   $$             
  select m.title, AVG(r.rating) avg_rating 
  from movies m 
  JOIN ratings r on m.MOVIEID=r.movieid 
  WHERE m.title LIKE movie_title
  GROUP BY m.title
             
   $$
     ; 

 SELECT * from table(get_avg_rating('%Toy Story%')); 
                                    
                                    ---
