CREATE DATABASE dpas;

USE dpas;

CREATE TABLE Doctors(
doctor_id INT PRIMARY KEY,
first_name VARCHAR(100),
last_name VARCHAR(100),
email VARCHAR(20),
phone VARCHAR(20),
department_id INT,
specialty_id INT,
joining_date DATE
);

CREATE TABLE Patients(
patient_id INT PRIMARY KEY,
first_name VARCHAR(100),
last_name VARCHAR(100),
email VARCHAR(20),
phone VARCHAR(20),
dob DATE,
gender VARCHAR(10),
address TEXT 

); 


CREATE TABLE departments(
department_id INT PRIMARY KEY,
department_name VARCHAR(100)
);

CREATE TABLE Specialties(
specialty_id INT PRIMARY KEY,
specialty_name ENUM('Cardiology','Dermatology')
);


CREATE TABLE Appointments(
appointment_id INT PRIMARY KEY,
doctor_id INT,
patient_id INT,
appointment_date DATETIME,
reason TEXT,
status VARCHAR(20)
);


CREATE TABLE payments(
payment_id INT PRIMARY KEY, 
appointment_id INT,
payment_date DATE,
payment_amount DECIMAL(10,2),
payment_method VARCHAR(20)

);

ALTER TABLE doctors
ADD CONSTRAINT fk_depatment_doctor
FOREIGN KEY doctors(department_id ) REFERENCES departments(department_id);

ALTER TABLE doctors
ADD CONSTRAINT fk_specialty_doctor
FOREIGN KEY doctors(specialty_id ) REFERENCES specialties(specialty_id);

ALTER TABLE appointments
ADD CONSTRAINT fk_doctor_specialty
FOREIGN KEY appointments(doctor_id ) REFERENCES doctors(doctor_id);

ALTER TABLE appointments
ADD CONSTRAINT fk_appointments
FOREIGN KEY appointments(patient_id ) REFERENCES patients(patient_id);

ALTER TABLE payments
ADD CONSTRAINT fk_appointments1
FOREIGN KEY payments(appointment_id ) REFERENCES appointments(appointment_id);



INSERT INTO departments (department_id, department_name) VALUES
(1, 'Cardiology'),
(2, 'Dermatology'),
(3, 'Orthopedics'),
(4, 'Neurology');


INSERT INTO specialties (specialty_id, specialty_name) VALUES
(1, 'Cardiology'),
(2, 'Dermatology');


INSERT INTO doctors (doctor_id, first_name, last_name, email, phone, department_id, specialty_id, joining_date) VALUES
(1, 'John', 'Doe', 'john.doe@.com', '1234567890', 1, 1, '2022-01-15'),
(2, 'Jane', 'Smith', 'jane.smith@.com', '0987654321', 2, 2, '2023-03-10');


INSERT INTO patients (patient_id, first_name, last_name, email, phone, dob, gender, address) VALUES
(1, 'Alice', 'Brown', 'alice.brown@.com', '9876543210', '1990-06-25', 'Female', '123 Elm Street'),
(2, 'Bob', 'Johnson', 'bob.johnson@.com', '8765432109', '1985-09-15', 'Male', '456 Oak Avenue');

INSERT INTO patients (patient_id, first_name, last_name, email, phone, dob, gender, address) VALUES
(3, 'Shivam', 'Brown', 'alice1.brown@.com', '9876543210', '1990-06-25', 'male', '123 Elm Street');


INSERT INTO appointments (appointment_id, doctor_id, patient_id, appointment_date, reason, status) VALUES
(1, 1, 1, '2023-12-20 10:00:00', 'Routine check-up', 'Scheduled'),
(2, 2, 2, '2023-12-21 15:30:00', 'Skin rash consultation', 'Completed');

INSERT INTO appointments (appointment_id, doctor_id, patient_id, appointment_date, reason, status) VALUES
(3, 1, 3, '2023-12-20 10:00:00', 'Routine check-up', 'Scheduled');

