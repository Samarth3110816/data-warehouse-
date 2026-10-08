CREATE DATABASE student_management;
USE student_management;

CREATE TABLE students (
    student_id INT PRIMARY KEY IDENTITY(1,1),
    student_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    course VARCHAR(50),
    admission_date DATE
);

CREATE TABLE subjects (
    subject_id INT PRIMARY KEY IDENTITY(1,1),
    subject_name VARCHAR(100) NOT NULL,
    total_marks INT
);

CREATE TABLE marks (
    mark_id INT PRIMARY KEY IDENTITY(1,1),
    student_id INT,
    subject_id INT,
    marks_obtained INT,
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (subject_id) REFERENCES subjects(subject_id)
);


Select * from students
Select * from subjects
Select * from marks


INSERT INTO students (student_name, email, course, admission_date)
VALUES
('Amit Patil', 'amit@gmail.com', 'BSc Chemistry', '2024-06-15'),
('Priya Sharma', 'priya@gmail.com', 'BSc Chemistry', '2024-06-15'),
('Rahul Jadhav', 'rahul@gmail.com', 'BSc Chemistry', '2024-06-15');

INSERT INTO subjects (subject_name, total_marks)
VALUES
('Chemistry', 100),
('Mathematics', 100),
('Computer Science', 100);

INSERT INTO marks (student_id, subject_id, marks_obtained)
VALUES
(1, 1, 85), (1, 2, 72), (1, 3, 90),
(2, 1, 78), (2, 2, 88), (2, 3, 81),
(3, 1, 65), (3, 2, 70), (3, 3, 75);

SELECT 
    s.student_name,
    sub.subject_name,
    m.marks_obtained
FROM students s
JOIN marks m ON s.student_id = m.student_id
JOIN subjects sub ON m.subject_id = sub.subject_id;

SELECT 
    s.student_name,
    ROUND(AVG(m.marks_obtained), 2) AS average_marks
FROM students s
JOIN marks m ON s.student_id = m.student_id
GROUP BY s.student_id, s.student_name
ORDER BY average_marks DESC;

CREATE VIEW student_performance AS
SELECT 
    s.student_name,
    ROUND(AVG(m.marks_obtained), 2) AS average_marks
FROM students s
JOIN marks m ON s.student_id = m.student_id
GROUP BY s.student_id, s.student_name;

SELECT * FROM student_performance;


CREATE PROCEDURE GetStudentMarks
    @studentId INT
AS
BEGIN
    SELECT 
        s.student_name,
        sub.subject_name,
        m.marks_obtained
    FROM students s
    INNER JOIN marks m ON s.student_id = m.student_id
    INNER JOIN subjects sub ON m.subject_id = sub.subject_id
    WHERE s.student_id = @studentId;
END;
GO


EXEC GetStudentMarks @studentId = 1;


