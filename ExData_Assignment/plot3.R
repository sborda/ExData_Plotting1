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

## plot 3 ##
setwd("~/Documents/Coursera/DataScience/ExploratoryDataAnalysis/course_project1")
png(file="plot3.png")
with(EPWsorted, 
     plot(Date_Time, as.numeric(as.character(Sub_metering_1)), 
          ylab= "Energy sub metering", xlab="",type="l"))
with(EPWsorted, lines(Date_Time, as.numeric(as.character(Sub_metering_2)), 
                      type="l", col="red"))
with(EPWsorted, lines(Date_Time, as.numeric(as.character(Sub_metering_3)), 
                      type="l", col="blue"))
legend("topright", c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), 
       lty=c(1,1,1), col=c("black", "red", "blue"))
dev.off()