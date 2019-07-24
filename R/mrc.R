# This code is based on the code here
# https://wwwrcamnl.wr.usgs.gov/uzf/EMR_Method/EMR.method.html

check_precip <- function(x, precip_var = 'precip') {

  if (any(diff(x[[precip_var]]) < 0)) {
    stop('Precipitation must monotonically increase')
  }

}

#' get_dry
#'
#' @param x data
#' @param precip_col name of precip col
#' @param lag lag
#' @param cutoff cutoff
#'
#' @return data.table with labelled 'dry' sections
#'
#' @importFrom data.table as.data.table data.table
#' @importFrom stats lm
#'
#' @export
#'
get_dry <- function(x,
                    precip_var = 'precip',
                    lag = 96, # 86400*4
                    cutoff = 0.5) { # 0.0

  data.table::setDT(x)

  x[, is_dry := FALSE]

  x[which(diff(get(precip_var), lag = lag) < cutoff) + lag,
    is_dry := TRUE]

  x

}


#' get_segments
#'
#' @param x data
#' @param time_var name of time col
#' @param wl_var name of water level col
#' @param n number of values in regression
#'
#' @return data.table with labelled 'dry' sections
#'
#' @export
#'
get_segments <- function(x,
                         time_var = 'datetime',
                         wl_var = 'wl',
                         n = 48) {

  # remove dry values
  x[, val_use := get(wl_var)]
  x[is_dry == FALSE, val_use := NA_real_]

  # calculate slopes
  x[, slope := roll_lm(as.matrix(datetime), as.matrix(val_use),
          width = n, intercept = TRUE, min_obs = n)$coefficients[,2]]


  x[, mean_val := roll_mean(as.matrix(val_use),
                         width = n, min_obs = n)]
  x

}

#' mrc
#'
#' @inheritParams get_segments
#' @inheritParams get_dry
#'
#' @return data.table with mrc
#' @export
#'
#' @example
#' data(mrc_dat)
#' mrc(x=mrc_dat)
mrc <- function(x,
                time_var = 'datetime',
                precip_var = 'precip',
                wl_var = 'wl',
                n = 48,
                lag = 48,
                cutoff = 0.01) {

  check_precip(x, precip_var)

  out <- get_dry(x, precip_var, lag, cutoff)
  out <- get_segments(out, time_var, wl_var, n)
  out
}


