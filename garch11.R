source("download_library.R")
dat <- read.xlsx(xlsxFile = "sp500.xlsx", colNames = F, rowNames = F)
names(dat) <- "sp"
x <- seq(1:sapply(dat, length))

# ggplot(data = data.frame(), aes(x=x, y=dat[[1]])) + geom_line()

garchMod <- ugarchspec(variance.model = list(model = "sGARCH", 
                                             garchOrder = c(1,1)),
                       mean.model = list(armaOrder=c(0,0),
                                         include.mean=T,
                                         archm=F,
                                         archpow=NULL
                                         ),
                       distribution.model = "norm"
                       )

garch11 <- ugarchfit(spec=garchMod, data=dat, out.sample = 20)

forc <- ugarchforecast(fitORspec = garch11, n.ahead = 20)
forc.roll <- ugarchforecast(fitORspec = garch11, n.ahead = 20, n.roll = 20)

graphics.off(); par("mar"); par(mar=c(1,1,1,1));
plot(forc, which =1)
plot(forc.roll, which="all")

coef(garch11)
