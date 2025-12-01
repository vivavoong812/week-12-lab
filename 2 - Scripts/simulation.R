source(estimation.R)

arrival_rates$start_station <- as.numeric(arrival_rates$start_station)
arrival_rates$end_station   <- as.numeric(arrival_rates$end_station)

simulate_demand <- function(data = arrival_rates, max_time = 24){
  combinations <- arrival_rates %>% distinct(start_station, end_station)
  results <- list()
  lambda_max <- max(arrival_rates$mu_hat, na.rm = TRUE) # lamda_max = 8
  lambdas <- data$mu_hat
  
  for(i in 1:nrow(combinations)){
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

      if (hour >= max_time) break
      
      mu <- pair$mu_hat[pair$hour == hour]
      if (length(mu) == 0) break
      
      if (runif(1) < lambdas[i] / lambda_max) {
        arrivals <- c(arrivals, next_arrival)
      }
      current_time <- next_arrival
    }
    if (length(arrivals) == 0) {
      results[[i]] <- data.frame(
        start_station = numeric(0),
        end_station   = numeric(0),
        time          = numeric(0)
      )
      next
    }
    results[[i]] <- data.frame(
      start_station = as.numeric(start), 
      end_station = as.numeric(end), 
      time = as.numeric(arrivals)
      )
  }
  return(bind_rows(results))
}

set.seed(123)
arrival_results <- simulate_demand(arrival_rates, 24)
print(arrival_results)


sim_trips_all <- function(arrival_rates) {
  set.seed(123)
  
  pairs <- arrival_rates %>%
    group_by(start_station, end_station) %>%
    group_split()
  
  trips_list <- lapply(pairs, sim_trip_one)
  bind_rows(trips_list)
}

