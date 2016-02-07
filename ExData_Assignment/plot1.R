library(lubridate)
library(dplyr)
setwd("~/Documents/Coursera/DataScience/ExploratoryDataAnalysis")
if(!file.exists("./course_project1")) {dir.create("./course_project1")}
fileUrl <-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip" 
download.file(fileUrl, destfile = "~/Documents/Coursera/DataScience/ExploratoryDataAnalysis/course_project1/household_power_consumption.txt", method="curl")
EPW <- read.table("household_power_consumption.txt", 
                  header=TRUE, sep=";")

EPWsorted<- filter(EPW, Date == "1/2/2007"| Date=="2/2/2007")

EPWsorted$Date_Time <- dmy(EPWsorted$Date)+hms(EPWsorted$Time)
EPWsorted<- select(EPWsorted, 10,3:9)
EPWsorted$Date_Time<- as.POSIXct(EPWsorted$Date_Time)
str(EPWsorted)
rm(EPW)

### plot 1 ###
setwd("~/Documents/Coursera/DataScience/ExploratoryDataAnalysis/course_project1")
png(file="plot1.png")
with(EPWsorted, hist(as.numeric(as.character(Global_active_power)), 
                     xlab= "Global Active Power (kilowatts)",
                     ylab="Frequency", col="Red", 
                     main="Global Active Power",breaks=20))
dev.off()


