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
nFile$DateTime <- paste(nFile$Date, nFile$Time)
posixDateTime <- strptime(nFile$DateTime, "%Y-%m-%d %H:%M:%S")
nFile <- cbind(nFile, posixDateTime)
## subset the data to 2007-02-01 and 2007-02-02 data
subFile <- filter(nFile, DateTime >= as.Date("2007-02-01 00:00:00"), DateTime < as.Date("2007-02-02 00:00:00"))
## create the Global Active Power plot
plot(subFile$posixDateTime,subFile$, type="n", xlab="", ylab="Energy sub metering")

## create a png file of the plot and close the PNG device
dev.copy(png, file="plot2.png")
dev.off()