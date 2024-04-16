<!-- Grade Book Database System:
This system is designed to manage a professor's grade book, keeping track of student grades across various courses and categories like homework, tests, projects, etc. It's implemented in MySQL.

Prerequisites
MySQL Server installed on your machine
Basic knowledge of SQL and database operations

Installation
Start by ensuring that your MySQL server is up and running.
Open your MySQL command line tool or an interface like MySQL Workbench where you can run SQL scripts.
Execute the SQL script provided to set up the database schema and insert initial data.

Usage
The main SQL file contains several tasks:
Task 2: Create tables and relationships
Task 3: Insert initial data
Tasks 4-6: Query data, such as computing average, highest, and lowest scores
Task 7: Add an assignment to a course
Task 8: Change the weight of grade categories
Task 9: Update scores for an assignment
Task 10: Adjust scores conditionally based on student last names
Task 11: Calculate the final grade for a student
Task 12: Compute final grade with the lowest score in a category dropped

Executing the SQL File
Load the SQL file into your MySQL server by using the source command:

mysql> source /your_file_path/gradebook.sql;

Running Queries
After loading the SQL file, you can execute the individual queries as needed. For example, to list all students, you can run:
mysql> SELECT * FROM Student;

To calculate the average score for an assignment:
mysql> SELECT AVG(score) AS average_score FROM Grade WHERE assignment_id = [Assignment ID];(Replace [Assignment ID] with the ID of the assignment you're interested in.) 

Modifying Data
To add or update data, you can modify the insert and update statements accordingly.
For example, to add a new student:
mysql> INSERT INTO Student (first_name, last_name) VALUES ('New', 'Student');

Running Test Cases
To verify the functionality and integrity of the database after setup and modifications, run the test cases provided in the test_cases.sql file:
Navigate to the location of your test cases SQL file.
Load and execute the test cases using:
mysql> source /your_file_path/test_cases.sql;

The test cases include checks for:

Table creation and integrity
Data insertion correctness
Query outputs (for tasks 4-12)
Modification results (for update operations)
 -->
