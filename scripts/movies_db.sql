create or replace table movies (
  movieid string contraint primary key ,
  title string ,
  genres string 
  );



  put file:///Users/deborahedds/Downloads/movies1.csv @snowdb.public.%movies;

  list @snowdb.public.%movies;


copy into movies
from @%movies
file_format = (type = csv field_optionally_enclosed_by='"')
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


  put file:///Users/deborahedds/Downloads/ml-latest-small/ratings.csv @snowdb.public.%ratings;

  list @snowdb.public.%ratings;

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
