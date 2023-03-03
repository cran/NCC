## ----setup, include=FALSE-----------------------------------------------------
library(knitr)
opts_chunk$set(echo = TRUE,
               message = FALSE,
               error = FALSE,
               warning = FALSE,
               comment = "",
               fig.align = "center",
               out.width = "70%")

## -----------------------------------------------------------------------------
library(NCC)

## -----------------------------------------------------------------------------
# Dataset with trial data only (default)

head(datasim_cont(num_arms = 3, n_arm = 100, d = c(0, 100, 250), 
                  theta = rep(0.25, 3), lambda = rep(0.15, 4), 
                  sigma = 1, trend = "linear"))

## -----------------------------------------------------------------------------
# Full dataset

head(datasim_cont(num_arms = 3, n_arm = 100, d = c(0, 100, 250), 
                  theta = rep(0.25, 3), lambda = rep(0.15, 4), 
                  sigma = 1, trend = "linear", full = T)$Data)

