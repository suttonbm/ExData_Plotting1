## Download data from server
library(lubridate)

web_loc = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
zipfile = "household_power_consumption.zip"
textfile = "household_power_consumption.txt"
#download.file(web_loc, zipfile)
#unzip(zipfile)

# Read in data and do housekeeping
data <- read.csv(textfile, header=TRUE, sep=";", na.strings=c("?"))
data$DateTime <- as.POSIXct(paste(data$Date, data$Time),
                            format="%d/%m/%Y %H:%M:%S")
data$Date <- dmy(data$Date)

# Subset data to only desired dates: 01/02/2007 and 02/02/2007
day1 <- data$Date == dmy("01/02/2007")
day2 <- data$Date == dmy("02/02/2007")
data.sub <- data[day1 | day2,]

# Generate lot of Sub Metering vs time
png(filename="plot3.png",
    width=480,
    height=480)
plot(x=data.sub$DateTime,
     y=data.sub$Sub_metering_1,
     col="black",
     type="l",
     xlab="",
     ylab="Energy Sub Metering",
     ylim=c(0,40))

# Turn of screen refresh for next plot
par(new=T)
plot(data.sub$Sub_metering_2,
     col="red",
     type="l",
     axes=F,
     xlab="",
     ylab="",
     ylim=c(0,40))

# Turn of screen refresh for next plot
par(new=T)
plot(data.sub$Sub_metering_3,
     col="blue",
     type="l",
     axes=F,
     xlab="",
     ylab="",
     ylim=c(0,40))
dev.off()