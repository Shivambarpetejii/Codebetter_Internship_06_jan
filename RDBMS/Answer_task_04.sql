CREATE DATABASE hr_mg;
Drop database hr_mg;

USE hr_mg;


DROP TABLE Employees;

CREATE TABLE Employees(
employee_id VARCHAR(100) PRIMARY KEY,
first_name VARCHAR(100),
last_name VARCHAR(100),
email VARCHAR(100),
phone VARCHAR(100),
hire_date DATE,
department_id VARCHAR(100),

manager_id VARCHAR(100),

salary INT
);


DROP TABLE departments;
CREATE TABLE departments(
department_id VARCHAR(100) PRIMARY KEY,
department_name VARCHAR(100),
manager_id VARCHAR(100)

);

DROP TABLE P_Reviews;
CREATE TABLE P_Reviews(
review_id VARCHAR(100) PRIMARY KEY,
employee_id VARCHAR(100),
review_date DATE,
score ENUM('Excellent','Good','Average','Poor'),
comments TEXT
);

DROP TABLE payroll;
CREATE TABLE payroll(
payroll_id VARCHAR(100) PRIMARY KEY,
employee_id VARCHAR(100),
payment_date DATE,
amount DECIMAL(10,2),
pay_m ENUM('Bank_Transfer','check','case')
);


ALTER TABLE Employees
ADD CONSTRAINT fk_employees
FOREIGN KEY employees(department_id) REFERENCES departments(department_id);


# this is not correct i think this is lock my databse 
ALTER TABLE Employees
ADD CONSTRAINT fk_employees1
FOREIGN KEY employees(manager_id) REFERENCES Employees(employee_id);

# this is not correct i think this is lock my databse 
ALTER TABLE departments
ADD CONSTRAINT fk_departments
FOREIGN KEY departments(manager_id) REFERENCES Employees(employee_id);


ALTER TABLE P_Reviews
ADD CONSTRAINT fk_P_Reviews
FOREIGN KEY P_Reviews(employee_id) REFERENCES Employees(employee_id);

ALTER TABLE payroll
ADD CONSTRAINT fk_payroll
FOREIGN KEY payroll(employee_id) REFERENCES Employees(employee_id);



-- Insert data into Departments table
INSERT INTO departments (department_id, department_name, manager_id)
VALUES 
('D001', 'Human Resources', 'E003'),
('D002', 'Finance', 'E004'),
('D003', 'IT', 'E005'),
('D004', 'Sales', 'E006');

-- Insert data into Employees table
INSERT INTO Employees (employee_id, first_name, last_name, email, phone, hire_date, department_id, manager_id, salary)
VALUES
('E001', 'John', 'Doe', 'john.doe@example.com', '1234567890', '2020-01-15', 'D003', 'E005', 80000),
('E002', 'Jane', 'Smith', 'jane.smith@example.com', '1234567891', '2021-02-20', 'D003', 'E005', 75000),
('E003', 'Sarah', 'Johnson', 'sarah.johnson@example.com', '1234567892', '2019-03-10', 'D001', NULL, 90000),
('E004', 'Mike', 'Brown', 'mike.brown@example.com', '1234567893', '2018-04-25', 'D002', NULL, 95000),
('E005', 'Emily', 'Davis', 'emily.davis@example.com', '1234567894', '2017-05-30', 'D003', NULL, 100000),
('E006', 'James', 'Wilson', 'james.wilson@example.com', '1234567895', '2021-06-12', 'D004', NULL, 85000),
('E007', 'Anna', 'Garcia', 'anna.garcia@example.com', '1234567896', '2022-07-05', 'D004', 'E006', 70000);

-- Insert data into P_Reviews table
INSERT INTO P_Reviews (review_id, employee_id, review_date, score, comments)
VALUES
('R001', 'E001', '2023-03-01', 'Excellent', 'Outstanding performance on project delivery.'),
('R002', 'E002', '2023-03-01', 'Good', 'Consistent work, improvement in communication.'),
('R003', 'E003', '2023-03-01', 'Average', 'Meeting expectations, could improve teamwork.'),
('R004', 'E004', '2023-03-01', 'Excellent', 'Exceptional leadership in the finance team.'),
('R005', 'E005', '2023-03-01', 'Good', 'Maintains high productivity consistently.'),
('R006', 'E006', '2023-03-01', 'Poor', 'Needs to improve time management and client interaction.');


