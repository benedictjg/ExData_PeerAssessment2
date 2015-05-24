##Question 1: Have total emissions from PM2.5 decreased in the US from 1999 to 2008?

if(file.exists("Source_Classification_Code.rds")==FALSE){
    fileurl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
    download.file(fileurl, destfile="NEIdat.zip", method="curl")
    unzip("NEIdat.zip")
}

NEI <- readRDS("summarySCC_PM25.rds")
NEIPM <- aggregate(data=NEI, NEI$Emissions~NEI$year, FUN=sum)

png("plot1.png", width = 480, height = 480)
plot(NEIPM, type="l", xlab="Year", ylab="Emissions", main="PM25 Emissions 1999-2008")
dev.off()
