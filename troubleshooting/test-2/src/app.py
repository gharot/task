import psycopg2
import os

from flask import Flask, request

app = Flask(__name__)

@app.route("/")
def hello():
    return ('Hello! I am database verion: ' + connect())

def connect():
    """ Connect to the PostgreSQL database server """
    conn = None
    db_version = None

    try:
        # connect to the PostgreSQL server
        print('Connecting to the PostgreSQL database...')
        conn = psycopg2.connect(
            host=os.getenv('DB_HOST'),
            database=os.getenv('DB_NAME'),
            user=os.getenv('DB_USER'),
            password=os.getenv('DB_PASS'))

        cur = conn.cursor()
        
        print('PostgreSQL database version:')
        cur.execute('SELECT version()')
        db_version = cur.fetchone()
        print(db_version)
       
        cur.close()
    except (Exception, psycopg2.DatabaseError) as error:
        print(error)
        exit(1)
    finally:
        if conn is not None:
            conn.close()
            print('Database connection closed.')
            return str(db_version)


if __name__ == '__main__':
    connect()
    app.run(host='0.0.0.0')
