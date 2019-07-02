-- - create table

drop table emp_basic;
create or replace table emp_basic (
  first_name string ,
  last_name string ,
  email string ,
  streetaddress string ,
  city string ,
  start_date date
  );

create or replace file format my_csv_format
  type = csv field_delimiter = ',' skip_header = 1 null_if = ('NULL', 'null') empty_field_as_null = true compression = gzip;

create or replace stage my_s3_stage url='s3://becloudready/data-analytics'
  credentials=(aws_key_id='<your key>' aws_secret_key='<your secred>')
  file_format = (type = csv field_optionally_enclosed_by='"');

copy into EMP_BASIC
  from s3://becloudready/data-analytics credentials=(aws_key_id='<your key>' aws_secret_key='<your secred>')
  file_format = (type = csv field_optionally_enclosed_by='"')
  pattern = '.*employees0[1-5].csv'
  on_error = 'skip_file';

  

copy into EMP_BASIC
  from @my_s3_stage
  file_format = (type = csv field_optionally_enclosed_by='"')
  pattern = '.*employees0[1-5].csv'
  on_error = 'skip_file';



create or replace stage my_s3_stage url='  s3://aws-snowflake'
  credentials=(aws_key_id='AKIA4SOMN2PTTUZSKVMK' aws_secret_key='Wi3YELXzx/hGqvhFXzf1W2ktyaDP73TMPGPOyN/1')
  file_format = my_csv_format3;

copy into EMP_BASIC
  from s3://becloudready/data-analytics credentials=(aws_key_id='<your key>' aws_secret_key='<your secred>')
  file_format = (type = csv field_optionally_enclosed_by='"')
  pattern = '.*employees0[1-5].csv'
  on_error = 'skip_file';


copy into customers
  from s3://aws-snowflake credentials=(aws_key_id='AKIA4SOMN2PTTUZSKVMK' aws_secret_key='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')
  file_format = my_csv_format
  pattern = '.*customers.csv'
  on_error = 'skip_file';


  s3://aws-snowflake






CREATE table customers3 (
  ID string, 
  age number,
  job string,
  marital string,
  education string,
  default string,
  housing string,
  loan string,
  contact string,
  month string,
  day_of_week string, 
  duration number, 
  campaign string,
  pdays number, 
  previous number);


)







create or replace file format my_csv_format
  type = csv field_delimiter = ',' skip_header = 1 null_if = ('unknown', 'null') empty_field_as_null = true compression = gzip;


copy into customers3
  from s3://aws-snowflake credentials=(aws_key_id='AKIA4SOMN2PTTUZSKVMK' aws_secret_key='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')
  file_format = my_csv_format2
  pattern = '.*customers3.csv.gz'
  on_error = 'skip_file';

-----------------------------------------------------


create or replace file format my_csv_format3
  type = csv field_delimiter = '|' skip_header = 1 null_if = ('unknown', 'null') ;

  ##creating table for practice

 CREATE table president_heights(
   order number,
   name string,
   height_cm number
 ) 

### create virtual warehouse
create or replace warehouse sf_tuts_wh with
  warehouse_size='X-SMALL'
  auto_suspend = 180
  auto_resume = true
  initially_suspended=true;


  put file:///Users/deborahedds/Downloads/president_heights.csv @sf_tuts.public.%president_heights;

  list @sf_tuts.public.%president_heights;

create or replace file format my_csv_format
  type = csv field_delimiter = ',' skip_header = 1 null_if = ('unknown', 'null') empty_field_as_null = true compression = gzip;


  copy into president_heights
  from @%president_heights
  file_format = my_csv_format
  pattern = '.*president_heights.csv.gz'
  on_error = 'skip_file';


-----------------
copy into classicmodels
from s3://aws-snowflake/ credentials=(aws_key_id='AKIA4SOMN2PTTUZSKVMK' aws_secret_key='AKIA4SOMN2PTTUZSKVMK')
file_format = (type = csv field_optionally_enclosed_by='"')
pattern = '.*mysqlsampledatabase.sql'
on_error = 'skip_file';







---

create or replace stage my_s3_unload_stage url='s3://aws-snowflake2/write'
  credentials=(aws_key_id='AKIA4SOMN2PTTUZSKVMK' aws_secret_key='Wi3YELXzx/hGqvhFXzf1W2ktyaDP73TMPGPOyN/1')
  file_format = (type = csv field_optionally_enclosed_by='"');



COPY INTO 's3://aws-snowflake2/write/test_data/TEST1.csv.gz'
FROM SF_TUTS..test1
FILE_FORMAT = 'CSVFORMAT'
  credentials=(aws_key_id='AKIA4SOMN2PTTUZSKVMK' aws_secret_key='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')
)
OVERWRITE=TRUE
SINGLE=TRUE;