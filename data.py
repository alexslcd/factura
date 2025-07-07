# Ejemplo en tu archivo `data.py`:
import pymysql.cursors

def get_db_connection():
    return pymysql.connect(
        host='crossover.proxy.rlwy.net',
        user='root',
        password='WnkljGqakquedQbSvqVYymprGlijAEGB',
        database='railway',
        port=16848,
        cursorclass=pymysql.cursors.DictCursor
    )
