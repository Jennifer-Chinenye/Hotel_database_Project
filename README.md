# Hotel_database_Project

## Overview
This is a beginner SQL practice project for managing a small hotel.
It shows how to create tables from scratch, insert sample data, and extract meaningful insights using SQL queries.
it includes three tables: 'Hotel_staff', 'Daily_activity', 'Payments'.

## Skills Practiced 
-SQL Table creation ('CREATE TABLE')
-Defining Primary and Foreign Keys
-Data insertion ('INSERT INTO')
-Querying Data (SELECT', 'JOIN', 'GROUP BY' ORDER BY' 'DATEDIFF')
-Using sample data for analysis
-Understanding relational database design.

## Table Creation
''SQL''
--CREATE TABLE HotelStaff
              (
StaffName VARCHAR (50),
StaffId VARCHAR (20) NOT NULL PRIMARY KEY,
Age INT,
Gender VARCHAR (10),
Department VARCHAR (50),
Salary INT 
              );


--CREATE TABLE DailyActivity
            (
StaffId VARCHAR (20) NOT NULL FOREIGN KEY REFERENCES HotelStaff (StaffId),
GuestName VARCHAR (20),
RoomNumber INT,
RoomType VARCHAR (20),
Check_in_datetime DATETIME,
Check_out_datetime DATETIME,
Amountper_room_type INT,
Complaint VARCHAR (50)
              );


--CREATE TABLE Payments
             (
      PaymentId INT NOT NULL PRIMARY KEY,
      StaffId VARCHAR (20) NOT NULL FOREIGN KEY REFERENCES HotelStaff (StaffId),
      GuestName VARCHAR (50),
      RoomNumber INT,
      PaymentMethod VARCHAR (50),
      AmountPerNight DECIMAL (10,2),
      PaymentDate DATETIME,
      PaymentStatus VARCHAR (50)
               );
  --ALTER TABLE Payments
      ADD RoomType VARCHAR (50);
      
  ## Sample Queries
--1.SELECT StaffId, StaffName, Department
FROM  HotelStaff
WHERE StaffId NOT IN (SELECT StaffId FROM DailyActivity);---This Query shows the staff members who were not on duty, as they do not appear in the DailyActivity Table.


--2. SELECT StaffName
FROM HotelStaff AS h
JOIN
    DailyActivity AS d
ON h.StaffId = d.StaffId
WHERE d.StaffId = 'Roomatt02'
AND Complaint = 'Faulty AC';--- Successfully extracted the staff name from the DailyActivity Table based on the guest who reported a faulty AC.


 --3. SELECT TOP 1 Department,
        SUM(Salary) AS Total_salary_by_Department
FROM HotelStaff
GROUP BY Department
ORDER BY Total_salary_by_Department DESC;---Shows Department with the highest total salary.


--4. This query analyzes revenue generated from rooms with recorded complaints.
SELECT d.RoomNumber,
      COUNT(d.Complaint) AS TotalComplaints,
      SUM(p.AmountPerNight) AS RevenueGenerated
FROM DailyActivity AS d
JOIN Payments AS p
ON d.RoomNumber = p.RoomNumber
WHERE d.Complaint IS NOT NULL
AND PaymentStatus = 'Paid'
GROUP BY d.RoomNumber;
ORDER BY Complaints_handled DESC;---Shows which staff handled the most Guest complaints.

