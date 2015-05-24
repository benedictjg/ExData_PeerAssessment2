##Question 5: How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?

library(ggplot2)
if(file.exists("Source_Classification_Code.rds")==FALSE){
    fileurl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
    download.file(fileurl, destfile="NEIdat.zip", method="curl")
    unzip("NEIdat.zip")
}

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
NEISCC <- merge(x=NEI, y=SCC, by.x = "SCC", by.y="SCC")
mv <- grepl("veh", NEISCC$Short.Name, ignore.case=TRUE)
NEISCCsub <- NEISCC[mv,]
NEISCCsub <- subset(NEISCC,NEISCC$fips == "24510")
NEISCCagg <- aggregate(data=NEISCCsub, NEISCCsub$Emissions ~ NEISCCsub$year + NEISCCsub$fips, FUN=sum)
names(NEISCCagg) <- c("year", "fips","Emissions")

png("plot5.png", width = 480, height = 480)
g <- ggplot(NEISCCagg, aes(year, Emissions))
g <- g + geom_line() + xlab("year") + ylab("Emissions") + ggtitle("Vehicle Emissions in Baltimore 1999-2008")
print(g)
dev.off()
