-- For each flight, what aircraft model was used?"
SELECT flight_id, flight_no, JSON_UNQUOTE(JSON_EXTRACT(model, '$.en')) AS aircraft_model
FROM flights
INNER JOIN aircrafts_data ON flights.aircraft_code = aircrafts_data.aircraft_code
LIMIT 10

-- How do passenger bookings connect to flight routes and aircraft types?
SELECT flight_id, flight_no, JSON_UNQUOTE(JSON_EXTRACT(model, '$.en')) AS aircraft_model
FROM flights
INNER JOIN aircrafts_data ON flights.aircraft_code = aircrafts_data.aircraft_code
LIMIT 10;

-- Let's find out exactly where everything actually lives — no more guessing.

SELECT table_schema, table_name 
FROM information_schema.tables 
WHERE table_name IN ('flights', 'aircrafts_data', 'ticket_flights', 'bookings', 'tickets')
AND table_schema IN ('school', 'airline_db');

-- How do passenger bookings connect to flight routes and aircraft types?
SELECT flights.flight_id, flights.flight_no, 
       JSON_UNQUOTE(JSON_EXTRACT(model, '$.en')) AS aircraft_model,
       ticket_flights.amount AS fare_amount
FROM flights
INNER JOIN aircrafts_data ON flights.aircraft_code = aircrafts_data.aircraft_code
INNER JOIN ticket_flights ON flights.flight_id = ticket_flights.flight_id
LIMIT 10;

-- What's the total revenue and total ticket count for each flight?

SELECT flights.flight_id, flights.flight_no,
	    JSON_UNQUOTE(JSON_EXTRACT(model, '$.en')) AS aircraft_model,
        COUNT(ticket_flights.amount) AS tickets_sold,
        SUM(ticket_flights.amount) AS total_revenue
FROM flights
INNER JOIN aircrafts_data ON flights.aircraft_code = aircrafts_data.aircraft_code
INNER JOIN ticket_flights ON flights.flight_id = ticket_flights.flight_id
GROUP BY flights.flight_id, flights.flight_no, aircraft_model
LIMIT 10;

-- Rewrite your query to group by route instead of by flight

SELECT departure_airport, arrival_airport,
        COUNT(DISTINCT flights.flight_id) AS num_flights,
        COUNT(ticket_flights.amount) AS tickets_sold,
        SUM(ticket_flights.amount) AS total_revenue
FROM flights
INNER JOIN aircrafts_data ON flights.aircraft_code = aircrafts_data.aircraft_code
INNER JOIN ticket_flights ON flights.flight_id = ticket_flights.flight_id
GROUP BY departure_airport, arrival_airport
LIMIT 10;

-- Most booked routes (add ORDER BY to what you have)
SELECT departure_airport, arrival_airport,
        COUNT(DISTINCT flights.flight_id) AS num_flights,
        COUNT(ticket_flights.amount) AS tickets_sold,
        SUM(ticket_flights.amount) AS total_revenue
FROM flights
INNER JOIN aircrafts_data ON flights.aircraft_code = aircrafts_data.aircraft_code
INNER JOIN ticket_flights ON flights.flight_id = ticket_flights.flight_id
GROUP BY departure_airport, arrival_airport

ORDER BY tickets_sold DESC
LIMIT 10;

-- Revenue per route — same query, just swap the ORDER BY:
SELECT departure_airport, arrival_airport,
        COUNT(DISTINCT flights.flight_id) AS num_flights,
        COUNT(ticket_flights.amount) AS tickets_sold,
        SUM(ticket_flights.amount) AS total_revenue
FROM flights
INNER JOIN aircrafts_data ON flights.aircraft_code = aircrafts_data.aircraft_code
INNER JOIN ticket_flights ON flights.flight_id = ticket_flights.flight_id
GROUP BY departure_airport, arrival_airport
ORDER BY total_revenue DESC
LIMIT 10;

-- Booking patterns by aircraft (separate query — group by aircraft type instead of route):
SELECT JSON_UNQUOTE(JSON_EXTRACT(model, '$.en')) AS aircraft_model,
       COUNT(DISTINCT flights.flight_id) AS num_flights,
       COUNT(ticket_flights.amount) AS tickets_sold,
       SUM(ticket_flights.amount) AS total_revenue
FROM flights
INNER JOIN aircrafts_data ON flights.aircraft_code = aircrafts_data.aircraft_code
INNER JOIN ticket_flights ON flights.flight_id = ticket_flights.flight_id
GROUP BY aircraft_model
ORDER BY tickets_sold DESC;
