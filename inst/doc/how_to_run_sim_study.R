## ----setup, include=FALSE-----------------------------------------------------
library(knitr)
opts_chunk$set(echo = TRUE,
               message = FALSE,
               error = FALSE,
               warning = FALSE,
               comment = "",
               fig.align = "center",
               out.width = "100%")

options(mc.cores=3)

## -----------------------------------------------------------------------------
library(NCC)
library(ggplot2)

## -----------------------------------------------------------------------------
sim_scenarios <- data.frame(num_arms = 4, 
                            n_arm = 250, 
                            d1 = 250*0,
                            d2 = 250*1,
                            d3 = 250*2,
                            d4 = 250*3,
                            period_blocks = 2, 
                            mu0 = 0,
                            sigma = 1,
                            theta1 = 0,
                            theta2 = 0,
                            theta3 = 0,
                            theta4 = 0,
                            lambda0 = rep(seq(-0.15, 0.15, length.out = 9), 2),
                            lambda1 = rep(seq(-0.15, 0.15, length.out = 9), 2),
                            lambda2 = rep(seq(-0.15, 0.15, length.out = 9), 2),
                            lambda3 = rep(seq(-0.15, 0.15, length.out = 9), 2),
                            lambda4 = rep(seq(-0.15, 0.15, length.out = 9), 2),
                            trend = c(rep("linear", 9), rep("stepwise_2", 9)),
                            alpha = 0.025,
                            ncc = TRUE)

head(sim_scenarios)

## ---- eval=FALSE--------------------------------------------------------------
#  set.seed(1234)
#  sim_results <- sim_study_par(nsim = 1000, scenarios = sim_scenarios, arms = 4,
#                               models = c("fixmodel", "sepmodel", "poolmodel"),
#                               endpoint = "cont")

## ---- eval=FALSE--------------------------------------------------------------
#  [1] "Starting the simulations. 18 scenarios will be simulated. Starting time: 2023-02-19 14:24:09"
#  [1] "Scenario 1/18 done. Time: 2023-02-19 14:24:21"
#  [1] "Scenario 2/18 done. Time: 2023-02-19 14:24:26"
#  [1] "Scenario 3/18 done. Time: 2023-02-19 14:24:32"
#  [1] "Scenario 4/18 done. Time: 2023-02-19 14:24:37"
#  [1] "Scenario 5/18 done. Time: 2023-02-19 14:24:42"
#  [1] "Scenario 6/18 done. Time: 2023-02-19 14:24:47"
#  [1] "Scenario 7/18 done. Time: 2023-02-19 14:24:53"
#  [1] "Scenario 8/18 done. Time: 2023-02-19 14:24:58"
#  [1] "Scenario 9/18 done. Time: 2023-02-19 14:25:03"
#  [1] "Scenario 10/18 done. Time: 2023-02-19 14:25:08"
#  [1] "Scenario 11/18 done. Time: 2023-02-19 14:25:13"
#  [1] "Scenario 12/18 done. Time: 2023-02-19 14:25:19"
#  [1] "Scenario 13/18 done. Time: 2023-02-19 14:25:24"
#  [1] "Scenario 14/18 done. Time: 2023-02-19 14:25:30"
#  [1] "Scenario 15/18 done. Time: 2023-02-19 14:25:36"
#  [1] "Scenario 16/18 done. Time: 2023-02-19 14:25:41"
#  [1] "Scenario 17/18 done. Time: 2023-02-19 14:25:47"
#  [1] "Scenario 18/18 done. Time: 2023-02-19 14:25:52"

## ---- include=FALSE, echo=FALSE, eval=TRUE------------------------------------
# Add results manually because of long runtime of the simulation (CRAN check)

sim_results <- sim_scenarios[rep(seq_len(nrow(sim_scenarios)), each = 3), ]
rownames(sim_results) <- c(1:nrow(sim_results))

sim_results$study_arm <- 4
sim_results$model <- rep(c("fixmodel", "poolmodel", "sepmodel"), 18)

