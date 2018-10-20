source("pull_data_yahoo.R")
source("stylized_facts.R")

path_to_file <- "/Users/leklek/GARCH-M-Model/m-intc7308.csv"
da <- read.csv(file.path(path_to_file), header = T, sep = "")
intc <- log(da[,2]+1)

df_rtn_series

AAPL <- df_rtn_series[[2]]
AAPL[is.na(AAPL)] <- 0
arch1 <- garchFit(AAPL~garch(1,1), data = AAPL, trace = F,)


AAPL <- as.matrix(AAPL)
a <- garchM(AAPL, type = 2)
summary(a$residuals)
