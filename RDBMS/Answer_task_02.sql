CREATE DATABASE ola;

USE ola;

CREATE TABLE Drivers(
driver_id VARCHAR(10) PRIMARY KEY,
first_name VARCHAR(10),
last_name VARCHAR(10),
phone VARCHAR(15),
city VARCHAR(10),
vehicle_type VARCHAR(15),
rating INT CHECK(rating >=0 AND rating <=5)

);

CREATE TABLE Riders(
rider_id VARCHAR(20) PRIMARY KEY,
first_name VARCHAR(10),
last_name VARCHAR(10),
phone VARCHAR(15),
city VARCHAR(10),
join_date DATE
);

CREATE TABLE Rides(
ride_id VARCHAR(20) PRIMARY KEY,
rider_id VARCHAR(20),
FOREIGN KEY(rider_id) REFERENCES Riders(rider_id),
driver_id VARCHAR(10),
FOREIGN KEY (driver_id) REFERENCES Drivers(driver_id),
ride_date DATE,
pick_loc VARCHAR(100),	
drop_loc VARCHAR(100),
distance DECIMAL(5,2),
fare DECIMAL(10, 2),
ride_status ENUM('Completed','Cancelled','Ongoing')

);

CREATE TABLE Payments(
payment_id VARCHAR(20) PRIMARY KEY,
rider_id VARCHAR(20),
FOREIGN KEY(rider_id) REFERENCES Riders(rider_id),
pay_meth ENUM('Card','Cash','Wallet'),
amount DECIMAL(11,2),
pay_date DATE

);


INSERT INTO Drivers (driver_id, first_name, last_name, phone, city, vehicle_type, rating)
VALUES
('DRV001', 'Amit', 'Kumar', '9876543210', 'Delhi', 'Sedan', 5),
('DRV002', 'Raj', 'Sharma', '8765432109', 'Mumbai', 'SUV', 4),
('DRV003', 'Priya', 'Singh', '7654321098', 'Bangalore', 'Hatchback', 4),
('DRV004', 'Anil', 'Yadav', '6543210987', 'Hyderabad', 'Bike', 3),
('DRV005', 'Sneha', 'Gupta', '5432109876', 'Pune', 'Auto', 5);


INSERT INTO Riders (rider_id, first_name, last_name, phone, city, join_date)
VALUES
('RID001', 'Rohan', 'Verma', '9988776655', 'Delhi', '2023-01-15'),
('RID002', 'Pooja', 'Chopra', '8877665544', 'Mumbai', '2023-02-10'),
('RID003', 'Karan', 'Mehta', '7766554433', 'Bangalore', '2023-03-20'),
('RID004', 'Aisha', 'Malik', '6655443322', 'Hyderabad', '2023-04-12'),
('RID005', 'Vikram', 'Nair', '5544332211', 'Pune', '2023-05-05');

INSERT INTO Riders (rider_id, first_name, last_name, phone, city, join_date)
VALUES
('RID006', 'Shivam', 'Verma', '9988776655', 'Delhi', '2023-01-20');



INSERT INTO Rides (ride_id, rider_id, driver_id, ride_date, pick_loc, drop_loc, distance, fare, ride_status)
VALUES
('RIDE001', 'RID001', 'DRV001', '2023-06-01', 'Connaught Place', 'Noida', 15.50, 300.00, 'Completed'),
('RIDE002', 'RID002', 'DRV002', '2023-06-05', 'Andheri West', 'Bandra', 10.00, 200.00, 'Cancelled'),
('RIDE003', 'RID003', 'DRV003', '2023-06-10', 'Whitefield', 'Electronic City', 25.00, 500.00, 'Completed'),
('RIDE004', 'RID004', 'DRV004', '2023-06-15', 'Hitech City', 'Secunderabad', 12.75, 250.00, 'Ongoing'),
('RIDE005', 'RID005', 'DRV005', '2023-06-20', 'Kothrud', 'Wakad', 8.00, 150.00, 'Completed');

INSERT INTO Rides (ride_id, rider_id, driver_id, ride_date, pick_loc, drop_loc, distance, fare, ride_status)
VALUES
('RIDE006', 'RID001', 'DRV001', '2023-06-01', 'Connaught Place', 'Bandra', 15.50, 300.00, 'Completed');

