# Project 7: Fuel Cost Tracker ✈️

**Tool:** Excel 2016
**Dataset:** Semi-synthetic — 240 flight records (5 routes × 4 aircraft types × 6 months, Jan–Jun 2026), built using real-world aircraft fuel burn benchmarks

## Business Question

How does fuel consumption and cost vary across aircraft types and routes?

## Key Findings

- Doha→Washington DC accounts for ~76% of total fuel spend, driven by its 15-hour duration and use of the Airbus A380
- Airbus A320 is the most fuel-efficient aircraft at ~2,490 L/hour
- Airbus A380 is the least fuel-efficient at ~17,350 L/hour — nearly 7x the A320's burn rate, though it likely carries far more passengers over longer distances
- Fuel spend rose steadily from $1.88M (Jan) to $2.49M (Jun) — a 32% increase, tracking the modeled rise in fuel price per liter ($0.70 → $0.90) over the same period
- Karachi→Islamabad and Karachi→Lahore show nearly identical fuel costs (~$195K each), consistent with both using similar narrow-body aircraft over similar durations

## Skills Used

- VLOOKUP with locked (absolute) reference ranges
- Nested lookup logic using MONTH() to resolve a date-vs-text mismatch
- RANDBETWEEN for realistic randomized data generation
- Text-to-decimal time conversion using LEFT/MID/FIND
- Pivot Tables and PivotCharts for route, aircraft, and time-based analysis
- Semi-synthetic dataset design anchored to real-world benchmarks

## Data Sources

- Aircraft fuel burn rates: Google AI Overview, cross-checked against Simple Flying
- Jet fuel price range ($0.70–$0.95/L): general industry range, used as a realistic anchor for the modeled monthly price table

## Notes

Built entirely in Excel 2016 (no XLOOKUP/IFS available). Real bugs encountered and fixed during development: unlocked VLOOKUP ranges causing #N/A errors, and a date-vs-text mismatch in a month-based lookup — both documented as part of the analytical process, not omitted.
