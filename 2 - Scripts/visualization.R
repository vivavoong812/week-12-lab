
visualization <- function(arrival_rates, placement_results) {
  
  # finding demand of bikes for each start station
  bike_demand <- arrival_rates %>%
    select(start_station, end_station, mu_hat) %>%
    filter(!is.na(mu_hat), mu_hat > 0) %>%
    group_by(start_station) %>%
    summarize(demand = sum(mu_hat))
  
  # merge demand data and placement results
  demand_and_placement <- bike_demand %>%
    left_join(placement_results, by = c("start_station" = "station"))
  
  plot <- ggplot(demand_and_placement, aes(x = demand, y = num_bikes)) + geom_point() +
    labs(x = "Expected Demand",
         y = "Number of Bikes",
         title = "Demand vs. Bike Allocation") +
    theme_minimal()
    
}

visualize_results <- visualization(arrival_rates, placement_results)
visualize_results
