-- Tables for combinations
CREATE TABLE Pastries (PastryName VARCHAR(50));
CREATE TABLE Toppings (ToppingName VARCHAR(50));

INSERT INTO Pastries VALUES ('Croissant'), ('Muffin'), ('Donut');
INSERT INTO Toppings VALUES ('Chocolate'), ('Glaze'), ('Sprinkles'), ('Caramel');

-- Tables for business logic
CREATE TABLE Baristas (Name VARCHAR(50), HourlyRate DECIMAL(10,2));
CREATE TABLE Shifts (ShiftType VARCHAR(20), Income DECIMAL(10,2));

INSERT INTO Baristas VALUES ('Alice', 18.00), ('Bob', 22.00), ('Charlie', 15.00), ('Diana', 25.00);
INSERT INTO Shifts VALUES ('Morning', 95.00), ('Afternoon', 85.00), ('Evening', 70.00);


-- Generate a Menu: Write a CROSS JOIN between Pastries and Toppings to show all 12 possible dessert combinations
SELECT * FROM pastries CROSS JOIN Toppings;

-- Roster Capacity: Count how many rows result from Baristas CROSS JOIN Shifts (to see the total number of possible assignments)
SELECT COUNT(*) AS total_number_of_possible_assignments FROM baristas CROSS JOIN shifts;

-- Premium Staffing: List only the barista/shift combinations where the Barista.HourlyRate > 20.00 (adding a WHERE clause to your CROSS JOIN)
SELECT * FROM Baristas b CROSS JOIN Shifts s
WHERE b.HourlyRate > 20;

-- Concept Check: Explain the difference between CROSS JOIN and INNER JOIN — when does a CROSS JOIN produce the exact same result as an INNER JOIN?
SELECT s.ShiftType, s.Income, SUM(b.HourlyRate) AS cost FROM Baristas b CROSS JOIN Shifts s
GROUP BY s.ShiftType
HAVING cost < s.Income;
