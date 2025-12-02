 sample_data <- data.frame(
    start_station = c(1, 2, 3),
    end_station   = c(2, 3, 3)
  )
  
  total_bikes <- 10

opt_placement(sample_data, total_bikes)
