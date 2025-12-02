#' Simulating one day of trips for a single pair of start and end stations
#'
#' @description A function simulates arrival times for a single pair of start an end stations using non-homogeneous Poisson
#'
#' @param arrival rates A data frame with the columns: start_station, end_station, hour, and mu_hat
#'
#' @return a data frame with the columns: start_station, end_station, and time

sim_trip_one <- function(arrival_rates) {

  # keeping relevant columns
  arrival_rates <- arrival_rates %>%
    select(start_station, end_station, hour, mu_hat) %>%
    filter(!is.na(mu_hat), mu_hat > 0)

  # in case pair has no positive rate
  if (nrow(arrival_rates) == 0) return(NULL)

  # finding lambda max
  lambda_max <- max(arrival_rates$mu_hat, na.rm = TRUE) # lamda_max = 8

  time <- 0
  arrivals <- c()

  # simulate arrivals over 24 hours
  while (current_time < 24) {
    rate <- rexp(1,1 rate = lambda_max)
    time <- time + 1
    if (time >= 24) break

    # finding current hour
    current_hour <- floor(time)

    # finding actual lambda for associated hour
    lambda <- arrival_rates %>%
      filter(hour == current_hour) %>%
      pull(mu_hat)

    # if there is no rate, go to next iteration
    if (length(lambda) == 0 || is.na(lambda[1])) next
    lambda <- lambda[1]

    # thinning
    if (runif(1) < lambdas / lambda_max) {
        arrivals <- c(arrivals, time)
    }
  }
  
  # in case of no arrivals
  if (length(arrivals == 0) return(NULL)

  # results in data frame
  arrival_results <- data.frame(start_station = arrival_rates$start_station[1],
                     end_station = end_rates$start_station[1],
                     time = arrivals)
}

#' Simulating one day of trips for all station trips
#'
#' @description A function takes the sim_trip_one function and applies it to all pairs of start and end station
#'
#' @param arrival_rate A data frame with the columns: start_station, end_station, hour, and mu_hat
#'
#' @return A data frame with columns: start_station, end_station, and time (arrival_times)

sim_trips_all <- function(arrival_rates) {
  set.seed(123)
  
  pairs <- arrival_rates %>%
    group_by(start_station, end_station) %>%
    group_split()
  
  trips_list <- lapply(pairs, sim_trip_one)
  bind_rows(trips_list)
}

