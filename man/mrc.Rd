% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/mrc.R
\name{mrc}
\alias{mrc}
\title{mrc}
\usage{
mrc(x, time_var = "datetime", precip_var = "precip", wl_var = "wl",
  n = 48, lag = 48, cutoff = 0.01)
}
\arguments{
\item{x}{data}

\item{time_var}{name of time col}

\item{wl_var}{name of water level col}

\item{n}{number of values in regression}

\item{lag}{lag}

\item{cutoff}{cutoff}
}
\value{
data.table with mrc
}
\description{
mrc
}
