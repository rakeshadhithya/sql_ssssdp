import mysql.connector as msc
import pandas as pd

rakeshdb_config = {
    'host' : 'localhost',
    'user' : 'root',
    'password' : 'root',
    'database' : 'rakeshdb'
}

def get_connection(config):
    return msc.connect(**config)

con = get_connection(rakeshdb_config)
cur = con.cursor()
cur.execute(
'''
select * from employees
'''
)
employees = pd.DataFrame(cur.fetchall(), columns = ['id', 'name', 'dept', 'sal'])
print(employees)