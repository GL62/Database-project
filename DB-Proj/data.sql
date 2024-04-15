-- Insert sample data into 'Course'
INSERT INTO Course (course_id, department, course_number, name, semester, year) VALUES
(1, 'Computer Science', 101, 'Introduction to Computer Science', 'Fall', 2024),
(2, 'Mathematics', 201, 'Calculus I', 'Spring', 2024),
(3, 'Physics', 301, 'Physics Mechanics', 'Fall', 2024);

-- Insert sample data into 'Student'
INSERT INTO Student (student_id, first_name, last_name) VALUES
(1, 'Alice', 'Smith'),
(2, 'Bob', 'Johnson'),
(3, 'Charlie', 'Brown');

-- Insert sample data into 'Category'
INSERT INTO Category (category_id, name, weight, course_id) VALUES
(1, 'Homework', 20, 1),
(2, 'Participation', 10, 1),
(3, 'Tests', 50, 1),
(4, 'Project', 20, 1);

-- Insert sample data into 'Assignment'
INSERT INTO Assignment (assignment_id, name, category_id, max_points) VALUES
(1, 'Homework 1', 1, 100),
(2, 'Homework 2', 1, 100),
(3, 'Midterm Exam', 3, 200),
(4, 'Final Project', 4, 150);

-- Insert sample data into 'Grade'
INSERT INTO Grade (grade_id, student_id, assignment_id, score) VALUES
(1, 1, 1, 85),
(2, 1, 3, 90),
(3, 2, 1, 75),
(4, 2, 3, 95);
