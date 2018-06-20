#install.packages('expint')
library(expint)

transmissivity <- 1e-4
storativity <- 1e-5
time_start <- 1
time_end <- 43200
times <- 1:86400
rate <- 1
xw <- 0
yw <- 0
x1 <- 100
y1 <- 0

radius <- sqrt((xw-x1)^2 + (yw-y1)^2)

theis_coef <- rate / (4 * pi * transmissivity)
theis_u <- radius^2 * storativity / (4 * times * transmissivity)
well_f <- expint(theis_u)
s <- theis_coef * well_f

s_recov <- rep(0.0, length(times))
wh <- which(times > time_end)
s_recov[wh] <- -s[1:43200]

plot(s+s_recov, type = 'l')


# Note the smoothness of the recovery!
# Make sure that you have Rtools
# devtools::install_github('jkennel/aquifer')
library(aquifer)
s_convolve <- grf_convolve(radius = 100, 
                           storativity = 1e-5, K = 1e-3, 
                           thickness = 1, time = 1:86400, 
                           flow_rate = c(1 + rnorm(43200), rep(0.0, 43200)), 
                           flow_dimension = 2)
points(s_convolve, type ='l', col = 'red')
