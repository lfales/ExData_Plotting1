## Install required packages
install.packages("dplyr")
install.packages("lattice")
library(dplyr)
library(lattice)

## Set working diectory
setwd("/GitHub")

## Download data files for project analysis
fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
zipfile="data/household_power_comsumption.zip"
download.file(fileURL,destfile=zipfile)
dateDownloaded <- date()

## unzip data file for project analysis
zipfile="data/household_power_consumption.zip" 
unzip(zipfile, exdir="Coursera")

## read the data and reformat the date time
nFile <- read.table("./Coursera/household_power_consumption.txt", header=TRUE, sep=';', na.strings = '?', nrows=1000000)
nFile$Date <- as.Date(nFile[,1], format = "%d/%m/%Y")

##Subset the data
subFile <- subset(nFile, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))

##Converting dates
Datetime <- paste(as.Date(subFile$Date), subFile$Time)
subFile$Datetime <- as.POSIXct(Datetime)

## create the Global Active Power plot
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))
with(subFile, {
  plot(Global_active_power~Datetime, type="l")
  plot(Voltage~Datetime, type="l", xlab="", ylab="Voltage (volt)")
  plot(Sub_metering_1~Datetime, type="l", xlab="", ylab="Global Active Power (kilowatts)")
  lines(Sub_metering_2~Datetime, col="Red")
  lines(Sub_metering_3~Datetime, col="Blue")
  legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2,
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  plot(Global_reactive_power~Datetime, type="l", xlab="", ylab="Global Reactive Power (kilowatts)")
})

## create a png file of the plot and close the PNG device
dev.copy(png, file="plot4.png")
dev.off()
