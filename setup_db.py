import sqlite3

print("Creating DB")
conn = sqlite3.connect('nitin.db')
print("Done")

c = conn.cursor()

print("Creating Tables")

try:
    c.execute("""
        CREATE TABLE logs
        (id int primary key, creation datetime default current_timestamp,
         project text, part text, tool text, reason text)
    """)
    print("Done")
except sqlite3.OperationalError:
    print("Table already exists")