INSERT INTO appointments (appointment_id, doctor_id, patient_id, appointment_date, reason, status) VALUES
(3, 1, 3, '2023-12-20 10:00:00', 'Routine check-up', 'Scheduled');


INSERT INTO payments (payment_id, appointment_id, payment_date, payment_amount, payment_method) VALUES
(1, 1, '2023-12-20', 150.00, 'Credit Card'),
(2, 2, '2023-12-21', 200.00, 'Cash');

#1. Find the Total Number of Appointments for Each Doctor

SELECT 
 d.doctor_id,
 d.first_name,
 d.last_name,
 COUNT(a.appointment_id) AS count_ap
FROM
	doctors AS d 
JOIN
	appointments AS a
ON 
	a.doctor_id = d.doctor_id
GROUP BY 
	d.doctor_id;
	
#2. List All Patients Who Have an Appointment with a Specific Doctor (e.g., Dr. John Smith)

SELECT
	p.patient_id,
    p.first_name,
    p.last_name,
    d.first_name
FROM
	patients AS p
JOIN
	appointments AS a
ON 
	a.patient_id = p.patient_id
JOIN
	doctors AS d
ON
	a.doctor_id = d.doctor_id
WHERE
	d.first_name ='John'
    AND
    d.last_name ='Doe';
	
    
    
#3. Find the Number of Appointments Scheduled in a Specific Department

SELECT 
	dd.department_id,
    dd.department_name,
    COUNT(a.status) AS count_ap
FROM 
	departments AS dd
JOIN
	doctors AS d
ON
	d.department_id = dd.department_id
JOIN
	appointments AS a
ON
	a.doctor_id = d.doctor_id
WHERE
	a.status = 'Scheduled' 
    AND
    dd.department_name ='Cardiology'
	
GROUP BY 
	dd.department_id;
	
	
#4. Find the Most Popular Specialty Based on Number of Appointments

SELECT 
	s.specialty_name,
    SUM(d.specialty_id) AS appo
FROM
	specialties AS s 
JOIN
	doctors AS d 
ON 
	d.specialty_id = s.specialty_id
GROUP BY 
	s.specialty_id
ORDER BY 
	appo DESC
LIMIT 1;


#5. Get the Total Payment Amount for All Completed Appointments

SELECT
	a.appointment_id,
    SUM(p.payment_amount) AS rs
FROM 
	payments AS p
JOIN
	appointments AS a 
ON 
	a.appointment_id = p.appointment_id
GROUP BY 
	a.appointment_id;
	
#6. Find the Number of Patients Seen by Each Doctor

SELECT 
		d.first_name,
        d.last_name,
        COUNT(a.patient_id) AS num
FROM 
		doctors AS d
JOIN 
		appointments AS a 
ON 
		a.doctor_id = d.doctor_id
GROUP BY
		d.doctor_id;
        
        

#7. List All Patients Who Have Missed Their Appointments (Status 'Cancelled')

SELECT 

	p.first_name,
	p.last_name,
	a.status
FROM 
	appointments AS a
JOIN 
	patients AS p 
ON 
	a.patient_id = p.patient_id
WHERE
	a.status = 'Cancelled';
    
    
    
#8. Find the Total Number of Appointments for Each Status (Scheduled, Completed, Cancelled)

SELECT
     status, 
	 COUNT(appointment_id) AS scheduled
FROM
	appointments
GROUP BY 
		status;


#9. Get the Average Payment Amount for Completed Appointments


SELECT
	a.appointment_id,
    AVG(p.payment_amount) AS average
FROM 
	payments AS p 
JOIN
	appointments AS a
ON 
	p.appointment_id = a.appointment_id
WHERE
	a.status = 'Completed'
GROUP BY 
	a.appointment_id;
    
    
#10. Find the Doctor with the Highest Number of Appointments

SELECT 
	d.doctor_id,
    d.first_name,
    d.last_name,
    COUNT(a.appointment_id) as appo
FROM 
	doctors AS d
JOIN 
	appointments AS a
ON 
	a.doctor_id = d.doctor_id
GROUP BY 
	d.doctor_id
ORDER BY 
	appo DESC
LIMIT 
1;
	















