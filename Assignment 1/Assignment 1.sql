-- Assignment 1, Part 1

-- 1. How many airplanes have listed speeds? What is the minimum listed speed and the maximum listed speed?

SELECT 
COUNT(*) AS 'Airplanes With Listed Speeds'
FROM planes
WHERE speed IS NOT NULL;

SELECT min(speed) AS 'Minimum Listed Speed'
FROM planes;

SELECT max(speed) AS 'Maximum Listed Speed'
FROM planes;

-- 2. What is the total distance flown by all of the planes in January 2013? What is the total distance flow by all of the planes in January 2013 where the tailnum is missing?

SELECT sum(distance) AS 'Total Distance Flown By All Planes in January 2013'
FROM flights
WHERE month = 1 
AND year = 2013;

SELECT sum(distance) AS 'Total Distance Flown By Planes With No Tail Number in January 2013'
FROM flights
WHERE month = 1 
AND year = 2013 
AND NULLIF(tailnum, '') IS NULL;

--  3. What is the total distance flown for all planes on July 5, 2013 grouped by aircraft manufacturer? Write this statement first using and INNER JOIN, then using a LEFT OUTER JOIN. How do your results compare?

SELECT p.manufacturer AS 'Manufacturer', SUM(f.distance) AS 'Total Distance Flown'
FROM planes AS p
INNER JOIN flights AS f
ON p.tailnum = f.tailnum
WHERE f.month = 7
AND f.day = 5
AND f.year = 2013
GROUP BY p.manufacturer
ORDER BY p.manufacturer ASC;

SELECT p.manufacturer AS 'Manufacturer', SUM(f.distance) AS 'Total Distance Flown'
FROM planes AS p
LEFT OUTER JOIN flights AS f
ON p.tailnum = f.tailnum
WHERE f.month = 7
AND f.day = 5
AND f.year = 2013
GROUP BY p.manufacturer
ORDER BY p.manufacturer ASC;

-- In this particular instance, there was no difference between the outputs. If there were manufacturers that were blank, the LEFT OUTER JOIN would still display them.
 
--  4. Write and answer at least one question of your own choosing that joins information from at least three of the tables in the flight database.

-- Display the top 5 destinations with the greatest average arrival delay for Jet Blue flights NY airports for December 2013. 

SELECT  AVG(f.arr_delay) AS 'Average Delay for Jet Blue for December 2013', 
ap.name AS 'Destination'
FROM flights AS f
INNER JOIN airlines AS a
ON a.carrier = f.carrier
INNER JOIN airports AS ap
ON f.dest = ap.faa
WHERE f.month = 12
AND a.carrier = 'B6'
GROUP BY f.month, ap.name
ORDER BY AVG(f.arr_delay) DESC LIMIT 5;

-- Assignment 1, Part 2

-- Display average arrival delay for all destinations from all NYC airports

SELECT f.origin, 
ap.name AS 'Destination',
AVG(IFNULL(arr_delay, 0)) AS 'Average Arrival Delay'
FROM flights AS f
INNER JOIN airports AS ap
ON f.dest = ap.faa
GROUP BY f.origin, ap.name
ORDER BY f.origin;