sim_results$reject_h0 <- c(0.030, 0.007, 0.027, 0.020, 0.008, 0.020, 0.025, 0.009, 0.018, 0.023, 0.018, 0.032, 0.031, 0.023, 0.027, 0.029, 0.033, 0.031, 0.031, 0.049, 0.032, 0.024, 0.053, 0.022, 0.027, 0.093, 0.025, 0.031, 0.000, 0.020, 0.020, 0.000, 0.022, 0.034, 0.002, 0.035, 0.013, 0.003, 0.018, 0.021, 0.020, 0.015, 0.025, 0.082, 0.021, 0.024, 0.199, 0.029, 0.028, 0.380, 0.029, 0.021, 0.617, 0.019)

sim_results$bias <- c(-0.0005506988, -0.0438708399, 0.0005236461, -0.0001912505, -0.0332907139, -0.0002745666, 0.0014866433, -0.0224244517, 0.0014689339, 0.0019243764, -0.0132531632, 0.0012354448, -0.0008100829, -0.0006305263, 0.0005062764, 0.0007936728, 0.0105594167, 0.0007603154, -0.0029095179, 0.0177743581, -0.0020748971, -0.0004732032, 0.0320234632, -0.0003444024, -0.0018542583, 0.0441438285, -0.0020824008, 0.0041050797, -0.1684501438, 0.0035396805, -0.0052914700, -0.1338118193, -0.0061579896, 0.0007975244, -0.0861302426, -0.0017007487, -0.0008201267, -0.0447944941, -0.0021701199, -0.0021257738, -0.0007531575, -0.0026113360, -0.0021726726,  0.0429857395, -0.0039479999, 0.0011433884, 0.0888110442, 0.0028729606, -0.0011313254, 0.1288540403, -0.0005165626, -0.0003261784, 0.1735776879, 0.0009341703)

sim_results$MSE <- c(0.007717052, 0.008220890, 0.008487647, 0.006601056, 0.006741297, 0.007570587, 0.007080945, 0.006059043, 0.007976836, 0.007338159, 0.006113367, 0.008393631, 0.007527355, 0.006224911, 0.008203350, 0.007192991, 0.006072723, 0.008228014, 0.008187574, 0.006498952, 0.009307924, 0.007103126, 0.006636311, 0.007794670, 0.007697291, 0.008650210, 0.008328635, 0.007325503, 0.034469812, 0.007933315, 0.007306962, 0.023967797, 0.008274504, 0.007618799, 0.013630920, 0.008346264, 0.006848033, 0.007418390, 0.007645439, 0.006918091, 0.005676356, 0.007640708, 0.007514734, 0.007862916, 0.008116238, 0.007187846, 0.013994993, 0.008139475, 0.006881168, 0.022324478, 0.007473595, 0.006596491, 0.035255110, 0.007170597)

sim_results$failed <- 0
sim_results$nsim <- 1000

## -----------------------------------------------------------------------------
head(sim_results)

## -----------------------------------------------------------------------------
ggplot(sim_results, aes(x=lambda0, y=reject_h0, color=model)) +
  geom_point() +
  geom_line() +
  facet_grid(~ trend) +
  geom_hline(aes(yintercept = 0.025), linetype = "dotted") +
  labs(x="Strength of time trend", y="Type I error", color="Analysis approach") +
  theme_bw()

## -----------------------------------------------------------------------------
ggplot(sim_results, aes(x=lambda0, y=bias, color=model)) +
  geom_point() +
  geom_line() +
  facet_grid(~ trend) +
  geom_hline(aes(yintercept = 0), linetype = "dotted") +
  labs(x="Strength of time trend", y="Bias", color="Analysis approach") +
  theme_bw()

## -----------------------------------------------------------------------------
ggplot(sim_results, aes(x=lambda0, y=MSE, color=model)) +
  geom_point() +
  geom_line() +
  facet_grid(~ trend) +
  labs(x="Strength of time trend", y="MSE", color="Analysis approach") +
  theme_bw()

