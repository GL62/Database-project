import sys
from compute_grades import compute_grade, compute_grade_with_drop

def main():
    while True:
        print("\nWelcome to the Grade Book System")
        print("1. Compute Total Grade for a Student")
        print("2. Compute Total Grade with Lowest Score Dropped for a Student")
        print("3. Exit")
        
        choice = input("Enter your choice (1-3): ")
        
        if choice == '1':
            student_id = int(input("Enter Student ID: "))
            course_id = int(input("Enter Course ID: "))
            grade = compute_grade(student_id, course_id)
            print(f"Total grade for Student ID {student_id} in Course ID {course_id} is: {grade:.2f}")
        
        elif choice == '2':
            student_id = int(input("Enter Student ID: "))
            course_id = int(input("Enter Course ID: "))
            grade = compute_grade_with_drop(student_id, course_id)
            print(f"Total grade with lowest score dropped for Student ID {student_id} in Course ID {course_id} is: {grade:.2f}")
        
        elif choice == '3':
            print("Exiting the Grade Book System.")
            sys.exit()
        
        else:
            print("Invalid choice. Please enter a number between 1 and 3.")

if __name__ == "__main__":
    main()
