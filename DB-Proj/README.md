<!-- # Grade Book System

The Grade Book System is a database-driven application designed to manage and compute student grades for various courses. The system supports multiple grading categories per course and offers functionalities for advanced grade computations, including the option to drop the lowest score in each category.

## Project Structure

 schema.sql # SQL script to create database schema.
 data.sql # SQL script to insert sample data into the database.
 queries.py # Python module containing functions to execute database queries.
 compute_grades.py # Python module for computing student grades.
 main.py # Main Python script for running the application and user interaction.
 tests.py # Python script for running tests on the application functionalities.
 requirements.txt # File listing all the necessary Python dependencies.
 README.md # Documentation for setting up and using the application.

## Setup Instructions

### Dependencies

To run this project, ensure you have the following installed:
- Python (3.6 or later)
- MySQL
- pip packages: Install the required Python packages using pip:

```bash -->
pip install -r requirements.txt 

# Database Setup:
# Install MySQL and Follow the official MySQL installation guide for your operating system:
# Create Database and User

CREATE DATABASE GradeBookDB;
CREATE USER 'gradebookuser'@'localhost' IDENTIFIED BY 'password';
GRANT ALL PRIVILEGES ON GradeBookDB.* TO 'gradebookuser'@'localhost';
FLUSH PRIVILEGES;

# create your own password of choice and replace 'password'

# Initialize Database
# Run the SQL scripts to create the schema and insert sample data:

mysql -u gradebookuser -p GradeBookDB < schema.sql
mysql -u gradebookuser -p GradeBookDB < data.sql

# Running the Application
# Navigate to the project directory and run the main application script:

python main.py

# Follow the on-screen prompts to interact with the application.

# Running Tests
# To execute the test cases and ensure the application's functionalities are working as expected:

python tests.py

# Features
# Compute total grades for students in various courses.
# Option to compute grades with the lowest score in each category dropped.
# Extensible design for adding more features such as more complex grading schemes.