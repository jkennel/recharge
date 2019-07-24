
check_precip <- function(x, precip_col = 'precip') {

  if (any(diff(x[[precip_col]]) < 0)) {
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
#' @param n number of values in regression
#'
#' @return data.table with labelled 'dry' sections
#'
#' @export
#'
get_segments <- function(x, time_var = 'datetime', n = 48) {

  x[is_dry == FALSE, val := NA_real_]
  x[, slope := roll_lm(as.matrix(datetime), as.matrix(val),
          width = n, intercept = TRUE, min_obs = n)$coefficients[,2]]
  x[, mean_val := roll_mean(as.matrix(val),
                         width = n, min_obs = n)]
  x

}

#' mrc
#'
#' @inheritParams recipes::step_lag
#' @inheritParams harmonic
#'
#' @return data.table with mrc
#' @export
#'
mrc <- function(x,
                time_var = 'datetime',
                precip_var = 'precip',
                n = 48,
                lag = 48,
                cutoff = 0.01) {

  out <- get_dry(x, precip_var, lag, cutoff)
  out <- get_segments(out, time_var, n)
  out
}

# library(data.table)
# library(roll)
# library(recharge)
# fn <- "/media/kennel/Data/tmp/EMR_input.(mNW95sampledata).csv"
# z  <- fread(fn)
# setnames(z, c('datetime', 'val', 'precip'))
#
#
# tmp <- mrc(x=z)
# plot(mean_val~slope, tmp[slope < maxslope],
#      pch = 20)

