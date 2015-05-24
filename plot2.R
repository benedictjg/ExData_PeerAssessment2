##Question 2: Have total emissions from PM2.5 decreased in the Baltimore City, Maryland 
##(fips == "24510") from 1999 to 2008?

if(file.exists("Source_Classification_Code.rds")==FALSE){
    fileurl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
    download.file(fileurl, destfile="NEIdat.zip", method="curl")
    unzip("NEIdat.zip")
}

NEI <- readRDS("summarySCC_PM25.rds")
NEIsub <- subset(NEI, fips=="24510")

NEIsubPM <- aggregate(data=NEIsub, NEIsub$Emissions~NEIsub$year, FUN=sum)
png("plot2.png", width = 480, height = 480)
plot(NEIsubPM, type="l", xlab="Year", ylab="Emissions", main="PM25 Emissions in Baltimore City, Maryland 1999-2008")
dev.off()