INSERT INTO Rides (ride_id, rider_id, driver_id, ride_date, pick_loc, drop_loc, distance, fare, ride_status)
VALUES
('RIDE007', 'RID001', 'DRV001', '2024-06-01', 'Connaught Place', 'Bandra', 15.50, 300.00, 'Completed');


INSERT INTO Payments (payment_id, rider_id, pay_meth, amount, pay_date)
VALUES
('PAY001', 'RID001', 'Card', 300.00, '2023-06-01'),
('PAY002', 'RID003', 'Wallet', 500.00, '2023-06-10'),
('PAY003', 'RID005', 'Cash', 150.00, '2023-06-20');

INSERT INTO Payments (payment_id, rider_id, pay_meth, amount, pay_date)
VALUES
('PAY004', 'RID001', 'Card', 300.00, '2023-07-01');


SELECT * FROM Drivers;
SELECT * FROM Riders;
SELECT * FROM Rides;
SELECT * FROM Payments;


#Question NO 1. Retrieve the names and contact details of all drivers with a rating of 4.5 or higher.

SELECT 
	first_name,
    last_name,
    phone
FROM
	Drivers 
WHERE
	rating >= 4.5;
    
#Question NO 2. Find the total number of rides completed by each driver.

SELECT 
	dt.driver_id,
	dt.first_name,
    dt.last_name,
    COUNT(rd.driver_id) AS total_count
FROM
	Drivers AS dt
JOIN
	Rides AS rd
ON
	dt.driver_id = rd.driver_id
WHERE
	rd.ride_status = 'Completed'
GROUP BY 
	rd.driver_id;
	
    
#Question No:-3. List all riders who have never booked a ride.

SELECT 
	rt.first_name,
	rt.last_name
FROM
	Riders AS rt
LEFT JOIN 
	Rides AS rd
ON 
	rd.rider_id = rt.rider_id
WHERE
	rd.rider_id IS NULL;
    
#Question No:-4. Calculate the total earnings of each driver from completed rides.

SELECT 
	dt.driver_id,
    dt.first_name,
    SUM(rd.fare) AS total_rs
FROM
	Drivers AS dt
JOIN
	Rides AS rd
ON
	dt.driver_id = rd.driver_id
WHERE
	rd.ride_status = 'Completed'
GROUP BY
	dt.driver_id
ORDER BY
	total_rs ASC;
    
    
    
#Question No:-5. Retrieve the most recent ride for each rider

SELECT 
	rt.first_name,
    rt.last_name,
    MAX(rd.ride_date) AS curr_date
FROM 
	Riders AS rt
JOIN 
	Rides AS rd
ON 
	rt.rider_id =rd.rider_id
GROUP BY
	rt.rider_id;


#Question N0:-6. Count the number of rides taken in each city.

SELECT 
	pick_loc,
    drop_loc,
    COUNT(ride_id) AS count_rid
FROM
	Rides
GROUP BY 
	pick_loc,drop_loc;


#Question NO :-7. List all rides where the distance was greater than 20 km.

SELECT 
	*
FROM
	Rides
WHERE
	distance >=20;
    
#Question NO :-8. Identify the most preferred payment method.

SELECT
	pay_meth,
    COUNT(pay_meth) AS num
FROM
	Payments
GROUP BY
	pay_meth
ORDER BY
	num DESC
LIMIT 1;


#Question NO :-9 Find the top 3 highest-earning drivers.

SELECT 
	dt.first_name,
    SUM(rd.fare) AS ernn
FROM 
	Drivers AS dt
JOIN
	Rides AS rd
ON
	rd.driver_id = dt.driver_id
GROUP BY 
	dt.driver_id,dt.first_name
ORDER BY 
		ernn DESC
LIMIT 3;

#Question NO :-10. Retrieve details of all cancelled rides along with the rider's and driver's names


SELECT 
  CONCAT(dt.first_name,' ',dt.last_name) AS driver_name,
  CONCAT(rt.first_name,' ',rt.last_name) AS rider_name
FROM
	Drivers AS dt
JOIN 
	 Rides AS rd
ON 
	rd.driver_id = dt.driver_id
JOIN
	 Riders AS rt
ON 
	rt.rider_id = rd.rider_id
WHERE
	rd.ride_status='Cancelled';
	
    

    


	

	

	
    
	
	
	


    


	
    








