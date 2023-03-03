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

head(datasim_bin(num_arms = 3, n_arm = 100, d = c(0, 100, 250),
                 p0 = 0.7, OR = rep(1.8, 3), 
                 lambda = rep(0.15, 4), trend="stepwise"))

## -----------------------------------------------------------------------------
# Full dataset

head(datasim_bin(num_arms = 3, n_arm = 100, d = c(0, 100, 250),
                 p0 = 0.7, OR = rep(1.8, 3), 
                 lambda = rep(0.15, 4), trend="stepwise", full = T)$Data)

