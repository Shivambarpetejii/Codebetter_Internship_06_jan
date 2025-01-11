# Frist of all i am creating a database this database name is university_data

CREATE DATABASE university_data;

# I am entring in database

USE university_data;

# I am creating table name students

CREATE TABLE students(
student_id INT PRIMARY KEY,
frist_name VARCHAR(100),
last_name VARCHAR(100),
email VARCHAR(100),
phone VARCHAR(20),
date_of_birth DATE,
enrollment_date DATE,
department_id INT
);

# Insert the data into table name is student

INSERT INTO students (student_id, frist_name, last_name, email, phone, date_of_birth, enrollment_date, department_id)
VALUES
(1, 'John', 'Doe', 'john.doe@example.com', '123-456-7890', '2000-05-15', '2022-08-20', 101),
(2, 'Jane', 'Smith', 'jane.smith@example.com', '987-654-3210', '1999-10-25', '2021-09-15', 102),
(3, 'Alice', 'Johnson', 'alice.johnson@example.com', '555-123-4567', '2001-03-12', '2023-01-10', 103),
(4, 'Bob', 'Brown', 'bob.brown@example.com', '444-567-8910', '1998-11-02', '2020-05-18', 104),
(5, 'Charlie', 'Davis', 'charlie.davis@example.com', '333-789-1234', '2002-07-19', '2024-06-01', 101),
(6, 'Diana', 'Miller', 'diana.miller@example.com', '222-456-7890', '2000-12-25', '2022-09-01', 102),
(7, 'Ethan', 'Clark', 'ethan.clark@example.com', '111-234-5678', '2003-01-14', '2023-08-15', 103),
(8, 'Fiona', 'Lee', 'fiona.lee@example.com', '666-345-6789', '1997-09-23', '2019-07-20', 104);




#showing data from students table
SELECT * FROM students;

#I am creating seconde table name courses

CREATE TABLE courses(
course_id INT PRIMARY KEY,
course_name VARCHAR(100),
department_id INT,
professor_id INT,
credits INT
);

# Insert the data into table name is courses

INSERT INTO courses (course_id, course_name, department_id, professor_id, credits)
VALUES
(101, 'Introduction to Computer Science', 101, 1, 3),
(102, 'Data Structures and Algorithms', 101, 2, 4),
(103, 'Advanced Mathematics', 102, 3, 4),
(104, 'Physics Fundamentals', 102, 4, 3),
(105, 'Software Engineering', 103, 5, 3),
(106, 'Database Management Systems', 103, 6, 3),
(107, 'Machine Learning Basics', 104, 7, 4),
(108, 'Artificial Intelligence', 104, 8, 4);

#showing data from courses table
SELECT * FROM courses;





#I am creating Third table name Departments

CREATE TABLE departments(
department_id INT PRIMARY KEY,
department_name VARCHAR(100)
);

# Insert the data into table name is departments
INSERT INTO departments (department_id, department_name)
VALUES
(101, 'Computer Science'),
(102, 'Mathematics'),
(103, 'Information Technology'),
(104, 'Physics');

#showing data from departments table
SELECT * FROM departments;




#I am creating fourth table name Professors

CREATE TABLE professors(
professor_id INT PRIMARY KEY,
first_name VARCHAR(100),
last_name VARCHAR(100),
email VARCHAR(100),
phone VARCHAR(20)
);

# Insert the data into table name is professors

INSERT INTO professors (professor_id, first_name, last_name, email, phone)
VALUES
(1, 'Alan', 'Turing', 'alan.turing@example.com', '123-456-7890'),
(2, 'Grace', 'Hopper', 'grace.hopper@example.com', '987-654-3210'),
(3, 'Carl', 'Gauss', 'carl.gauss@example.com', '555-123-4567'),
(4, 'Marie', 'Curie', 'marie.curie@example.com', '444-567-8910'),
(5, 'Ada', 'Lovelace', 'ada.lovelace@example.com', '333-789-1234'),
(6, 'Edsger', 'Dijkstra', 'edsger.dijkstra@example.com', '222-456-7890'),
(7, 'Andrew', 'Ng', 'andrew.ng@example.com', '111-234-5678'),
(8, 'Geoffrey', 'Hinton', 'geoffrey.hinton@example.com', '666-345-6789');




