## Across the United States, how have emissions
## from coal combustion-related sources changed from 1999–2008?

## Load data
NEI <- readRDS("data/summarySCC_PM25.rds")
SCC <- readRDS("data/Source_Classification_Code.rds")

## get the sources related to coal
## SCC_coal <- grep("coal", SCC$Short.Name, ignore.case = TRUE)
## SCC.coal <- SCC[SCC.coal, ]
scc_coal = SCC[grep("coal", SCC$Short.Name, ignore.case = TRUE),]

## Extract from NEI just the records realted to coal burning
NEI$SCC = as.character(NEI$SCC)
scc_coal_identifier = as.character(scc_coal$SCC)
nei_coal = NEI[NEI$SCC %in% scc_coal_identifier,]

## Aggregate
nei_coal_agg = aggregate(nei_coal$Emissions, by=list(nei_coal$year), sum)

## Plot
plot(nei_coal_agg, type="o", xlim=c(1999,2008), col="black", xlab="Year", ylab="Emissions, tons", main="Emissions from Coal Combustion-related Sources")

## Save in png
dev.copy(png, file="plot4.png", height=480, width=480)
dev.off()



