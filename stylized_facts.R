
# Calculate log returns
log_ret <- Return.calculate(stock_series, method = "log")

# Nomality test using Shapiro Test
lshap <- lapply(as.data.frame(log_ret), shapiro.test)
lres <- sapply(lshap, `[`, c("statistic","p.value"))
des <- t(lres)

ladf <- lapply(as.data.frame(log_ret), function(x) {Box.test(x,lag = 20, type = "Ljung-Box")})
des <- sapply(ladf, `[`, c("statistic", "p.value"))
des <- t(des)
