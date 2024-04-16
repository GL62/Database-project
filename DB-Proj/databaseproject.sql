DROP TABLE IF EXISTS Enrollment, Grade, Assignment, Category, Student, Course;
-- Create Course table
CREATE TABLE IF NOT EXISTS Course (
    course_id INT AUTO_INCREMENT PRIMARY KEY,
    department VARCHAR(255),
    course_number VARCHAR(255),  
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
    weight DECIMAL(5, 2),  
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
    score DECIMAL(5, 2), 
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

-- Insert data into Student
INSERT INTO Student (first_name, last_name) VALUES ('Richard', 'Brobbey');
INSERT INTO Student (first_name, last_name) VALUES ('Justin', 'Davis');
INSERT INTO Student (first_name, last_name) VALUES ('LLoyd', 'Lingani');
INSERT INTO Student (first_name, last_name) VALUES ('Linwei', 'Qiu');

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

INSERT INTO Category (name, weight, course_id) VALUES ('Homework', 20.00, 3);
INSERT INTO Category (name, weight, course_id) VALUES ('Projects', 80.00, 3);

INSERT INTO Assignment (name, category_id, max_points) VALUES ('HW1', 1, 100.00);
INSERT INTO Assignment (name, category_id, max_points) VALUES ('HW2', 1, 100.00);

-- Assuming category_id 2 is Tests for CS101
INSERT INTO Assignment (name, category_id, max_points) VALUES ('Midterm', 2, 100.00);
INSERT INTO Assignment (name, category_id, max_points) VALUES ('Final', 2, 100.00);

INSERT INTO Assignment (name, category_id, max_points) VALUES ('Midterm', 5, 100.00);
INSERT INTO Assignment (name, category_id, max_points) VALUES ('Final', 5, 100.00);

INSERT INTO Assignment (name, category_id, max_points) VALUES ('Writing Prompt', 6, 100.00);
INSERT INTO Assignment (name, category_id, max_points) VALUES ('Final', 7, 100.00);


-- Assumptions must be corrected with real assignment IDs
INSERT INTO Grade (student_id, assignment_id, score) VALUES (1, 1, 85.00);
INSERT INTO Grade (student_id, assignment_id, score) VALUES (2, 1, 90.00);
INSERT INTO Grade (student_id, assignment_id, score) VALUES (1, 2, 88.00);
INSERT INTO Grade (student_id, assignment_id, score) VALUES (2, 2, 94.00);

INSERT INTO Grade (student_id, assignment_id, score) VALUES (3, 1, 65.00);
INSERT INTO Grade (student_id, assignment_id, score) VALUES (4, 1, 95.00);
INSERT INTO Grade (student_id, assignment_id, score) VALUES (3, 2, 94.00);
INSERT INTO Grade (student_id, assignment_id, score) VALUES (4, 2, 86.00);

INSERT INTO Grade (student_id, assignment_id, score) VALUES (1, 5, 85.00);
INSERT INTO Grade (student_id, assignment_id, score) VALUES (2, 6, 90.00);
INSERT INTO Grade (student_id, assignment_id, score) VALUES (3, 6, 88.00);
INSERT INTO Grade (student_id, assignment_id, score) VALUES (4, 7, 94.00);
INSERT INTO Grade (student_id, assignment_id, score) VALUES (1, 6, 85.00);
INSERT INTO Grade (student_id, assignment_id, score) VALUES (2, 8, 90.00);
INSERT INTO Grade (student_id, assignment_id, score) VALUES (3, 8, 88.00);
INSERT INTO Grade (student_id, assignment_id, score) VALUES (4, 3, 94.00);

INSERT INTO Grade (student_id, assignment_id, score) VALUES (1, 3, 90.00);

INSERT INTO Enrollment (student_id, course_id) VALUES (1, 1);  -- Assumes student_id 1 is enrolled in course_id 1
INSERT INTO Enrollment (student_id, course_id) VALUES (2, 1);  -- Assumes student_id 2 is also enrolled in course_id 1
INSERT INTO Enrollment (student_id, course_id) VALUES (1, 2);  
INSERT INTO Enrollment (student_id, course_id) VALUES (2, 3);  
INSERT INTO Enrollment (student_id, course_id) VALUES (2, 2);
INSERT INTO Enrollment (student_id, course_id) VALUES (4, 3);

INSERT INTO Enrollment (student_id, course_id) VALUES (3, 1);  -- Assumes student_id 1 is enrolled in course_id 1
INSERT INTO Enrollment (student_id, course_id) VALUES (4, 1);  -- Assumes student_id 2 is also enrolled in course_id 1  
INSERT INTO Enrollment (student_id, course_id) VALUES (3, 2); 
INSERT INTO Enrollment (student_id, course_id) VALUES (3, 3);


SELECT * FROM Student;
SELECT * FROM Course;

SELECT 
    e.enrollment_id,
    s.student_id,
    s.first_name,
    s.last_name,
    c.course_id,
    c.name AS course_name
FROM 
    Enrollment e
JOIN 
    Student s ON e.student_id = s.student_id
JOIN 
    Course c ON e.course_id = c.course_id;


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

-- Listing students in a given course
SELECT s.student_id, s.first_name, s.last_name
FROM Student s
JOIN Enrollment e ON s.student_id = e.student_id
WHERE e.course_id = 1;

-- Listing students in a given course & their scores
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
    c.course_id = 3; 

-- Adding to a specific assignment
SELECT course_id FROM Course WHERE name = 'Introduction to Computer Science';
SELECT category_id, name FROM Category WHERE course_id = 1;  -- Assuming the course ID is 1
INSERT INTO Assignment (name, category_id, max_points)
VALUES ('Final Homework', 1, 200);  -- Assuming the category ID for Homework is 1
SELECT * FROM Assignment WHERE category_id = 1;

-- Changing the percantages
SELECT category_id, name, weight FROM Category WHERE course_id = 1;  
UPDATE Category
SET weight = CASE category_id
    WHEN 1 THEN 25  
    WHEN 2 THEN 40  
    WHEN 3 THEN 35  
    END
WHERE category_id IN (1, 2, 3) AND course_id = 1; 
SELECT category_id, name, weight FROM Category WHERE course_id = 1;  

-- Adding 2 points to everybodys score
SELECT student_id, assignment_id, score FROM Grade WHERE assignment_id = 1; 
SELECT assignment_id name FROM Assignment WHERE name = 'HW1 ';
UPDATE Grade
SET score = score + 2
WHERE assignment_id = 1;  

SELECT student_id, assignment_id, score FROM Grade WHERE assignment_id = 1;  

-- Adding 2 points to student with a Q in their last name
SELECT assignment_id, name FROM Assignment WHERE name = 'HW1';
UPDATE Grade
JOIN Student ON Grade.student_id = Student.student_id
SET Grade.score = Grade.score + 2
WHERE Grade.assignment_id = 1  
AND Student.last_name LIKE '%Q%';
 
SELECT Student.student_id, Student.first_name, Student.last_name, Grade.assignment_id, Grade.score
FROM Grade
JOIN Student ON Grade.student_id = Student.student_id
WHERE Grade.assignment_id = 1  
AND Student.last_name LIKE '%Q%';

-- Computing a grade for the student
SELECT
    s.student_id,
    s.first_name,
    s.last_name,
    c.course_id,
    c.name AS course_name,
    ROUND(SUM((g.score / a.max_points) * (cat.weight / 100)*100),2) AS final_grade 
FROM
    Student s
JOIN Grade g ON s.student_id = g.student_id
JOIN Assignment a ON g.assignment_id = a.assignment_id
JOIN Category cat ON a.category_id = cat.category_id
JOIN Course c ON cat.course_id = c.course_id
WHERE
    s.student_id = 1  
    AND c.course_id = 1 
GROUP BY
    s.student_id, c.course_id;


-- Computing a grade with the lowest score dropped
WITH ScoreDetails AS (
    SELECT
        s.student_id,
        s.first_name,
        s.last_name,
        a.category_id,
        c.course_id,
        c.name AS course_name,
        COALESCE(g.score, 0) AS score,
        a.max_points,
        cat.weight,
        ROW_NUMBER() OVER (PARTITION BY s.student_id, a.category_id ORDER BY g.score ASC) AS score_rank
    FROM
        Student s
    JOIN Enrollment e ON s.student_id = e.student_id
    JOIN Course c ON e.course_id = c.course_id
    JOIN Category cat ON c.course_id = cat.course_id
    JOIN Assignment a ON cat.category_id = a.category_id
    LEFT JOIN Grade g ON a.assignment_id = g.assignment_id AND s.student_id = g.student_id
    WHERE
        s.student_id = 1 AND c.course_id = 2
),
FilteredScores AS (
    SELECT
        student_id,
        first_name,
        last_name,
        course_id,
        course_name,
        CASE WHEN score_rank > 1 THEN score ELSE 0 END AS score,
        max_points,
        weight
    FROM
        ScoreDetails
)
SELECT
    student_id,
    first_name,
    last_name,
    course_id,
    course_name,
    ROUND(SUM((score / max_points) * (weight / 100)*100),2) AS final_grade
FROM
    FilteredScores
GROUP BY
    student_id, course_id;
