# Hotel_database_Project

## Overview
This is a beginner SQL practice project for managing a small hotel.
It shows how to create tables from scratch, insert sample data, and extract meaningful insights using SQL queries.
it includes three tables: 'Hotel_staff', 'Daily_activity', 'Booking'.

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

--CREATE TABLE Bookings
           (
        Bookingid VARCHAR (20) NOT NULL PRIMARY KEY,
        GuestName VARCHAR (50),
        RoomNumber INT,
        StaffId VARCHAR (20) NOT NULL FOREIGN KEY REFERENCES HotelStaff (StaffId),
        Check_in_Datetime DATETIME,
        Check_out_Datetime DATETIME,
        Amount DECIMAL (10,2),
        Status VARCHAR (50)
             );

  ## Sample Queries
--1. SELECT SUM(Amount) AS TotalRevenue
FROM Bookings;---This calculates the total revenue generated from all the bookings.

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

--4. SELECT StaffName, COUNT(Complaint) AS Complaints_handled
FROM HotelStaff AS h
JOIN DailyActivity AS d 
ON h.StaffId = d.StaffId
WHERE Complaint = ' '
GROUP BY StaffName
ORDER BY Complaints_handled DESC;---Shows which staff handled the most Guest complaints.

