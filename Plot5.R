## How have emissions from motor vehicle sources changed 
## from 1999–2008 in Baltimore City? 

## Load data
NEI <- readRDS("data/summarySCC_PM25.rds")
SCC <- readRDS("data/Source_Classification_Code.rds")

## get all for Baltimore City
baltimore = NEI[NEI$fips == "24510",]

## get all motor-related in Baltimore City
scc_motor=SCC[grep("motor", SCC$Short.Name, ignore.case = TRUE), ]
motor_identifiers = as.character(scc_motor$SCC)
NEI$SCC = as.character(NEI$SCC)
baltimore_motor = baltimore[baltimore$SCC %in% motor_identifiers,]

## Aggregate
aggregated = aggregate(baltimore_motor$Emissions, by=list(baltimore_motor$year), sum)
colnames(aggregated)=c("Year", "Emissions")

## Plot
plot(aggregated, type="o", xlim=c(1999,2008), col=312, xlab="Year", ylab="Emissions, tons", main="Emissions from Motor Vehicle in Baltimore")


## Save in png
dev.copy(png, file="plot5.png", height=480, width=480)
dev.off()
