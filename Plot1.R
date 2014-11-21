## Load data
NEI <- readRDS("data/summarySCC_PM25.rds")
SCC <- readRDS("data/Source_Classification_Code.rds")

## Calculate the sum by year
by_year = aggregate(NEI$Emissions,by=list(NEI$year),sum) 

## Plot results
plot(by_year, type="l", xlim=c(1999, 2008), xlab="Year", ylab="Total Emissions", main="Total emissions from PM2.5 in the United States", col="blue")


## save in png
dev.copy(png, file="plot1.png", height=480, width=480)
dev.off()
par(mfrow=c(1,1))

