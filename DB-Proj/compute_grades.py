from queries import fetch_grades_by_student_and_course, fetch_all_assignments

def compute_grade(student_id, course_id):
    """Compute total grade for a student in a course"""
    grades = fetch_grades_by_student_and_course(student_id, course_id)
    total_grade = sum(weighted_score for _, score, weighted_score in grades if score is not None)
    return total_grade

def compute_grade_with_drop(student_id, course_id):
    """Compute grade for a student, dropping the lowest score in each category"""
    grades = fetch_grades_by_student_and_course(student_id, course_id)
    # Group grades by category
    from collections import defaultdict
    category_scores = defaultdict(list)
    for assignment_id, score, weighted_score in grades:
        category_scores[assignment_id].append((score, weighted_score))
    
    # Drop the lowest score in each category
    final_scores = []
    for scores in category_scores.values():
        if len(scores) > 1:
            scores.remove(min(scores, key=lambda x: x[0]))  # Drop the lowest score
        final_scores.extend(scores)
    
    total_grade = sum(weighted_score for score, weighted_score in final_scores if score is not None)
    return total_grade

# Example usage
student_id = 1  # Example student ID
course_id = 1   # Example course ID
print("Total Grade:", compute_grade(student_id, course_id))
print("Total Grade with Drop:", compute_grade_with_drop(student_id, course_id))
