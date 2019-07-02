
-----Create new database
create or replace database snowdb;


select current_database(), current_schema();


----Create new table

create or replace table emp_basic2 (
  first_name string ,
  last_name string ,
  email string ,
  streetaddress string ,
  city string ,
  start_date date
  );

----Create new warehouse

create or replace warehouse snowdb_wh with
  warehouse_size='X-SMALL'
  auto_suspend = 180
  auto_resume = true
  initially_suspended=true;


--Create staging area 
put file:///Users/deborahedds/Downloads/snowflake-tutorials/dataset/employees0*.csv @snowdb.public.%emp_basic2;



---Check staging area for file:
list @snowdb.public.%emp_basic2;




copy into emp_basic2
from @%emp_basic2
file_format = (type = csv field_optionally_enclosed_by='"')
pattern = '.*employees0[1-5].csv.gz'
on_error = 'skip_file';


SELECT * from emp_basic2 LIMIT 5;




--------------Create UDF to retrieve email and city by user name-------------
CREATE or replace function get_email_city(name string)
    returns table (email string, city string)
    as
   $$             
                
  SELECT email, city from emp_basic2 WHERE first_name = name
   $$
     ; 


--Sample Query
 SELECT * from table(get_email_city('Lem')); 



