# Pull data from yahoo
source("download_library.R")

# pull sysbols wented from set50
source("scrap_stocks-01.R")
stock_names <- stock_names[[1]]
start <- "2008-1-1" 
end <- "2018-1-1"

stock_series <- data.frame()

for ( name in stock_names) {
  get_data <- getSymbols(name, from = start, to = end, auto.assign = F)[ ,4]
  names(get_data) <- name
  stock_series <- merge.xts(get_data, stock_series)
}

# Manage NA and write into excel
stock_series2 <- stock_series %>% as.data.frame()
stock_series2 <- stock_series2[colSums(!is.na(stock_series2)) > 2347]
stock_series2 <- stock_series2 %>% read.zoo %>% na.locf(na.rm = FALSE) %>% fortify.zoo
stock_series2 <- xts(stock_series2[,-1], order.by = stock_series2[,1])
write.csv(as.data.frame(stock_series2),"stock_series2.csv")

log_ret <- Return.calculate(xts(stock_series2), method = "log")[-1,]
df_rtn_series <- fortify(log_ret)

