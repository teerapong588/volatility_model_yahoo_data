# ADF Test
ladf <- lapply(log_ret, adf.test)
adf_statistic <- sapply(ladf, `[`, c("statistic","p.value")) %>% t()

# Jarque-Bera Test
ljb <- lapply(log_ret, jarque.bera.test)
jb_test <- sapply(ljb, `[`, c("statistic","p.value")) %>% t()
str(ljarque)

# Ljung-Box Test
lbox <- lapply(log_ret, Box.test)
lj_statistic <- sapply(lbox, `[`, c("statistic","p.value")) %>% t() %>% as.data.frame()
lj_statistic[which(lj_statistic$p.value >= 0.05),]

# ARCH Test
res_series <- data_frame()
for (name in names(log_ret)) {
  res <- ((log_ret[, sprintf("%s", name)])-mean(log_ret[, sprintf("%s", name)]))^2
  names(res) <- name
  res_series <- merge.xts(res_series, res)
}

lbox_res <- lapply(res_series, Box.test)
lj_statistic_res <- sapply(lbox_res, `[`, c("statistic","p.value")) %>% t() %>% as.data.frame()
lj_statistic_res[which(lj_statistic_res$p.value >= 0.05),]

dates <- fortify(res_series)[,1] %>% as.Date()
res_series2 <- res_series %>% as.data.frame()
ggplot(res_series2, aes(y = res_series2$BANPU.BK, x = dates)) + geom_line()
