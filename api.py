from fastapi import FastAPI, HTTPException
from pydantic import BaseModel
import mysql.connector

app = FastAPI()

conn = mysql.connector.connect(
    host="localhost",
    user="root",
    password="pass123456789",
    database="studentsdb"
)

cursor = conn.cursor(dictionary=True)

# Models
class Student(BaseModel):
    name: str
    email: str

class Course(BaseModel):
    name: str

class Enrollment(BaseModel):
    student_id: int
    course_id: int

# CRUD - Students
@app.post("/students/")
def create_student(student: Student):
    cursor.execute("INSERT INTO students (name, email) VALUES (%s, %s)", (student.name, student.email))
    conn.commit()
    return {"msg": "Student created"}

@app.get("/students/")
def get_students():
    cursor.execute("SELECT * FROM students")
    return cursor.fetchall()

@app.put("/students/{student_id}")
def update_student(student_id: int, student: Student):
    cursor.execute("UPDATE students SET name=%s, email=%s WHERE id=%s", (student.name, student.email, student_id))
    conn.commit()
    return {"msg": "Student updated"}

@app.delete("/students/{student_id}")
def delete_student(student_id: int):
    cursor.execute("DELETE FROM students WHERE id=%s", (student_id,))
    conn.commit()
    return {"msg": "Student deleted"}

#CRUD - courses
@app.post("/courses/")
def create_course(course: Course):
    cursor.execute("INSERT INTO courses (course_name) VALUES (%s)", (course.name))
    conn.commit()
    return {"msg": "Course created"}

@app.get("/courses/")
def get_courses():
    cursor.execute("SELECT * FROM courses")
    return cursor.fetchall()

@app.delete("/courses/{course_id}")
def delete_course(course_id: int):
    cursor.execute("DELETE FROM courses WHERE id=%s", (course_id,))
    conn.commit()
    return {"msg": "Course deleted"}

#Enrollement
@app.post("/enrollments/")
def create_enrollment(enrollment: Enrollment):
    cursor.execute("INSERT INTO enrollments (student_id, course_id) VALUES (%s, %s)", (enrollment.student_id, enrollment.course_id))
    conn.commit()
    return {"msg": "Enrollment created"}

@app.get("/enrollments/")
def get_enrollments():
    cursor.execute("""
        SELECT e.id, s.name AS student_name, c.name AS course_name
        FROM enrollments e
        JOIN students s ON e.student_id = s.id
        JOIN courses c ON e.course_id = c.id
    """)
    return cursor.fetchall()

@app.delete("/enrollments/{enrollment_id}")
def delete_enrollment(enrollment_id: int):
    cursor.execute("DELETE FROM enrollments WHERE id=%s", (enrollment_id,))
    conn.commit()
    return {"msg": "Enrollment deleted"}
