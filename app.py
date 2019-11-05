from psycopg2 import connect
from os import environ
from functools import reduce

def application(env, start_response):
    connection = connect(
            dbname=environ['DB_NAME'],
            host=environ['DB_HOST'],
            user=environ['DB_USER']
            )
    cursor = connection.cursor()
    cursor.execute("SELECT * FROM brands")
    results = cursor.fetchall()

    response_string = reduce(
            lambda res, row: res + "Name: {}, Single Malt: {}\n".format(row[0], row[1]),
            results,
            ""
            )
    start_response('200 OK', [('Content-Type', 'text/plain')])
    return [bytes(response_string, 'utf-8')]
