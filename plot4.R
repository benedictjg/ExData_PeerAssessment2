##Question 4: Across the United States, how have emissions from coal combustion-related sources changed from 1999–2008?

library(ggplot2)
if(file.exists("Source_Classification_Code.rds")==FALSE){
    fileurl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
    download.file(fileurl, destfile="NEIdat.zip", method="curl")
    unzip("NEIdat.zip")
}

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
coal <- grepl("coal",SCC$Short.Name, ignore.case=TRUE)
NEISCC <- merge(x=NEI, y=SCC, by.x = "SCC", by.y="SCC")
NEISCCsub <- NEISCC[coal,]
NEISCCagg <- aggregate(data=NEISCCsub, NEISCCsub$Emissions ~ NEISCCsub$year, FUN=sum)
names(NEISCCagg) <- c("year","Emissions")

png("plot4.png", width = 480, height = 480)
g <- ggplot(NEISCCagg, aes(year, Emissions))
g <- g + geom_line() + xlab("Year") + ylab("Emissions") + ggtitle("COAL Emissions in USA 1999-2008")
print(g)
dev.off()
