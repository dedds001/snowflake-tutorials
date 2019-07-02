 CREATE function as get_email_city(name string)
      returns table (email string, city string)
                as
   $$             
                
  SELECT e.email, e.city from emp_basic e WHERE e.first_name = name
   $$
                ; 