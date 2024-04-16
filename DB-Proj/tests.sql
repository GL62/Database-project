-- Test Cases for Grade Book Database System

-- Use this to switch to the appropriate database
USE mygradebook;

-- Check if tables exist
SELECT 'Table exists check' AS Test, TABLE_NAME FROM information_schema.tables WHERE table_schema = 'mygradebook' AND TABLE_NAME IN ('Course', 'Student', 'Category', 'Assignment', 'Grade', 'Enrollment');

-- Validate data insertion for Students
SELECT 'Count of students' AS Test, COUNT(*) AS Result FROM Student;
SELECT 'Sample student data' AS Test, * FROM Student WHERE student_id = 1;

-- Validate data insertion for Courses
SELECT 'Count of courses' AS Test, COUNT(*) AS Result FROM Course;
SELECT 'Sample course data' AS Test, * FROM Course WHERE course_id = 1;

-- Validate data insertion for Categories
SELECT 'Count of categories' AS Test, COUNT(*) AS Result FROM Category;
SELECT 'Sample category data' AS Test, * FROM Category WHERE category_id = 1;

-- Validate data insertion for Assignments
SELECT 'Count of assignments' AS Test, COUNT(*) AS Result FROM Assignment;
SELECT 'Sample assignment data' AS Test, * FROM Assignment WHERE assignment_id = 1;

-- Validate data insertion for Grades
SELECT 'Count of grades' AS Test, COUNT(*) AS Result FROM Grade;
SELECT 'Sample grade data' AS Test, * FROM Grade WHERE grade_id = 1;

-- Validate data insertion for Enrollment
SELECT 'Count of enrollments' AS Test, COUNT(*) AS Result FROM Enrollment;
SELECT 'Sample enrollment data' AS Test, * FROM Enrollment WHERE enrollment_id = 1;

-- Validate functionality of adding an assignment
INSERT INTO Assignment (name, category_id, max_points) VALUES ('Extra Assignment', 1, 100);
SELECT 'Add assignment check' AS Test, name FROM Assignment WHERE name = 'Extra Assignment';

-- Validate functionality of updating category weights
UPDATE Category SET weight = 35.00 WHERE category_id = 1;
SELECT 'Updated category weight check' AS Test, weight FROM Category WHERE category_id = 1;

-- Validate adding points to a student's grade
UPDATE Grade SET score = score + 2 WHERE assignment_id = 1 AND student_id = 1;
SELECT 'Updated score check' AS Test, score FROM Grade WHERE assignment_id = 1 AND student_id = 1;

-- Validate the conditional update for students with a 'Q' in their last name
UPDATE Grade AS g JOIN Student AS s ON g.student_id = s.student_id SET g.score = g.score + 2 WHERE s.last_name LIKE '%Q%' AND g.assignment_id = 1;
SELECT 'Conditional score update check' AS Test, s.last_name, g.score FROM Grade g JOIN Student s ON g.student_id = s.student_id WHERE s.last_name LIKE '%Q%' AND g.assignment_id = 1;

-- Validate calculation of average, highest, and lowest scores
SELECT 'Average score calculation' AS Test, AVG(score) AS average_score FROM Grade WHERE assignment_id = 1;
SELECT 'Highest score calculation' AS Test, MAX(score) AS highest_score FROM Grade WHERE assignment_id = 1;
SELECT 'Lowest score calculation' AS Test, MIN(score) AS lowest_score FROM Grade WHERE assignment_id = 1;

-- Validate listing students in a given course
SELECT 'List students in a course' AS Test, s.student_id, s.first_name, s.last_name FROM Student s JOIN Enrollment e ON s.student_id = e.student_id WHERE e.course_id = 1;

-- Validate listing all students and their scores in a course
SELECT 'Detailed scores in a course' AS Test, s.student_id, s.first_name, s.last_name, c.name AS course_name, a.name AS assignment_name, g.score FROM Student s JOIN Enrollment e ON s.student_id = e.student_id JOIN Course c ON e.course_id = c.course_id JOIN Category cat ON c.course_id = cat.course_id JOIN Assignment a ON cat.category_id = a.category_id JOIN Grade g ON a.assignment_id = g.assignment_id AND s.student_id = g.student_id WHERE c.course_id = 1;

-- Validate final grade computation
SELECT 'Final grade computation' AS Test, s.student_id, s.first_name, s.last_name, SUM((g.score / a.max_points) * c.weight) AS final_grade FROM Grade g JOIN Assignment a ON g.assignment_id = a.assignment_id JOIN Category c ON a.category_id = c.category_id JOIN Student s ON g.student_id = s.student_id WHERE g.student_id = 1 GROUP BY g.student_id;

-- Validate adjusted final grade computation
SELECT 'Adjusted final grade computation' AS Test, s.student_id, s.first_name, s.last_name, (SUM((g.score / a.max_points) * c.weight) - SUM(LEAST((g.score / a.max_points) * c.weight))) AS final_grade_adjusted FROM Grade g JOIN Assignment a ON g.assignment_id = a.assignment_id JOIN Category c ON a.category_id = c.category_id JOIN Student s ON g.student_id = s.student_id WHERE g.student_id = 1 GROUP BY g.student_id, c.category_id;