#showing data from professors table
SELECT * FROM professors;


#I am creating fifth table name Enrollmets

CREATE TABLE enrollments(
enrollment_id INT PRIMARY KEY,
student_id INT, 
course_id INT,
enrollment_data DATE,
grade VARCHAR(5) 
);

# Insert the data into table name is enrollments
INSERT INTO enrollments (enrollment_id, student_id, course_id, enrollment_data, grade)
VALUES
(1, 1, 101, '2022-08-25', 'A'),
(2, 2, 102, '2021-09-20', 'B+'),
(3, 3, 103, '2023-01-15', 'A-'),
(4, 4, 104, '2020-05-22', 'B'),
(5, 5, 105, '2024-06-10', 'A+'),
(6, 6, 106, '2022-09-05', 'B-'),
(7, 7, 107, '2023-08-20', 'A'),
(8, 8, 108, '2019-07-25', 'A-');





#showing data from enrollments table
SELECT * FROM enrollments;

# I will create foreign key in student table refrences from Departments
ALTER TABLE students
ADD CONSTRAINT fk_department
FOREIGN KEY (department_id) REFERENCES departments(department_id);


# I will create foreign key in courses table refrences from Departments
ALTER TABLE courses
ADD CONSTRAINT fk_courses
FOREIGN KEY (department_id) REFERENCES departments(department_id);

# I will create foreign key in courses table refrences from professors
ALTER TABLE courses
ADD CONSTRAINT fk_courses_pro
FOREIGN KEY (professor_id) REFERENCES professors(professor_id);
 
 
 
# I will create foreign key in enrillments table refrences from students
ALTER TABLE enrollments
ADD CONSTRAINT fk_enrollments_std
FOREIGN KEY (student_id) REFERENCES students(student_id);


# I will create foreign key in enrillments table refrences from courses
ALTER TABLE enrollments
ADD CONSTRAINT fk_enrollments_courses
FOREIGN KEY (course_id) REFERENCES courses(course_id);


# Question no 1 Find the Total Number of Students in each Department

# Answer:-
		#Ansewer 01:
			SELECT 
				department_id, COUNT(frist_name) AS _count
			FROM
				students as st 
            GROUP BY 
				department_id; 
            
            
		#Answer 02:
            SELECT
				department_name, COUNT(frist_name) AS _count
			FROM
				students as st
			JOIN
                departments as dt
			ON
				st.department_id = dt.department_id
			GROUP BY
				st.department_id;
	
    #Answer 03:
		SELECT
			department_name, COUNT(st.student_id)
		FROM 
			students AS st,
            departments AS dt
		WHERE 
			st.department_id = dt.department_id 
		GROUP BY
			(st.department_id) ;
             
             
# Question NO-2 List All Courses Taught by a Specific Professor

#Answe 01:-

SELECT 
	ct.course_name,
    pt.first_name,
    pt.last_name
FROM 
	courses AS ct
JOIN
	professors AS pt
ON
	pt.professor_id = ct.professor_id
WHERE
	
	 pt.first_name = "Alan"
     AND 
     pt.last_name = "Turing";
     
#Answer NO-2

SELECT
	ct.course_name,
    pt.first_name,
    pt.last_name
FROM 
	professors AS pt,
    courses AS ct
WHERE
	ct.professor_id
    IN
	( 
	  
		pt.first_name = "Alan"
		AND 
		pt.last_name = "Turing");
        
        
#Question no-03 Find the Average Grade of Students in Each Course

