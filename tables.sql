CREATE DATABASE studentsDB;
USE studentsDB;
-- Students table
CREATE TABLE Students ( 
student_id INT PRIMARY KEY AUTO_INCREMENT,
studentName VARCHAR (100),
gender VARCHAR (50),
DOB DATE,
email VARCHAR (100) UNIQUE,
phone VARCHAR (20),
enrollment_year VARCHAR (10)
);
INSERT INTO Students (studentName, gender, DOB, email, phone, enrollment_year)
VALUES
("Haddasah Keya", "Female", '2005-7-8', "haddashk@gmail.com", "0789897467", "2024"),
("Lusa Mwana", "Female", '2004-9-10', "lusa@gmail.com", "0767896734", "2023"),
("Oliver Bane", "Male", '2003-7-3', "oliverbane@gmail.com", "0763478245", "2022"),
("Papa Jones", "Male", '2002-6-4', "papajoe@gmail.com", "0753467253", "2021"),
("Kanda Elizabeth", "Female", '2001-4-5', "kandaeliz2@gamil.com", "0763452365", "2020");
-- Courses Table
CREATE TABLE Courses (
    course_id INT AUTO_INCREMENT PRIMARY KEY,
    course_name VARCHAR(100),
    course_code VARCHAR(10) UNIQUE,
    credit_hours INT
);
INSERT INTO Courses (course_name, course_code, credit_hours) VALUES
('Mathematics 101', 'MATH101'),
('Physics 101', 'PHYS101'),
('Computer Science 101', 'CS101'),
('English Literature', 'ENG101'),
('Biology 101', 'BIO101');
-- Enrollments Table
CREATE TABLE Enrollments (
    enrollment_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT,
    course_id INT,
    enrollment_date VARCHAR (10),
    FOREIGN KEY (student_id) REFERENCES Students(student_id),
    FOREIGN KEY (course_id) REFERENCES Courses(course_id)
);
INSERT INTO Enrollments (student_id, course_id, enrollment_date) VALUES
(1, 1, '2024'),
(2, 2, '2023'),
(3, 3, '2022'),
(4, 1, '2021'),
(5, 4, '2020');
-- Grades Table
CREATE TABLE Grades (
    grade_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT,
    course_id INT,
    grade VARCHAR(5),
    date_recorded DATE,
    FOREIGN KEY (student_id) REFERENCES Students(student_id),
    FOREIGN KEY (course_id) REFERENCES Courses(course_id)
);
INSERT INTO Grades (student_id, course_id, grade, date_recorded) VALUES
(1, 1, 'A', '2023-05-10'),
(2, 2, 'B+', '2023-05-11'),
(3, 3, 'A-', '2023-05-12'),
(4, 1, 'B', '2023-05-13'),
(5, 4, 'A', '2023-05-14');
-- Teachers Table
CREATE TABLE Teachers (
    teacher_id INT AUTO_INCREMENT PRIMARY KEY,
    teacherName VARCHAR(100),
    email VARCHAR(100),
    phone VARCHAR(15),
    department VARCHAR(50)
);
INSERT INTO Teachers (teacherName, email, phone, department) VALUES
('Dr. Stella Maris', 'stella@gmail.com', '0789012345', 'Mathematics'),
('Mr. Peter Otieno', 'peter@gmail.com', '0790123456', 'Physics'),
('Ms. Faith Wanjiku', 'faith@gmail.com', '0712349876', 'Computer Science'),
('Dr. Brian Kim', 'brian@gmail.com', '0723987654', 'English'),
('Mrs. Linda Mwangi', 'linda@gmail.com', '0745698123', 'Biology');
-- Classes Table
CREATE TABLE Classes (
    class_id INT AUTO_INCREMENT PRIMARY KEY,
    course_id INT,
    teacher_id INT,
    room VARCHAR(20),
    time_slot VARCHAR(20),
    day VARCHAR(10),
    FOREIGN KEY (course_id) REFERENCES Courses(course_id),
    FOREIGN KEY (teacher_id) REFERENCES Teachers(teacher_id)
);
INSERT INTO Classes (course_id, teacher_id, room, time_slot, day) VALUES
(1, 1, 'Room A1', '08:00 - 09:30', 'Monday'),
(2, 2, 'Room B1', '10:00 - 11:30', 'Tuesday'),
(3, 3, 'Lab C1', '14:00 - 15:30', 'Wednesday'),
(4, 4, 'Room D1', '09:00 - 10:30', 'Thursday'),
(5, 5, 'Room E1', '13:00 - 14:30', 'Friday');
-- Attendance Table
CREATE TABLE Attendance (
    attendance_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT,
    class_id INT,
    status VARCHAR(10),
    date DATE,
    FOREIGN KEY (student_id) REFERENCES Students(student_id),
    FOREIGN KEY (class_id) REFERENCES Classes(class_id)
);
INSERT INTO Attendance (student_id, class_id, status, date) VALUES
(1, 1, 'Present', '2023-03-01'),
(2, 2, 'Absent', '2023-03-01'),
(3, 3, 'Present', '2023-03-01'),
(4, 1, 'Present', '2023-03-01'),
(5, 4, 'Present', '2023-03-01');
-- Fees Table
CREATE TABLE Fees (
    fee_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT,
    amount_due DECIMAL(10,2),
    amount_paid DECIMAL(10,2),
    payment_date DATE,
    status VARCHAR(10),
    FOREIGN KEY (student_id) REFERENCES Students(student_id)
);
INSERT INTO Fees (student_id, amount_due, amount_paid, payment_date, status) VALUES
(1, 50000, 50000, '2023-02-15', 'Paid'),
(2, 50000, 25000, '2023-02-16', 'Pending'),
(3, 50000, 50000, '2023-02-17', 'Paid'),
(4, 50000, 40000, '2023-02-18', 'Pending'),
(5, 50000, 50000, '2023-02-19', 'Paid');
-- Join queries
-- Display student name and the course
SELECT s.studentName, c.course_name
FROM students AS s
JOIN Enrollments e ON s.student_id = e.student_id
JOIN Courses c ON e.course_id = c.course_id;
-- Display studentname and the grade
SELECT s.studentName, g.grade
FROM students s
JOIN grades g ON s.student_id = g.student_id;