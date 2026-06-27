-- ================================================
-- Project 5: Aviation Delay Analysis
-- Tool: MySQL
-- Dataset: U.S. Flight Delays 2013-2023
-- Analyst: Umaisa
-- ================================================

USE aviation_project;

-- ------------------------------------------------
-- SECTION 1: DATA CLEANING
-- ------------------------------------------------

-- Check for NULL values
SELECT 
    COUNT(*) AS total_rows,
    SUM(CASE WHEN carrier_name IS NULL THEN 1 ELSE 0 END) AS null_carrier,
    SUM(CASE WHEN airport_name IS NULL THEN 1 ELSE 0 END) AS null_airport,
    SUM(CASE WHEN arr_flights IS NULL THEN 1 ELSE 0 END) AS null_arr_flights,
    SUM(CASE WHEN arr_del15 IS NULL THEN 1 ELSE 0 END) AS null_delays
FROM flight_delays;

-- Check for impossible zeros
SELECT COUNT(*) AS suspicious_rows
FROM flight_delays
WHERE arr_flights = 0 OR arr_flights IS NULL;

-- Check for duplicate rows
SELECT year, month, carrier, airport, COUNT(*) AS count
FROM flight_delays
GROUP BY year, month, carrier, airport
HAVING COUNT(*) > 1;

-- Remove duplicates
CREATE TABLE flight_delays_clean AS
SELECT DISTINCT * FROM flight_delays;

-- ------------------------------------------------
-- SECTION 2: ANALYSIS
-- ------------------------------------------------

-- Q1: Which airlines have the most delayed flights?
SELECT 
    carrier_name,
    SUM(arr_del15) AS total_delays
FROM flight_delays
GROUP BY carrier_name
ORDER BY total_delays DESC
LIMIT 10;

-- Q2: What percentage of each airline's flights are delayed?
SELECT 
    carrier_name,
    SUM(arr_flights) AS total_flights,
    SUM(arr_del15) AS total_delays,
    ROUND((SUM(arr_del15) / SUM(arr_flights)) * 100, 2) AS delay_percentage
FROM flight_delays
GROUP BY carrier_name
ORDER BY delay_percentage DESC
LIMIT 10;

-- Q3: What are the most common reasons for delays?
SELECT
    ROUND(SUM(carrier_ct), 0) AS carrier_delays,
    ROUND(SUM(weather_ct), 0) AS weather_delays,
    ROUND(SUM(nas_ct), 0) AS nas_delays,
    ROUND(SUM(security_ct), 0) AS security_delays,
    ROUND(SUM(late_aircraft_ct), 0) AS late_aircraft_delays
FROM flight_delays;

-- Q4: Which airports have the most delays?
SELECT 
    airport_name,
    SUM(arr_del15) AS total_delays,
    ROUND((SUM(arr_del15) / SUM(arr_flights)) * 100, 2) AS delay_percentage
FROM flight_delays
GROUP BY airport_name
ORDER BY total_delays DESC
LIMIT 10;

-- Q5: Which airports have the worst delay rate?
SELECT 
    airport_name,
    SUM(arr_flights) AS total_flights,
    SUM(arr_del15) AS total_delays,
    ROUND((SUM(arr_del15) / SUM(arr_flights)) * 100, 2) AS delay_percentage
FROM flight_delays
GROUP BY airport_name
HAVING SUM(arr_flights) > 10000
ORDER BY delay_percentage DESC
LIMIT 10;

-- Q6: Which airline + airport combination is the worst?
SELECT 
    carrier_name,
    airport_name,
    SUM(arr_flights) AS total_flights,
    SUM(arr_del15) AS total_delays,
    ROUND((SUM(arr_del15) / SUM(arr_flights)) * 100, 2) AS delay_percentage
FROM flight_delays
GROUP BY carrier_name, airport_name
HAVING SUM(arr_flights) > 1000
ORDER BY delay_percentage DESC
LIMIT 10;

-- Q7: Has the delay situation improved over the years?
SELECT 
    year,
    SUM(arr_flights) AS total_flights,
    SUM(arr_del15) AS total_delays,
    ROUND((SUM(arr_del15) / SUM(arr_flights)) * 100, 2) AS delay_percentage
FROM flight_delays
GROUP BY year
ORDER BY year ASC;