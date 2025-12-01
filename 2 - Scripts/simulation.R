source(estimation.R)

sim_trips <-

simulate_demand <- function(data = arrival_rates, max_time = 24){
  combinations <- arrival_rates %>% distinct(start_station, end_station)
  results <- list()
  lambda_max <- max(arrival_rates$mu_hat, na.rm = TRUE) # lamda_max = 8
  lambdas <- data$mu_hat
  
  for(i in 1:length(combinations)){
    start <- combinations$start_station[i]
    end <- combinations$end_station[i]
    pair <- arrival_rates %>% 
    filter(start_station == start, 
           end_station == end)
    
    current_time <- 0
    arrivals <- c()
    
    while (current_time < max_time) {
      next_arrival <- current_time + rexp(1, rate = lambda_max)
      hour <- floor(next_arrival)
      
      mu <- pair$mu_hat[pair$hour == hour]
      
      if (runif(1) < lambdas[i] / lambda_max) {
        arrivals <- c(arrivals, next_arrival)
      }
      current_time <- next_arrival
    }
    results[[i]] <- data.frame(
      start_station = start, 
      end_station = end, 
      time = arrivals
      )
  }
  return(bind_rows(results)
}

simulate_trips <- function()

set.seed(123)
arrival_results <- simulate_demand(arrival_rates, 24)
print(arrival_results)
