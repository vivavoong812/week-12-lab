

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

    if (length(lambda) == 0 || is.na(lambda[1])) next
    lambda <- lambda[1]

    # thinning
    if (runif(1) < lambdas / lambda_max) {
        arrivals <- c(arrivals, time)
    }
  }
  # in case of no arrivals
  if (length(arrivals == 0) return(NULL)

  data.frame(start_station = arrival_rates$start_station[1],
             end_station = end_rates$start_station[1],
             time = arrivals)
}

sim_trips_all <- function(arrival_rates) {
  set.seed(123)
  
  pairs <- arrival_rates %>%
    group_by(start_station, end_station) %>%
    group_split()
  
  trips_list <- lapply(pairs, sim_trip_one)
  bind_rows(trips_list)
}

