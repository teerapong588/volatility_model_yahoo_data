# Pull data from yahoo
source("download_library.R")
stock_names <- c("AAPL","MSFT","AMZN","FB","JPM","XOM","GOOG","GOOGL","JNJ")
start <- "2008-1-1" 
end <- "2018-1-1" 

stock_series <- data.frame()

for ( name in stock_names) {
  get_data <- getSymbols(name, from = start, to = end, auto.assign = F)[ ,4]
  names(get_data) <- name
  stock_series <- merge.xts(get_data, stock_series)
}

write.csv(as.data.frame(stock_series),"stock_series.csv")

log_ret <- Return.calculate(stock_series, method = "log")
df_rtn_series <- fortify(log_ret)



