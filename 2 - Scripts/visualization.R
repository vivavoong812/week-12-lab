#' Visualizing the expected bike demand and bike allocation
#'
#' @description A function that creates a scatterplot of the expected bike demand and the final bike allocation
#'
#' @param arrival_rates A data frame with the columns: start_station, end_station, hour, and mu_hat
#'        placement_results A data frme with the columns: start_station and num_bikes
#'
#' @return A scatterplot with expected demand on the x-axis and number of bike allocated on the y-axis

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
