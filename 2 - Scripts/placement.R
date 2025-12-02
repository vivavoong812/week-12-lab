#' Optimizing bike placement at start stations
#'
#' @description A function that calculates the number of unhappy customers for each start station and adds one bike to the start station
#' with the highest number of unhappy customers until there are no bikes left to allocate
#'
#' @param arrival_rates A data frame with the columns: start_station, end_station, hour, and mu_hat
#'        total_bikes The total number of bikes to allocate
#'
#' @return A data frame with the columns: start_station, end_station, num_bikes

opt_placement <- function(arrival_rates, total_bikes) {
  
  # finding demand of bikes for each start station
  bike_demand <- arrival_rates %>%
    select(start_station, end_station, mu_hat) %>%
    filter(!is.na(mu_hat), mu_hat > 0) %>%
    group_by(start_station) %>%
    summarize(demand = sum(mu_hat))
  
  # setting all bikes to 0 for each start station
  orig_station <- bike_demand$start_station
  allocation <- rep(0, length(orig_station))
  names(allocation) <- orig_station
  
  # set total bikes
  bikes_left <- total_bikes
  
  # adding bike to "unhappy" station
  while (bikes_left > 0) {
    
    # finding number of unhappy customers
    unhappy <- pmax(bike_demand$demand - allocation, 0)
    
    # finding station with max unhappy customers
    unhappy_index <- which.max(unhappy)
    add_to_station <- orig_station[unhappy_index]
    
    # adding bike to that station
    allocation[add_to_station] <- allocation[add_to_station] + 1
    
    # updating bikes left
    bikes_left <- bikes_left - 1
    
    # placement results in data frame format
    placement <- data.frame(station = orig_station,
                            num_bikes = as.integer(allocation))
  }
  return(placement)
}

total_bikes <- 1000
placement_results <- opt_placement(arrival_rates, total_bikes)
placement_results
