##Question 6: Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources in Los Angeles County, California (fips == 06037). Which city has seen greater changes over time in motor vehicle emissions?

library(ggplot2)
if(file.exists("Source_Classification_Code.rds")==FALSE){
    fileurl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
    download.file(fileurl, destfile="NEIdat.zip", method="curl")
    unzip("NEIdat.zip")
}

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
NEISCC <- merge(x=NEI, y=SCC, by.x = "SCC", by.y="SCC")
motor <- grepl("veh", NEISCC$Short.Name, ignore.case=TRUE)
NEISCCsub <- NEISCC[motor,]
NEISCCsub <- subset(NEISCCsub,NEISCCsub$fips == "24510" | NEISCCsub$fips == "06037")
NEISCCagg <- aggregate(data=NEISCCsub, NEISCCsub$Emissions ~ NEISCCsub$year + NEISCCsub$fips, FUN=sum)
names(NEISCCagg) <- c("year","city","Emissions")
NEISCCagg[which(NEISCCagg$city=="06037"),2] <- "LA"
NEISCCagg[which(NEISCCagg$city=="24510"),2] <- "Baltimore"

png("plot6.png", width = 480, height = 480)
g <- ggplot(NEISCCagg, aes(year, Emissions, color=city))
g <- g + geom_line() + xlab("Year") + ylab("Emissions") + ggtitle("Vehicle Emissions in Baltimore & LA")
print(g)
dev.off()
