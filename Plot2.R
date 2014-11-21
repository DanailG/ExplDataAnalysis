## Load data
NEI <- readRDS("data/summarySCC_PM25.rds")
SCC <- readRDS("data/Source_Classification_Code.rds")

## Filter out  Baltimore City, Maryland (fips == "24510")
baltimore = NEI[NEI$fips == "24510",]

## Calculate the sum 
balt_sum = aggregate(baltimore$Emissions, by=list(baltimore$year), sum)

## Plot results using base system
plot(balt_sum, type="o", xlim=c(1999, 2008), xlab="Year", ylab="Total Emissions", main="Total emissions from PM2.5 in Baltimore County", col="blue")

## Save in png
dev.copy(png, file="plot2.png", height=480, width=480)
dev.off()

