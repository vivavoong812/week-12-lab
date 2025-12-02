# week-12-lab

Program that takes past demand data to optimize future bike placement.

## Data
data <- read.csv("/path/sample_bike.csv")
## estimation.R
arrival_rates <- estimate_arrival_rates(data)
## simulation.R
sim_trip_one(arrival_rates)
simulation_results <- sim_trips_all(arrival_rates)
## placement.R
placement_results <- opt_placement(arrival_rates, total_bikes)
## visualization.R
visualize_results <- visualization(arrival_rates, placement_results)
