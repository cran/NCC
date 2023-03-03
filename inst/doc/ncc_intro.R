## ----setup, include=FALSE-----------------------------------------------------
library(knitr)
opts_chunk$set(echo = FALSE,
               message = FALSE,
               error = FALSE,
               warning = FALSE,
               comment = "",
               fig.align = "center",
               out.width = "100%")

library(magick)

## -----------------------------------------------------------------------------
CC <- image_read("../man/figures/trial_scheme_CC.png")
NCC <- image_read("../man/figures/trial_scheme_NCC.png")
img <- c(CC, NCC)

image_animate(image_scale(img), delay = 150)

