library("rvest")

url <- "https://marketdata.set.or.th/mkt/sectorquotation.do"
doc <- read_html(x = url)
doc %>% html_nodes("div")

set50 <- html_nodes(doc, xpath = "//div[@class='table-responsive'][2]//table") %>% html_table()
stock_symbols <- set50 %>% as.data.frame()
stock_symbols <- stock_symbols[1]
names(stock_symbols) <- "Symbols"

stock_names <- sapply(stock_symbols, function(x) {
  sprintf("%s.BK", x)
}) %>% as.data.frame()

