% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/mrc.R
\name{get_dry}
\alias{get_dry}
\title{get_dry}
\usage{
get_dry(x, precip_var = "precip", lag = 96, cutoff = 0.5)
}
\arguments{
\item{x}{data}

\item{lag}{lag}

\item{cutoff}{cutoff}

\item{precip_col}{name of precip col}
}
\value{
data.table with labelled 'dry' sections
}
\description{
get_dry
}
