CREATE DATABASE NenyeHotels;
USE NenyeHotels;

CREATE TABLE HotelStaff
              (
StaffName VARCHAR (50),
StaffId VARCHAR (20) NOT NULL PRIMARY KEY,
Age INT,
Gender VARCHAR (10),
Department VARCHAR (50),
Salary INT 
              );

INSERT INTO HotelStaff VALUES
   ('Samuel', 'Clean01', 20,'Male', 'Cleaner', 70000),
   ('Flora', 'Chef01', 25, 'Female', 'Cook', 200000),
   ('Jide', 'Chef02', 29, 'Male', 'Cook', 100000),
   ('Sarah', 'Roomatt01', 25, 'Female', 'Room-attendant', 50000),
   ('Paul', 'Roomatt02', 28, 'Male', 'Room-attendant', 50000),
   ('Okon', 'Cso01', 30, 'Male', 'Security', 100000);

INSERT INTO HotelStaff VALUES
   ('Praise', 'Roomatt03', 26, 'Female',  'Room-attendant', 50000);

SELECT *
FROM HotelStaff;

CREATE TABLE DailyActivity
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

INSERT INTO DailyActivity VALUES
       ('Roomatt01', 'Ude', 222, 'Luxury', '2025-01-20 7:00:00', '2025-01-21 7:00:00', 120000, ' '),
       ('Roomatt02', 'Destiny', 444, 'Deluxe', '2025-01-22 3:00:00', '2025-01-23 2:00:00', 100000, 'Faulty AC'),
       ('Roomatt01', 'Naomi', 201, 'Presidential', '2025-01-23 12:00:00', '2025-01-24 8:00:00', 150000, 'Dirty Sheets');

INSERT INTO DailyActivity VALUES
       ('Roomatt03', 'Sunday', 301, 'Luxury', '2025-01-25 10:00:00', '2025-01-25 10:00:00', 120000, ' ');


CREATE TABLE Bookings
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

INSERT INTO Bookings VALUES
   ('B001', 'Ude', 222, 'Roomatt01', '2025-01-20 07:00:00', '2025-01-21 07:00:00', 120000.00, 'Completed'),
   ('B002', 'Destiny', 444, 'Roomatt02', '2025-01-22 02:00:00', '2025-01-23 03:00:00', 100000.00, 'Completed'),
   ('B003', 'Naomi', 201, 'Roomatt01', '2025-01-23 12:00:00', '2025-01-24 08:00:00', 150000.00, 'Completed'),
   ('B004', 'Sunday', 301, 'Roomatt03', '2025-01-25 10:00:00', '2025-01-25 10:00:00', 120000.00, 'Cancelled'),
   ('B005', 'Alice', 310, 'Roomatt03', '2025-02-14 09:00:00', '2025-02-15 10:00:00', 100000.00, 'Confirmed'),
   ('B006', 'John', 715, 'Roomatt02', '2025-02-25 02:00:00', '2025-02-26 03:00:00', 120000.00, 'Cancelled'),
   ('B007', 'Martin', 110, 'Roomatt01', '2025-12-07 14:00:00', '2025-12-09 12:00:00', 300000.00, 'Comfirmed');

   ALTER TABLE Bookings
   ADD Roomtype VARCHAR (50);
    
UPDATE Bookings
SET 
    Roomtype = CASE
    WHEN Bookingid = 'B001' THEN 'Luxury'
    WHEN Bookingid = 'B002' THEN 'Deluxe'
    WHEN Bookingid = 'B003' THEN 'Presidential'
    WHEN Bookingid = 'B004' THEN 'Luxury'
    WHEN Bookingid = 'B005' THEN 'Deluxe'
    WHEN Bookingid = 'B006' THEN 'Luxury'
    WHEN Bookingid = 'B007' THEN 'Deluxe'
 ELSE 'No Room'
 END;


SELECT *
FROM HotelStaff;
SELECT *
FROM DailyActivity;
SELECT *
FROM Bookings;

SELECT *
FROM HotelStaff AS H
FULL OUTER JOIN 
        DailyActivity AS D
ON H.StaffId = D.StaffId;

SELECT *
FROM HotelStaff AS H
LEFT JOIN 
        DailyActivity AS D
ON H.StaffId = D.StaffId;

SELECT *
FROM HotelStaff AS H
RIGHT JOIN 
        DailyActivity AS D
ON H.StaffId = D.StaffId;

SELECT *
FROM HotelStaff AS H
INNER JOIN 
        DailyActivity AS D
ON H.StaffId = D.StaffId;

SELECT StaffName
FROM HotelStaff AS h
JOIN
    DailyActivity AS d
ON h.StaffId = d.StaffId
WHERE d.StaffId = 'Roomatt02'
AND Complaint = 'Faulty AC';--- Successfully extracted the staff name from the DailyActivity Table based on the guest who reported a faulty AC.


SELECT StaffId, StaffName, Department
FROM  HotelStaff
WHERE StaffId NOT IN (SELECT StaffId FROM DailyActivity);---This Query shows the staff members who were not on duty, as they do not appear in the DailyActivity Table.


SELECT COUNT (DISTINCT Roomtype) AS Number_of_room_types
FROM DailyActivity;---Shows the total number of unique room types.


SELECT 
       DATENAME (MONTH, Check_in_datetime) AS Check_in_MonthName,
       DATENAME (MONTH, Check_out_datetime) AS Check_out_MonthName
FROM DailyActivity;--Shows the month for each check_in and for each check_out.


 SELECT TOP 1 Department,
        SUM(Salary) AS Total_salary_by_Department
FROM HotelStaff
GROUP BY Department
ORDER BY Total_salary_by_Department DESC;---Shows Department with the highest total salary.


SELECT RoomNumber, RoomType
FROM DailyActivity
WHERE Complaint = ' ';---Extracts all Rooms without any recorded complaint.


SELECT DISTINCT StaffName, Salary
FROM HotelStaff AS h
JOIN DailyActivity AS d
    ON h.StaffId = d.StaffId;---Shows the names of staff who were on duty along with their Salary.

SELECT StaffName 
FROM HotelStaff AS h
LEFT JOIN DailyActivity AS d
ON h.StaffId = d.StaffId
WHERE d.StaffId IS NULL;---Lists staff who were not on duty.


SELECT StaffName, COUNT(Complaint) AS Complaints_handled
FROM HotelStaff AS h
JOIN DailyActivity AS d 
ON h.StaffId = d.StaffId
WHERE Complaint = ' '
GROUP BY StaffName
ORDER BY Complaints_handled DESC;---Shows which staff handled the most Guest complaints.


SELECT Roomtype, 
       SUM(Amount) AS Total_Revenue
FROM Bookings
GROUP BY Roomtype
ORDER BY Total_Revenue DESC;---Shows the room type that brings the highest revenue.


SELECT GuestName, RoomNumber,
      DATEDIFF(day, Check_in_Datetime, Check_out_Datetime) AS DaysStayed
FROM Bookings
WHERE DATEDIFF(day, Check_in_Datetime, Check_out_Datetime) > 1;---Extracts Guests whose stay was longer than one day.

SELECT Status, COUNT(*) AS TotalBookings
FROM Bookings
GROUP BY Status
ORDER BY TotalBookings DESC;---This shows the total number of bookings grouped by their status.


SELECT SUM(Amount) AS TotalRevenue
FROM Bookings;---This calculates the total revenue generated from all the bookings.