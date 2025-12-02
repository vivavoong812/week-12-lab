# week-12-lab

Program that takes past demand data to optimize future bike placement.

## Data
data <- read.csv("/path/sample_bike.csv")
## estimation.R
arrival_rates <- estimate_arrival_rates(data)

A function that takes in past demand data to estimate the arrival rates for each pair of start and end stations
## simulation.R
sim_trip_one(arrival_rates)

A function simulates arrival times for a single pair of start an end stations using non-homogeneous Poisson

simulation_results <- sim_trips_all(arrival_rates)

A function takes the sim_trip_one function and applies it to all pairs of start and end station

## placement.R
placement_results <- opt_placement(arrival_rates, total_bikes)

A function that calculates the number of unhappy customers for each start station and adds one bike to the start station with the highest number of unhappy customers until there are no bikes left to allocate
## visualization.R
visualize_results <- visualization(arrival_rates, placement_results)

A function that creates a scatterplot of the expected bike demand and the final bike allocation
