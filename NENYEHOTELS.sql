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




CREATE TABLE Payments
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
ALTER TABLE Payments
ADD RoomType VARCHAR (50);


INSERT INTO Payments VALUES
     (101, 'Roomatt03', 'John', 205, 'Card', 100000.00, '2025-12-15 15:00:00', 'Paid', 'Deluxe'),
     (102, 'Roomatt02', 'Destiny', 444, 'Transfer', 100000.00, '2025-01-21 09:20:00', 'Paid', 'Deluxe'),
     (103, 'Roomatt01', 'Ude', 222, 'Card', 120000.00, '2025-01-20 07:00:00', 'Paid', 'Luxury'),
     (104, 'Roomatt02', 'Grace', 108, 'Transfer', 150000.00, '2025-12-17 11:00:00', 'Paid', 'Presidential'),
     (105, 'Roomatt03', 'Mary', 220, 'Transfer', 100000.00, '2025-12-18 09:45:00', 'Pending', 'Deluxe'),
     (106, 'Roomatt01', 'Naomi', 201, 'Card', 150000.00, '2025-01-23 12:00:00', 'Paid', 'Presidential'),
     (107, 'Roomatt03', 'Sunday', 301, 'Card', 120000.00, '2025-01-25 10:00:00', 'Paid', 'Luxury');

 


SELECT *
FROM HotelStaff;
SELECT *
FROM DailyActivity;
SELECT *
FROM Payments;

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



--- This query calculates the total revenue generated from all completed payments.
SELECT SUM(AmountPerNight) AS TotalRevenue
FROM Payments
WHERE PaymentStatus = 'Paid';



---This query joins staff and payment tables to show the staff names and the revenue they collected.
SELECT StaffName, Department , SUM(AmountPerNight) AS TotalRevenue
FROM HotelStaff AS s
JOIN Payments AS p
ON s.StaffId = p.StaffId
WHERE PaymentStatus = 'Paid'
GROUP BY StaffName, Department
ORDER BY TotalRevenue DESC;



---This query displays rooms managed by staff and the total revenue generated per room.
SELECT s.StaffName, d.RoomNumber, SUM(AmountPerNight) AS TotalRevenue
FROM HotelStaff AS s
JOIN DailyActivity AS d
ON s.StaffId = d.StaffId
JOIN Payments AS p
ON d.RoomNumber = p.RoomNumber
GROUP BY s.StaffName, d.RoomNumber
ORDER BY TotalRevenue DESC;



---This query analyzes revenue generated from rooms with recorded complaints.
SELECT d.RoomNumber,
      COUNT(d.Complaint) AS TotalComplaints,
      SUM(p.AmountPerNight) AS RevenueGenerated
FROM DailyActivity AS d
JOIN Payments AS p
ON d.RoomNumber = p.RoomNumber
WHERE d.Complaint IS NOT NULL
AND PaymentStatus = 'Paid'
GROUP BY d.RoomNumber;
