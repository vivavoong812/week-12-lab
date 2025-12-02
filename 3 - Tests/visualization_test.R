test_df <- tibble(
    start_station = c("A", "B", "C", "D"),
    end_station   = c("D", "C", "A", "B"),
    start_time    = as.POSIXct(c("2022-04-05 09:45:00",
                                 "2022-04-10 10:45:00",
                                 "2022-04-15 11:45:00",
                                 "2022-04-23 08:59:00")),
    end_time      = as.POSIXct(c("2022-04-05 11:45:00",
                                 "2022-04-10 12:45:00",
                                 "2022-04-15 12:45:00",
                                 "2022-04-23 10:59:00")),
    user_type     = c("Subscriber", NA, NA, "Subscriber")
  )

arrival_rates <- estimate_arrival_rates(test_df)

sample_data <- data.frame(
    start_station = c(1, 2, 3),
    end_station   = c(2, 3, 3)
  )
  
  total_bikes <- 10

placement_results <- opt_placement(sample_data, total_bikes)


visualization (arrival_rates, placement_results) 
