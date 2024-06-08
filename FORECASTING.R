library(MASS)

# Simulated data (replace with your actual data)
set.seed(123)
year <- 2001:2022
counts <- c(240,302,327,457,586,697,796,962,1073,1268,1471,1704,2233,2813,3115,3276,3158,3518,3581,3833,4103,3872)
counts
# Initial parameter values
mu <- 207.079
mu
alpha <- 0.836
m <- 1000
Sn <- matrix(NA, nrow = m, ncol = 2)
# 2 columns for mu and alpha
# Helper function to calculate the log-likelihood of the model
log_likelihood <- function(mu, alpha, counts) {
  lambda <- mu + alpha * c(0, counts[-length(counts)])
  sum(dpois(counts, lambda, log = TRUE))
}
log_likelihood(mu,alpha,counts)
# Define proposal distribution for alpha
proposal_alpha <- function(alpha, sigma) {
  rnorm(1, alpha, sigma)
}
proposal_alpha(alpha,sigma)
# Set initial values and tuning parameters
alpha_current <- alpha
sigma_alpha <- 0.1

for (i in 1:m) {
  # Sample u ~ Uniform(0, 1)
  u <- runif(1)
  
  # Sample alpha using ARMS
  alpha_proposed <- proposal_alpha(alpha_current, sigma_alpha)
  log_ratio <- log_likelihood(mu, alpha_proposed, counts) - log_likelihood(mu, alpha_current, counts)
  
  if (log(u) < log_ratio) {
    alpha_current <- alpha_proposed
  }
  
  # Store parameter values
  Sn[i, ] <- c(mu, alpha_current)
}

future_years <- 2024:2028 # Example future years
future_years
forecasts <- matrix(NA, nrow = length(future_years), ncol = 2)  # Store forecasts
colnames(forecasts) <- c("Year", "Forecasted Count")

for (j in 1:length(future_years)) {
  lambda_forecast <- Sn[, 1] + Sn[, 2] * counts[length(counts)]  # Forecasted lambda using last observed count
  forecasts[j, ] <- c(future_years[j], rpois(1, lambda_forecast[length(lambda_forecast)]))
}
print(forecasts)

accuracy(forecasts)
