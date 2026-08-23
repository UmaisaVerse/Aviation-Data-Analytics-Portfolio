# Airport Traffic Dashboard (Power BI)

## Problem
How does international passenger traffic vary across airports and months? 
This dashboard identifies the busiest US and foreign airports, and highlights 
seasonal travel trends, using real US international air traffic data.

## Tool
Power BI Desktop

## Data Source
U.S. International Air Traffic Data (1990–2020) Kaggle, by Parul Pandey
https://www.kaggle.com/datasets/parulpandey/us-international-air-traffic-data
(Filtered to 2016–2020 for this analysis; dataset not included in repo due to file size download from source above.)

## Findings
- **Busiest US airports:** JFK, LAX, and MIA lead international passenger volume, 
  consistent with their roles as major international gateway hubs.
- **Busiest foreign airports:** LHR (London Heathrow), YYZ (Toronto), and CUN (Cancún) 
  top the list, reflecting strong US-UK and US-North America travel corridors.
- **Seasonality:** Passenger traffic peaks in summer months (June–August) and dips 
  in fall/winter, a clear seasonal travel pattern.
- **Total passenger volume (2016–2020):** ~976M international passengers.

## Process Notes / Debugging
- Original dataset (~52MB, 36 years) was scoped down to a 5-year window (2016–2020) 
  to keep the dashboard focused and performant for a first Power BI project.
- Dropped non-informative columns (constant `type` field, redundant `data_dte`, 
  and unresolved World Area Codes without a lookup table) to keep the model clean.
- Attempted to combine US and foreign airport columns into a single ranked list 
  using Append Queries; hit a cascading Power Query error when deleting an early 
  transformation step. Diagnosed using "Go To Error," determined the fix would 
  require rebuilding several dependent steps, and made the call to scope it out 
  of v1 rather than risk further data corruption — opted for two separate 
  US/Foreign visuals instead, which arguably reads more clearly anyway.

## Files
- `Airport_Traffic_Dashboard.pbix` — full Power BI file
- `Airport_Traffic_Dashboard.pdf` — static export
- `dashboard_preview.png` — screenshot preview
