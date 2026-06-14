# Program 11 - Time Series Analysis of Australian Drug Sales

import pandas as pd
import matplotlib.pyplot as plt
from statsmodels.tsa.holtwinters import ExponentialSmoothing

# Load dataset
df = pd.read_csv("AusAntidiabeticDrug.csv")

# Convert date column to datetime
df['date'] = pd.to_datetime(df['date'])

# Set date as index
df.set_index('date', inplace=True)

# Time Series Model
model = ExponentialSmoothing(
    df['value'],
    trend='add',
    seasonal='add',
    seasonal_periods=12
).fit()

# Forecast next 24 months
forecast = model.forecast(24)

# Plot
plt.figure(figsize=(12,6))

plt.plot(df.index,
         df['value'],
         label='Actual Sales')

plt.plot(model.fittedvalues.index,
         model.fittedvalues,
         label='Fitted Values')

future_dates = pd.date_range(
    start=df.index[-1] + pd.DateOffset(months=1),
    periods=24,
    freq='MS'
)

plt.plot(future_dates,
         forecast,
         label='Forecast')

plt.title("Australian Drug Sales Forecast")
plt.xlabel("Date")
plt.ylabel("Sales")
plt.legend()
plt.grid(True)

plt.show()