##Question 3:Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) 
##variable, which of these four sources have seen decreases in emissions from 1999–2008 for 
##Baltimore City? Which have seen increases in emissions from 1999–2008?

library(ggplot2)
if(file.exists("Source_Classification_Code.rds")==FALSE){
    fileurl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
    download.file(fileurl, destfile="NEIdat.zip", method="curl")
    unzip("NEIdat.zip")
}

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
NEISCC <- merge(x=NEI, y=SCC[,1:2], by.x = "SCC", by.y="SCC")
NEISCCsub <- subset(NEISCC, fips="24510")
NEISCCagg <- aggregate(data=NEISCCsub,NEISCCsub$Emissions~NEISCCsub$year+NEISCCsub$Data.Category,FUN=sum)

png("plot3.png", width = 480, height = 480)
g <- ggplot(NEISCCagg, aes(year, Emissions, color=Type))
g <- g + geom_line() + xlab("Year") + ylab("Emissions") + ggtitle("Emissions in Baltimore by Type")
print(g)
dev.off()
