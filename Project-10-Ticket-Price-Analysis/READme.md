# ✈️ Ticket Price Analysis

**Problem:** How do flight ticket prices vary by route, number of stops, booking time, airline, and class (Economy vs Business)?

**Tool:** Python (pandas, matplotlib) in Google Colab

**Dataset:** [Flight Price Prediction](https://www.kaggle.com/datasets/shubhambathwal/flight-price-prediction) by Shubham Bathwal (Kaggle). Combined two files from this dataset:
- `Clean_Dataset.csv` (91,554 rows, Economy class, domestic India flights)
- `business.csv` (93,487 rows, Business class, domestic India flights)

Final merged dataset: **185,041 rows**

---

## Key Findings

### 1. Stops matter more than distance
Initial hypothesis was that price differences between routes come down to distance. That turned out to be wrong, longer routes didn't always cost more. What actually drove price was the **number of stops**:

| Stops | Avg Price (INR) |
|---|---|
| Direct (zero) | 4,116 |
| One stop | 6,629 |
| Two or more | 8,960 |

Flying direct is more than **2x cheaper** than flying with 2+ stops.

![Price by Stops](price_by_stops.png)

### 2. Book ~47 days ahead to get the best price
There's a moderate-to-strong negative correlation (**-0.57**) between days left before departure and price.

- Booking 1 day before departure: ~₹14,032 average
- Booking ~47 days before departure: ~₹4,507 average (cheapest window)

That's roughly a **3x price difference** between last-minute and well-planned bookings.

![Price by Days Left](price_by_days_left.png)

*Note: this analysis only covers Economy-class flights, since the Business-class file didn't include a bookable "days left" figure (only the flight date, not the booking date).*

### 3. Airline choice makes a real difference
Among Economy-only flights:
- Most expensive: **Vistara** (₹7,303 avg)
- Cheapest: **AirAsia** (₹4,401 avg)

Checked this wasn't just a class mix issue (i.e. Vistara secretly selling more Business tickets) - it wasn't, since this file only contained Economy fares across all airlines.

### 4. Business class costs ~8.3x more than Economy
- Economy average: ₹6,354
- Business average: ₹52,540

![Price by Class](price_by_class.png)

---

## Data Cleaning Challenges (and how they were solved)

Real datasets rarely come ready to use. Here's what needed fixing:

- **One corrupted row** in the Economy file (a formatting glitch left most fields blank), dropped after inspecting it.
- **Mismatched columns** between the two files (`from`/`to` vs `source_city`/`destination_city`, `time_taken` vs `duration`, etc.), had to be renamed and reformatted to align before merging.
- **Messy `stops` text** in the Business file like `"1-stop\n\t\t\tVia IDR"`, cleaned down to a simple `one` / `zero` / `two_or_more` format.
- **Duration stored as text** (`"02h 15m"`) in the Business file, converted to decimal hours (2.25).
- **Prices stored as comma-formatted text** (`"25,612"`) in the Business file, which silently broke `.mean()` after merging, caught via a `TypeError` and fixed by stripping commas and converting to float.
- **No shared "days_left" or booking-date field** in the Business file, acknowledged as a genuine data limitation rather than faked or estimated.

## Limitations

- No true "seasonal" analysis was possible; the Economy file had no calendar dates at all, only "days left" until departure.
- The Business file only had flight dates, not booking dates, so no `days_left` could be calculated for it.
- Both files are a single historical snapshot of domestic India flights, findings may not generalize to other markets or time periods.

## Tools Used
- Python (pandas, numpy, matplotlib)
- Google Colab
