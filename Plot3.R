## Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) 
## variable, which of these four sources have seen decreases in emissions 
## from 1999–2008 for Baltimore City? Which have seen 
## increases in emissions from 1999–2008? 
## Use the ggplot2 plotting system to make a plot answer this question.

## load ggplot2
library(ggplot2)

## Load data
NEI <- readRDS("data/summarySCC_PM25.rds")
SCC <- readRDS("data/Source_Classification_Code.rds")

## Filter out  Baltimore City, Maryland (fips == "24510")
baltimore = NEI[NEI$fips == "24510",]

## Calculate the sum by type
balt_sum_type = aggregate(baltimore$Emissions, by=list(baltimore$year, baltimore$type), sum)

## set proper column names
names(balt_sum_type) = c("Year", "type", "Emissions")

## Plot results using ggplot2
qplot(Year, Emissions, data=balt_sum_type, group = type ,geom=c( "point","line"), xlim=c(1999, 2008), xlab="Year", ylab="Emissions, tons", main="Total Emissions in Baltimore by Type of Pollutant", color=type) +  theme(legend.position="bottom")

## Save in png
dev.copy(png, file="plot3.png", height=480, width=480)
dev.off()

