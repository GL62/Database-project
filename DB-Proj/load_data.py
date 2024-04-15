import mysql.connector
from mysql.connector import Error

def execute_scripts_from_file(filename, connection):
    # Open and read the file as a single buffer
    with open(filename, 'r') as sql_file:
        sql_script = sql_file.read()

    # All SQL commands (split on ';')
    sql_commands = sql_script.split(';')

    # Execute every command from the input file
    for command in sql_commands:
        # Skip any empty commands
        if command.strip() == '':
            continue
        try:
            cursor = connection.cursor()
            cursor.execute(command)
            connection.commit()
            print("Successfully executed SQL command")
        except Error as e:
            print(f"Error occurred: {e}")

# Main code
try:
    # Setup the database connection
    connection = mysql.connector.connect(
        host='localhost',        # Or your host, if remote
        database='GradeBookDB',  # Your database name
        user='gradebookuser',    # Your database user
        password='your_password' # Your database password for the user
    )
    
    # Specify your SQL file
    script_filename = 'path/to/data.sql'  # Update this to the path of SQL file

    # Execute the SQL commands in the file
    execute_scripts_from_file(script_filename, connection)

except Error as e:
    print(f"Error while connecting to MySQL: {e}")
finally:
    # Close the connection
    if connection and connection.is_connected():
        connection.close()
        print("MySQL connection is closed")
