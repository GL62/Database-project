DROP TABLE IF EXISTS Grade, Assignment, Category, Student, Course;
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

SELECT * FROM Student;
SELECT * FROM Course;

SELECT Category.*, Course.name AS course_name FROM Category
JOIN Course ON Category.course_id = Course.course_id;

SELECT Assignment.*, Category.name AS category_name FROM Assignment
JOIN Category ON Assignment.category_id = Category.category_id;

SELECT Grade.*, Student.first_name, Student.last_name, Assignment.name AS assignment_name FROM Grade
JOIN Student ON Grade.student_id = Student.student_id
JOIN Assignment ON Grade.assignment_id = Assignment.assignment_id;
