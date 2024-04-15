import mysql.connector
from mysql.connector import Error

def create_connection():
    """Create a database connection to the MySQL database"""
    try:
        connection = mysql.connector.connect(
            host='localhost',
            database='GradeBookDB',
            user='gradebookuser',
            password='your_password' #(actual password here plz)
        )
        return connection
    except Error as e:
        print(f"Error while connecting to MySQL: {e}")

def fetch_grades_by_student_and_course(student_id, course_id):
    """Fetch all grades for a student in a specific course"""
    try:
        conn = create_connection()
        query = """
        SELECT a.assignment_id, g.score, c.weight / COUNT(a.assignment_id) as weighted_score
        FROM Grade g
        JOIN Assignment a ON g.assignment_id = a.assignment_id
        JOIN Category c ON a.category_id = c.category_id
        WHERE g.student_id = %s AND c.course_id = %s
        GROUP BY c.category_id, a.assignment_id;
        """
        cursor = conn.cursor()
        cursor.execute(query, (student_id, course_id))
        grades = cursor.fetchall()
        cursor.close()
        return grades
    finally:
        if conn.is_connected():
            conn.close()

def fetch_all_assignments(course_id):
    """Fetch all assignments for a course, including category weights"""
    try:
        conn = create_connection()
        query = """
        SELECT a.assignment_id, c.name, c.weight
        FROM Assignment a
        JOIN Category c ON a.category_id = c.category_id
        WHERE c.course_id = %s;
        """
        cursor = conn.cursor()
        cursor.execute(query, (course_id,))
        assignments = cursor.fetchall()
        cursor.close()
        return assignments
    finally:
        if conn.is_connected():
            conn.close()
