% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/splines_cal_cont.R
\name{splines_cal_cont}
\alias{splines_cal_cont}
\title{Spline regression analysis for continuous data with knots placed according to calendar time units}
\usage{
splines_cal_cont(
  data,
  arm,
  alpha = 0.025,
  unit_size = 25,
  ncc = TRUE,
  bs_degree = 3,
  check = TRUE,
  ...
)
}
\arguments{
\item{data}{Data frame with trial data, e.g. result from the \code{datasim_cont()} function. Must contain columns named 'treatment', 'response' and 'j'.}

\item{arm}{Integer. Index of the treatment arm under study to perform inference on (vector of length 1). This arm is compared to the control group.}

\item{alpha}{Double. Significance level (one-sided). Default=0.025.}

\item{unit_size}{Integer. Number of patients per calendar time unit. Default=25.}

\item{ncc}{Logical. Indicates whether to include non-concurrent data into the analysis. Default=TRUE.}

\item{bs_degree}{Integer. Degree of the polynomial spline. Default=3 for cubic spline.}

\item{check}{Logical. Indicates whether the input parameters should be checked by the function. Default=TRUE, unless the function is called by a simulation function, where the default is FALSE.}

\item{...}{Further arguments passed by wrapper functions when running simulations.}
}
\value{
List containing the following elements regarding the results of comparing \code{arm} to control:
\itemize{
\item \code{p-val} - p-value (one-sided)
\item \code{treat_effect} - estimated treatment effect in terms of the difference in means
\item \code{lower_ci} - lower limit of the (1-2*\code{alpha})*100\% confidence interval
\item \code{upper_ci} - upper limit of the (1-2*\code{alpha})*100\% confidence interval
\item \code{reject_h0} - indicator of whether the null hypothesis was rejected or not (\code{p_val} < \code{alpha})
\item \code{knots} - positions of the knots in terms of patient index
\item \code{model} - fitted model
}
}
\description{
This function performs linear regression taking into account all trial data until the arm under study leaves the trial and adjusting for time using regression splines with knots placed according to calendar time units.
}
\examples{

trial_data <- datasim_cont(num_arms = 3, n_arm = 100, d = c(0, 100, 250),
theta = rep(0.25, 3), lambda = rep(0.15, 4), sigma = 1, trend = "linear")

splines_cal_cont(data = trial_data, arm = 3)

}
\author{
Pavla Krotka
}
