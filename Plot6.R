## Compare emissions from motor vehicle sources in Baltimore City 
## with emissions from motor vehicle sources in Los Angeles County, California (fips == "06037"). 
## Which city has seen greater changes over time in motor vehicle emissions?

## load ggplot2
library(ggplot2)

## Load data
NEI <- readRDS("data/summarySCC_PM25.rds")
SCC <- readRDS("data/Source_Classification_Code.rds")

## get all for Baltimore City and LA County
nei_cities = NEI[NEI$fips  %in% c("24510", "06037") ,]

## get all motor-related rows
scc_motor=SCC[grep("motor", SCC$Short.Name, ignore.case = TRUE), ]
motor_identifiers = as.character(scc_motor$SCC)
NEI$SCC = as.character(NEI$SCC)
nei_cities_motors = nei_cities[nei_cities$SCC %in% motor_identifiers,]

## set city name
nei_cities_motors$City.Name[nei_cities_motors$fips == "06037"] = "Los Angeles County"
nei_cities_motors$City.Name[nei_cities_motors$fips == "24510"] = "Baltimore City"

## aggregate
aggr = with(nei_cities_motors, aggregate(Emissions, by=list(year, City.Name), sum))
colnames(aggr)=c("Year", "City", "Emissions")

## Plot
qplot(Year, Emissions, data=aggr, group = City ,geom=c( "point","line"), xlim=c(1999, 2008), xlab="Year", ylab="Emissions, tons", main="Emissions from motor vehicle in Baltimore City and Los Angeles County", color=City) +  theme(legend.position="bottom")

## Save in png
dev.copy(png, file="plot6.png", height=480, width=480)
dev.off()

