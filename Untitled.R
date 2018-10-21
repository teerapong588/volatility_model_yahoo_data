
dat <- read.xlsx(xlsxFile = "sp500.xlsx", colNames = F, rowNames = F)
names(dat) <- "sp"
x <- seq(1:sapply(dat, length))

ggplot(data = data.frame(), aes(x=x, y=dat[[1]])) + geom_line()

garchMod <- ugarchspec(variance.model = list(model = "sGARCH", 
                                             garchOrder = c(1,1)),
                       
                       mean.model = list(armaOrder=c(0,0),
                                         include.mean=T,
                                         archm=F,
                                         archpow=NULL
                                         ),
                       distribution.model = "std"
                       )

garch_m11 <- ugarchfit(spec=garchMod, data=dat)
coef(garch_m11)

names(garch_m11@model)
garch_m11@fit

ugarchforecast()