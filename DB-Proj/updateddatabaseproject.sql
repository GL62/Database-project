-- Task 2: Write the commands for creating tables and inserting values

-- Drop existing tables if they exist to start with a clean state
DROP TABLE IF EXISTS Enrollment, Grade, Assignment, Category, Student, Course;

-- Create Course table
CREATE TABLE IF NOT EXISTS Course (
    course_id INT AUTO_INCREMENT PRIMARY KEY,
    department VARCHAR(255),
    course_number VARCHAR(255),  -- Corrected data type specification
    name VARCHAR(255),
    semester VARCHAR(50),
    year INT
);

-- Create Student table
CREATE TABLE IF NOT EXISTS Student (
    student_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(255),
    last_name VARCHAR(255)
);

-- Create Category table
CREATE TABLE IF NOT EXISTS Category (
    category_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255),
    weight DECIMAL(5, 2),  -- Changed from FLOAT to DECIMAL for better precision
    course_id INT,
    FOREIGN KEY (course_id) REFERENCES Course(course_id)
);

-- Create Assignment table
CREATE TABLE IF NOT EXISTS Assignment (
    assignment_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255),
    category_id INT,
    max_points INT,
    FOREIGN KEY (category_id) REFERENCES Category(category_id)
);

-- Create Grade table
CREATE TABLE IF NOT EXISTS Grade (
    grade_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT,
    assignment_id INT,
    score DECIMAL(5, 2),  -- Changed from FLOAT to DECIMAL for consistency and precision
    FOREIGN KEY (student_id) REFERENCES Student(student_id),
    FOREIGN KEY (assignment_id) REFERENCES Assignment(assignment_id)
);
--Create Enrollment table
USE mygradebook;
CREATE TABLE IF NOT EXISTS Enrollment (
    enrollment_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT,
    course_id INT,
    FOREIGN KEY (student_id) REFERENCES Student(student_id),
    FOREIGN KEY (course_id) REFERENCES Course(course_id)
);

-- Task 3: Show the tables with the contents that you have inserted

-- Insert data into Student
INSERT INTO Student (first_name, last_name) VALUES ('Alice', 'Johnson');
INSERT INTO Student (first_name, last_name) VALUES ('Bob', 'Smith');
INSERT INTO Student (first_name, last_name) VALUES ('Carol', 'Martinez');
INSERT INTO Student (first_name, last_name) VALUES ('David', 'Lee');

-- Insert data into Course
INSERT INTO Course (department, course_number, name, semester, year) VALUES ('Computer Science', 'CS101', 'Introduction to Computer Science', 'Fall', 2023);
INSERT INTO Course (department, course_number, name, semester, year) VALUES ('Mathematics', 'MATH201', 'Calculus I', 'Spring', 2023);
INSERT INTO Course (department, course_number, name, semester, year) VALUES ('History', 'HIST101', 'World History', 'Fall', 2023);

-- Insert data into Category assuming course_id is correct
INSERT INTO Category (name, weight, course_id) VALUES ('Homework', 20.00, 1);
INSERT INTO Category (name, weight, course_id) VALUES ('Tests', 50.00, 1);
INSERT INTO Category (name, weight, course_id) VALUES ('Projects', 30.00, 1);

-- Insert data into Category assuming course_id for Calculus I
INSERT INTO Category (name, weight, course_id) VALUES ('Homework', 30.00, 2);
INSERT INTO Category (name, weight, course_id) VALUES ('Tests', 70.00, 2);

INSERT INTO Assignment (name, category_id, max_points) VALUES ('HW1', 1, 100.00);
INSERT INTO Assignment (name, category_id, max_points) VALUES ('HW2', 1, 100.00);

-- Assuming category_id 2 is Tests for CS101
INSERT INTO Assignment (name, category_id, max_points) VALUES ('Midterm', 2, 100.00);
INSERT INTO Assignment (name, category_id, max_points) VALUES ('Final', 2, 100.00);

-- Assumptions must be corrected with real assignment IDs
INSERT INTO Grade (student_id, assignment_id, score) VALUES (1, 1, 85.00);
INSERT INTO Grade (student_id, assignment_id, score) VALUES (2, 1, 90.00);
INSERT INTO Grade (student_id, assignment_id, score) VALUES (1, 2, 88.00);
INSERT INTO Grade (student_id, assignment_id, score) VALUES (2, 2, 94.00);

