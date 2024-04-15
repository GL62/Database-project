-- Create Course table
CREATE TABLE Course (
    course_id INT PRIMARY KEY,
    department VARCHAR(255),
    course_number INT,
    name VARCHAR(255),
    semester VARCHAR(50),
    year INT
);

-- Create Student table
CREATE TABLE Student (
    student_id INT PRIMARY KEY,
    first_name VARCHAR(255),
    last_name VARCHAR(255)
);

-- Create Category table
CREATE TABLE Category (
    category_id INT PRIMARY KEY,
    name VARCHAR(255),
    weight FLOAT, -- percentage of total grade
    course_id INT,
    FOREIGN KEY (course_id) REFERENCES Course(course_id)
);

-- Create Assignment table
CREATE TABLE Assignment (
    assignment_id INT PRIMARY KEY,
    name VARCHAR(255),
    category_id INT,
    max_points INT,
    FOREIGN KEY (category_id) REFERENCES Category(category_id)
);

-- Create Grade table
CREATE TABLE Grade (
    grade_id INT PRIMARY KEY,
    student_id INT,
    assignment_id INT,
    score FLOAT,
    FOREIGN KEY (student_id) REFERENCES Student(student_id),
    FOREIGN KEY (assignment_id) REFERENCES Assignment(assignment_id)
);
