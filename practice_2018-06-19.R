#install.packages('expint')
#devtools::install_github('jkennel/aquifer')


library(expint)

transmissivity <- 1e-3
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

