% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/inv_u_trend.R
\name{inv_u_trend}
\alias{inv_u_trend}
\title{Generation of an inverted-u trend}
\usage{
inv_u_trend(j, lambda, N_peak, n_total)
}
\arguments{
\item{j}{Time points for which the trend should be generated.}

\item{lambda}{Strength of time trend.}

\item{N_peak}{Point at which the time trend switches direction in terms of overall sample size.}

\item{n_total}{Total sample size in the trial.}
}
\value{
Time trend for time points j.
}
\description{
This function generates a time trend for given time points in the trial according to an inverted-u function.
}
\details{
The time trend is generated according to the function \eqn{f(j) = \lambda \cdot \frac{j-1}{N-1} (I(j \leq N_p) - I(j > N_p))},
where \eqn{N} is the total sample size (parameter \code{n_total}) and \eqn{N_p} (parameter \code{N_peak}) indicates the point at which the trend switches direction.
}
\author{
Marta Bofill Roig, Pavla Krotka
}