INSERT INTO P_Reviews (review_id, employee_id, review_date, score, comments)
VALUES
('R007', 'E001', '2024-03-01', 'good', 'Outstanding performance on project delivery.');
-- Insert data into payroll table
INSERT INTO payroll (payroll_id, employee_id, payment_date, amount, pay_m)
VALUES
('P001', 'E001', '2023-12-01', 4000.00, 'Bank_Transfer'),
('P002', 'E002', '2023-12-01', 3750.00, 'Bank_Transfer'),
('P003', 'E003', '2023-12-01', 4500.00, 'Bank_Transfer'),
('P004', 'E004', '2023-12-01', 4750.00, 'Bank_Transfer'),
('P005', 'E005', '2023-12-01', 5000.00, 'Bank_Transfer'),
('P006', 'E006', '2023-12-01', 4250.00, 'Check'),
('P007', 'E007', '2023-12-01', 3500.00, 'Case');


#Question NO:- 1. Retrieve the names and contact details of employees hired after January 1, 2023

SELECT
	first_name,
    phone,
    hire_date
FROM
	employees
WHERE
	hire_date > 2023-01-15;
	
    
#Question NO:-2. Find the total payroll amount paid to each department.

SELECT
	dt.department_name,
    SUM(pt.amount) AS amountt
FROM
	employees AS e
JOIN
	departments AS dt
ON
	e.department_id = dt.department_id
JOIN 
	payroll AS pt
ON 
	e.employee_id = pt.employee_id
GROUP BY
	dt.department_name;
    


#Question NO:-3. List all employees who have not been assigned a manager


SELECT 
	*
FROM 
	employees
WHERE
	manager_id IS NULL;


#Question NO:-4. Retrieve the highest salary in each department along with the employee’s name.


SELECT 
    dt.department_name,
	et.first_name,
    et.last_name,
    et.salary
FROM 
	employees AS et
JOIN
	departments AS dt
ON
	et.department_id = dt.department_id
WHERE
	et.salary = (SELECT MAX(salary) 
					FROM employees 
                    WHERE department_id=et.department_id);
                    
                    
#Question NO:-5. Find the most recent performance review for each employee.

SELECT 
	 et.employee_id,
     et.first_name,
     pt.review_id,
     pt.review_date
FROM
	employees AS et
JOIN 
	p_reviews AS pt
ON 
	pt.employee_id=et.employee_id
WHERE
	pt.review_date = (SELECT 
				
                MAX(review_date) FROM p_reviews 
                WHERE employee_id = pt.employee_id
                );
     
#Question NO:-6. Count the number of employees in each department.

SELECT 
		dt.department_name,
        COUNT(et.employee_id) AS em_count
FROM
		employees AS et
JOIN 
		departments AS dt
ON
		et.department_id = dt.department_id
GROUP BY
		et.department_id;
        


#Question NO:-7. List all employees who have received a performance score of "Excellent." 


SELECT 
    et.first_name,
    et.last_name,
    et.employee_id,
    pt.score
FROM 
	employees AS et
JOIN
	P_Reviews AS pt
ON
	pt.employee_id = et.employee_id
WHERE
	pt.score ='Excellent';
    
    
# Identify themost frequently used payment method in payroll.

SELECT 
	pay_m,
    COUNT(pay_m) AS pay_count
FROM 
	payroll
GROUP BY 
	pay_m;
    
    
    
    
    
#Question NO:- 8. Retrieve the top 5 highest-paid employees along with their departments.

SELECT 
	et.first_name,
    et.last_name,
   
    MAX(et.salary) AS salary,
     dt.department_name
FROM
	employees AS et
JOIN
	departments AS dt
ON 
	dt.department_id = et.department_id
GROUP BY 
	et.employee_id
ORDER BY 
	salary DESC
LIMIT 5;
    
#Question NO:- 9.Show details of all employees who report directly to a specific manager e.g.,
#ManagerID = 101

SELECT 
	* 
FROM
	employees 
WHERE
	manager_id = 'E005';
	
	
