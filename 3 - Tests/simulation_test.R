arrival_rates <- data.frame(
    start_station = c(1, 1, 2),
    end_station   = c(2, 3, 3),
    hour          = c(8, 9, 10),
    mu_hat        = c(0.5, 1.0, 0.3)
  )
  
  simulate_demand(arrival_rates)
