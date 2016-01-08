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

# Generate histogram of Global Active Power
png(filename="plot1.png",
    width=480,
    height=480)
hist(data.sub$Global_active_power,
     col="red",
     xlab="Global Active Power (kilowatts)",
     main="Global Active Power")
dev.off()