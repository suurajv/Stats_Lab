# =========================================================
# Experiment 11
# Time Series Analysis - Australian Drug Sales Dataset
# =========================================================

# Import Libraries

import pandas as pd
import matplotlib.pyplot as plt
from statsmodels.tsa.holtwinters import ExponentialSmoothing

# =========================================================
# Load Dataset
# =========================================================

df = pd.read_csv("AustraliaDrugSales.csv", parse_dates=['date'])

df.set_index('date', inplace=True)

df.index.freq = 'MS'

# =========================================================
# Build Forecasting Model
# =========================================================

model = ExponentialSmoothing(
    df['value'],
    trend='add',
    seasonal='add',
    seasonal_periods=12
).fit()

# =========================================================
# Forecast Next 24 Months
# =========================================================

forecast = model.forecast(24)

# =========================================================
# Plot Graph
# =========================================================

plt.plot(df.index, df['value'],
         color='blue',
         label='Observed')

plt.plot(model.fittedvalues.index,
         model.fittedvalues,
         color='red',
         label='Fitted')

plt.plot(forecast.index,
         forecast,
         color='green',
         label='Forecast')

plt.title("Monthly Drug Sales in Australia")
plt.xlabel("Date")
plt.ylabel("Sales")

plt.legend()
plt.show()