source(estimation.R)

sim_trips <-

combinations <- crossing(arrival_rates$start_station, arrival_rates$end_station)
simulate_demand <- function(data = arrival_rates, max_time = 24){
  lambda_max <- max(arrival_rates$mu_hat, na.rm = TRUE) # lamda_max = 8
  lambdas <- data$mu_hat
  for(i in 1:length(combinations)){
    current_time <- 0
    arrivals <- c()
    while (current_time < 24) {
      next_arrival <- current_time + rexp(1, rate = lambda_max)
      if (runif(1) < lambdas[i] / lambda_max) {
        arrivals <- c(arrivals, next_arrival)
      }
      current_time <- next_arrival
    }
    # currently only returns arrivals for one set of start and end station, need to insert line here to get arrivals for all combinations
  }
  return(arrivals)
}

simulate_trips <- function()

set.seed(123)
arrival_results <- simulate_demand(arrival_rates, 24)
print(arrival_results)
