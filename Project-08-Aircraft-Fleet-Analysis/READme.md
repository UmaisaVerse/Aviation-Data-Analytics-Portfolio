# Aircraft Fleet Analysis

## Problem
What does the global aircraft fleet look like across airlines and manufacturers?

## Dataset
"Airline Fleets" dataset from Kaggle (by traceyvanp), sourced from Planespotters.net and Wikipedia. 
Snapshot from January 2017 — analysis reflects fleet composition at that time, not current data.

## Tools
Python (pandas, matplotlib) via Google Colab

## Process
1. Loaded and explored the dataset (1,583 rows, 11 columns)
2. Cleaned data by removing rows with missing "Current" fleet values (down to 859 rows)
3. Grouped and aggregated fleet counts by aircraft type, manufacturer, and airline
4. Visualized top aircraft types with a bar chart

## Key Findings
- Boeing 737 is the most common aircraft type globally (5,328 in service), followed by Airbus A320 (3,299)
- Boeing leads overall manufacturer share with 8,773 aircraft vs Airbus's 7,440
- American Airlines operates the largest single fleet (928 aircraft), ahead of Delta (855) and United (730)

## Notes / Learnings
While customizing the chart, tried setting a custom font (Garamond) that isn't installed in Colab's environment matplotlib silently fell back to default and threw repeated "Font family not found" warnings instead of erroring out. Learned that plt.rcParams['font.family'] is a global setting that persists across all charts in the notebook once set, not just the current cell so a leftover value from an earlier cell can cause confusing style issues in later charts. Fixed by resetting to a valid generic family (serif). Takeaway: stick to matplotlib's built-in generic families (serif, sans-serif, monospace) unless a custom font is explicitly installed first.
