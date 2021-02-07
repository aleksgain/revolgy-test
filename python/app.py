#!/usr/bin/env python3

import json, socket, requests, urllib.request, time, os, pymysql.cursors
from flask import Flask
from flask_api import status
from flask import cli
from flask import request

app = Flask(__name__)
cli.show_server_banner = lambda *_: None

def main():
     app.run(host='0.0.0.0',port=31337)

def update(ip):
    dbusername = os.environ['USER']
    dbpassword = os.environ['PASSWORD']
    dbhost = os.environ['DB-HOST']
    dbname = os.environ['DB-NAME']
    print(dbusername, dbpassword, dbhost, dbname)
    SQL = pymysql.connect(host=dbhost,
                             user=dbusername,
                             password=dbpassword,
                             database=dbname,
                             charset='utf8mb4',
                             cursorclass=pymysql.cursors.DictCursor)
    with SQL:
        with SQL.cursor() as cursor:
            initialize = "CREATE TABLE IF NOT EXISTS ip (timestamp integer PRIMARY KEY, city text, region text, country_name text, cont_name text, \
                        zip integer, lat integer, lon integer, language text, flag text, phone_code integer)"
            cursor.execute(initialize)
            ip_url = 'http://api.ipstack.com/'+ip+'?access_key=9c4f70e64a64af13e587002fda3d020e&format=1'
            response = json.loads((requests.get(ip_url)).text)
            timestamp = int(time.time())
            city = response['city']
            region = response['region_name']
            country_name = response['country_name']
            cont_name = response['continent_name']
            zip = response['zip']
            lat = response['latitude']
            lon = response['longitude']
            language = response['location']['languages'][0]['name']
            flag = response['location']['country_flag']
            emoji = response['location']['country_flag_emoji']
            phone_code = response['location']['calling_code']
            result = "INSERT INTO ip (timestamp, city, region, country_name, cont_name, zip, lat, lon, language, flag, phone_code)" \
                    " VALUES (%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s)"
            cursor.execute(result, (timestamp, city, region, country_name, cont_name, zip, lat, lon, language, flag, phone_code))
        SQL.commit()
        
@app.route('/')
def index():
    ip = request.remote_addr
    update(ip)
    text = ('Your IP is {}, saving it for tracking you!'.format(ip))
    return text

@app.route('/health')
def ok_status():
    return 'OK', status.HTTP_200_OK

if __name__ == "__main__":
   main()

