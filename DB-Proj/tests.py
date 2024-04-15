import unittest
from compute_grades import compute_grade, compute_grade_with_drop

class TestGradeBook(unittest.TestCase):
    def test_compute_grade(self):
        """Test computing the total grade for a given student and course."""
        # These values should be aligned with existing data in your database
        student_id = 1  # Example student ID that should exist in your Grade database
        course_id = 1   # Example course ID that should be associated with the student
        expected_grade = 85  # Expected grade based on your data.sql or adjusted accordingly
        
        result = compute_grade(student_id, course_id)
        self.assertAlmostEqual(result, expected_grade, places=2, msg="The computed grade should match the expected grade.")

    def test_compute_grade_with_drop(self):
        """Test computing the grade for a student, dropping the lowest score in each category."""
        student_id = 1  # Again, ensure these values exist and are appropriate
        course_id = 1
        # This expected grade should be calculated after removing the lowest scores
        expected_grade_with_drop = 90  # Adjust based on your expectations and data setup

        result = compute_grade_with_drop(student_id, course_id)
        self.assertAlmostEqual(result, expected_grade_with_drop, places=2, msg="The computed grade with drop should match the expected grade.")

if __name__ == '__main__':
    unittest.main()
