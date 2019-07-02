
 
 
 ----------Function to get the email and city of an employee from their first name 
 
 CREATE or replace function get_email_city(name string)
    returns table (email string, city string)
    as
   $$             
                
  SELECT email, city from emp_basic WHERE first_name = name
   $$
     ; 

create or replace function example(give_name varchar)
  returns table (email varchar, city varchar)
  as
  $$
    select email, city from emp_basic where first_name = give_name
  $$
  ;


  -----Function to get street address and city from employees first name
   CREATE or replace function get_address(name string)
    returns table ("Employee lives at" string, streetaddress string, city string)
    as
   $$             
                
    SELECT CONCAT('Employee lives at  ', streetaddress) s, city from emp_basic   
 WHERE first_name = name
   $$
     ; 



     ------Function to get start date from employee first_name
CREATE or replace function get_startdate(name string)
    returns table (start_on string)
    as
   $$                 
     SELECT CONCAT(' started work on  ', TO_CHAR(start_date, 'dd-mm-YYYY')) start_on from emp_basic  
 WHERE first_name = name
   $$
     ; 