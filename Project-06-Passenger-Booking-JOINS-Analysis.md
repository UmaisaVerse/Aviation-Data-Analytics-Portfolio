# Project 6: Passenger Bookings JOIN Analysis

**Tool:** MySQL | **Dataset:** Kaggle — saadharoon27/airlines-dataset (travel.sqlite)

## Problem Statement
How do passenger bookings connect to flight routes and aircraft types?

## Approach
- Migrated an 8-table SQLite airline database into MySQL (handling encoding issues, 
  timezone-suffixed timestamps, and JSON-formatted aircraft model data along the way)
- Built a 5-table JOIN chain: `bookings → tickets → ticket_flights → flights → aircrafts_data`
- Used `INNER JOIN` to connect tables, `GROUP BY` + `COUNT`/`SUM` to aggregate 
  ticket-level data back up to route-level and aircraft-level insights
- Extracted clean aircraft names from JSON-formatted data using `JSON_EXTRACT`

## Key Findings

**Most Booked Route**
- SVO → LED: 16,461 tickets sold across 176 flights (revenue: 131,901,600.00)

**Highest Revenue Route**
- DME → KHV: 753,478,300.00 total revenue from 9,647 tickets across 61 flights

**Top-Performing Aircraft (by bookings)**
- Sukhoi Superjet-100: 365,698 tickets sold across 6,931 flights, generating 
  5,114,484,700.00 in total revenue — the most-used aircraft type in the fleet by a wide margin

## Files in This Repo
- `project6_queries.sql` — all SQL queries used (table creation, data loading, JOINs, aggregations)
- `most_booked_routes.csv` — top routes by ticket volume
- `revenue_per_route.csv` — top routes by revenue
- `bookings_by_aircraft.csv` — booking patterns broken down by aircraft type

## Skills Demonstrated
- Multi-table JOINs (5-table chain)
- Data cleaning: encoding fixes, timezone-aware timestamp parsing, JSON extraction
- Aggregation (GROUP BY, COUNT, SUM) at multiple levels of granularity (flight → route → aircraft)
- Debugging real-world import errors (schema mismatches, duplicate loads, ambiguous columns)
