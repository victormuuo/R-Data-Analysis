# Load necessary libraries
library(vars)
library(forecast)

# Simulated data for temperature and humidity (replace with your actual data)
set.seed(123)
dates <- seq(as.Date("2022-01-01"), by = "day", length.out = 365)
temperature <- sin(2 * pi * seq(1, 365, by = 1) / 365) * 10 + rnorm(365, mean = 0, sd = 3)
humidity <- -sin(2 * pi * seq(1, 365, by = 1) / 365) * 20 + rnorm(365, mean = 0, sd = 5)
data <- data.frame(Date = dates, Temperature = temperature, Humidity = humidity)

# Plot the data
plot(data$Date, data$Temperature, type = "l", col = "blue", ylab = "Temperature")
lines(data$Date, data$Humidity, type = "l", col = "red", ylab = "Humidity")
legend("topright", legend = c("Temperature", "Humidity"), col = c("blue", "red"), lty = 1)

# Create VAR model using VAR function from vars package
var_model <- VAR(data[, c("Temperature", "Humidity")], p = 2)  # VAR model with lag order 2

# Summary of VAR model
summary(var_model)

# Plot VAR model diagnostics
plot(var_model)

# Forecast future values using VAR model
forecast_var <- forecast(var_model, h = 30)  # Forecasting 30 steps ahead

# Plot forecasted values
plot(forecast_var)