SELECT 
	ct.course_name,
    AVG(CASE
        WHEN et.grade = 'A+' THEN 4.3
        WHEN et.grade = 'A' THEN 4.0
        WHEN et.grade = 'A-' THEN 3.7
        WHEN et.grade = 'B+' THEN 3.3
        WHEN et.grade = 'B' THEN 3.0
        WHEN et.grade = 'B-' THEN 2
        ELSE NULL END) AS average_grade
	FROM
		enrollments AS et
	JOIN
		courses AS ct
	ON
		ct.course_id = et.course_id
	GROUP BY
		ct.course_id,ct.course_name
	ORDER BY 
		average_grade DESC;
        
        
#Question no -4:-List All Students Who Have Not Enrolled in Any Courses

INSERT INTO students (student_id, frist_name, last_name, email, phone, date_of_birth, enrollment_date, department_id)
VALUES(9, 'Shivam', 'Barpete', 'sb.141@example.com', '123-456-7890', '2000-05-15', '2022-08-20', 101);

INSERT INTO enrollments (enrollment_id, student_id, course_id, enrollment_data, grade)
VALUES
(9, 9, NULL, '2022-08-25', 'A');

SELECT
	st.student_id, st.frist_name, et.enrollment_id
FROM 
	students AS st
LEFT JOIN 
	enrollments AS et 
    ON st.student_id = et.student_id
WHERE
	et.course_id IS NULL;
		
        
#Question no 5:-  Find the Number of Courses Offered by Each Department

    SELECT 
		dt.department_name,
        COUNT(ct.department_id)
	FROM
		departments AS dt
	JOIN
		courses AS ct
	ON
		ct.department_id = dt.department_id
	GROUP BY 
		ct.department_id;
        
#Question no  6 :- List All Students Who Have Taken a Specific Course (e.g., 'Database Systems')

	SELECT 
		st.student_id,
        st.frist_name,
        st.last_name,
        st.email
	FROM
		students AS st
	JOIN
		enrollments AS et
	ON
		st.student_id = et.student_id
	JOIN
		courses AS ct
	ON
		ct.course_id = et.course_id
	WHERE
		 ct.course_name = "Software Engineering";
		
        
#Question No :- 7. Find the Most Popular Course Based on Enrollment Numbers

		UPDATE enrollments
		SET course_id=108
		WHERE enrollment_id=9;


		SELECT
			ct.course_name,
            COUNT(et.student_id) AS enrolled_std
		FROM 
			courses AS ct
		JOIN 
			enrollments AS et
		ON
			ct.course_id = et.course_id
		GROUP BY
			et.course_id
           
		ORDER BY
			enrolled_std DESC
		LIMIT 1;
        
        
#Question No-8. Find the Average Number of Credits Per Student in a Departmentcredits

  SELECT 
	dt.department_name,
    AVG(ct.credits) AS avg_std
  FROM 
	students AS st
  JOIN 
	enrollments AS et
  ON 
    st.student_id = et.student_id
 JOIN 
	courses AS ct
  ON
    ct.course_id=et.course_id
  JOIN 
	departments AS dt
  ON 
	dt.department_id=st.department_id
 GROUP BY 
 dt.department_id;
 
 
 #Question no :-9 List All Professors Who Teach in More Than One Department
 
 SELECT 
	pt.professor_id,
    pt.first_name,
    COUNT(ct.department_id) AS numbers
FROM
	professors AS pt
JOIN
	courses AS ct
ON
	pt.professor_id = ct.professor_id

GROUP BY
	ct.professor_id
HAVING
	 numbers>1;
     
     
#Question ON :- 10. Get the Highest and Lowest Grade in a Specific Course (e.g., 'Operating Systems')

SELECT 
	ct.course_name,
    ct.course_id,
    MAX(et.grade) AS max_grd,
    MIN(et.grade) AS min_grd
FROM
	enrollments AS et
JOIN
	courses AS ct
	
ON
	ct.course_id = et.course_id
WHERE
	ct.course_name='Artificial Intelligence'
GROUP BY 
	ct.course_id;
	
	
 
 
 
  
    
	
			
	

        
		

		
	  
    
		



			
			
			


