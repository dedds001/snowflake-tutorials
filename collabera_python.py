#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Wed Jul  3 14:45:54 2019

@author: deborahedds
"""

###get files from http
import requests
r=requests.get("https://raw.githubusercontent.com/becloudready/snowflake-tutorials/master/dataset/employees01.csv")
r.status_code  
##200 status ok, it work
##403 athorization denied
##500 server 


##read as a text file
r.text
###Get the second from the last row
r.text.split('\n')[-2]
##write into a file

a="/Users/deborahedds/Downloads/testfile04"
f1=open(a, "w")
f1.write(r.text.split('\n')[-2])
f1.close()





##import from s3


import requests

url = "https://collabera-aws-training.s3.amazonaws.com/employees01.csv"

headers = {
    'Host': "collabera-aws-training.s3.amazonaws.com",
    'X-Amz-Content-Sha256': "e3numbergeneratedbypostman55",
    'X-Amz-Date': "20190703T185532Z",
    'Authorization': "AWS SECRET KEY, SignedHeaders=host;x-amz-content-sha256;x-amz-date, Signature=secret key",
    'User-Agent': "PostmanRuntime/7.15.0",
    'Accept': "*/*",
    'Cache-Control': "no-cache",
    'Postman-Token': "fnumbergeneratedbypostman",
    'accept-encoding': "gzip, deflate",
    'Connection': "keep-alive",
    'cache-control': "no-cache"
    }

response = requests.request("GET", url, headers=headers)

print(response.text)



##get the second to last row number 177 +2 

int(response.text.split('\n')[-2].split(',')[3].split()[0]) +2


a="/Users/deborahedds/Downloads/testfile06"
f1=open(a, "w")
f1.write(str(int(response.text.split('\n')[-2].split(',')[3].split()[0]) +2))
f1.close()



###import datetime and get today's date


import datetime as dt

dt.datetime.today()

##print today's date using ddmmyy format

ddmmyy=print(dt.datetime.now().strftime('%d-%m-%y'))