INSERT INTO Enrollment (student_id, course_id) VALUES (1, 1);  -- Assumes student_id 1 is enrolled in course_id 1
INSERT INTO Enrollment (student_id, course_id) VALUES (2, 1);  -- Assumes student_id 2 is also enrolled in course_id 1
INSERT INTO Enrollment (student_id, course_id) VALUES (1, 2);  
INSERT INTO Enrollment (student_id, course_id) VALUES (2, 3);  

-- Task 4: Compute the average/highest/lowest score of an assignment

SELECT * FROM Student;
SELECT * FROM Course;

SELECT Category.*, Course.name AS course_name FROM Category
JOIN Course ON Category.course_id = Course.course_id;

SELECT Assignment.*, Category.name AS category_name FROM Assignment
JOIN Category ON Assignment.category_id = Category.category_id;

SELECT Grade.*, Student.first_name, Student.last_name, Assignment.name AS assignment_name FROM Grade
JOIN Student ON Grade.student_id = Student.student_id
JOIN Assignment ON Grade.assignment_id = Assignment.assignment_id;

SELECT AVG(score) AS average_score
FROM Grade
WHERE assignment_id = 1;

SELECT MAX(score) AS highest_score
FROM Grade
WHERE assignment_id = 1;

SELECT MIN(score) AS lowest_score
FROM Grade
WHERE assignment_id = 1;

-- Task 5: List all of the students in a given course (course_id 1 in this example)

SELECT s.student_id, s.first_name, s.last_name
FROM Student s
JOIN Enrollment e ON s.student_id = e.student_id
WHERE e.course_id = 1;

-- Task 6: List all of the students in a course and all of their scores on every assignment for course_id 1

SELECT
    s.student_id,
    s.first_name,
    s.last_name,
    c.name AS course_name,
    a.name AS assignment_name,
    g.score
FROM
    Student s
JOIN Enrollment e ON s.student_id = e.student_id
JOIN Course c ON e.course_id = c.course_id
JOIN Category cat ON c.course_id = cat.course_id
JOIN Assignment a ON cat.category_id = a.category_id
JOIN Grade g ON a.assignment_id = g.assignment_id AND s.student_id = g.student_id
WHERE
    c.course_id = 1; 

-- Task 7: Add an Assignment to a Course
INSERT INTO Assignment (name, category_id, max_points) VALUES ('Final Project', 3, 100);

-- Task 8: Change the Percentages of the Categories for a Course
UPDATE Category SET weight = 25.00 WHERE category_id = 1;

-- Task 9: Add 2 Points to the Score of Each Student on an Assignment
UPDATE Grade SET score = score + 2 WHERE assignment_id = 1;

-- Task 10: Add 2 Points Just to Those Students Whose Last Name Contains a ‘Q’
UPDATE Grade AS g
JOIN Student AS s ON g.student_id = s.student_id
SET g.score = g.score + 2
WHERE g.assignment_id = 1 AND s.last_name LIKE '%Q%';

-- Task 11: Compute the Grade for a Student
SELECT s.student_id, s.first_name, s.last_name,
SUM((g.score / a.max_points) * c.weight) AS final_grade
FROM Grade g
JOIN Assignment a ON g.assignment_id = a.assignment_id
JOIN Category c ON a.category_id = c.category_id
JOIN Student s ON g.student_id = s.student_id
WHERE g.student_id = 1
GROUP BY g.student_id;

-- Task 12: Compute the Grade for a Student, Where the Lowest Score for a Given Category is Dropped
SELECT s.student_id, s.first_name, s.last_name,
(SUM((g.score / a.max_points) * c.weight) - SUM(LEAST((g.score / a.max_points) * c.weight))) AS final_grade_adjusted
FROM Grade g
JOIN Assignment a ON g.assignment_id = a.assignment_id
JOIN Category c ON a.category_id = c.category_id
JOIN Student s ON g.student_id = s.student_id
WHERE g.student_id = 1
GROUP BY g.student_id, c.category_id;
