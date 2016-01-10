## Eploratory Data Analysis - Course Project 1
## plot4.R : To generate plot4.png

##Download the data and store it in working directory
datafile = "exdata-data-household_power_consumption.zip"
if (!file.exists(datafile)) {
  retval = download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",destfile = datafile)
}

## Unzip the file and read data
data.source = read.csv(unz(datafile, "household_power_consumption.txt"), header=T,
                       sep=";", stringsAsFactors=F, na.strings="?",
                       colClasses=c("character", "character", "numeric",
                                    "numeric", "numeric", "numeric",
                                    "numeric", "numeric", "numeric"))

## Reformat the date and time and subset data dated 2007-02-01 and 2007-02-02 only
data.source$timestamp = strptime(paste(data.source$Date, data.source$Time), format="%d/%m/%Y %H:%M:%S", tz="UTC")
startDate = strptime("01/02/2007 00:00:00", format="%d/%m/%Y %H:%M:%S", tz="UTC")
endDate = strptime("02/02/2007 23:59:59", format="%d/%m/%Y %H:%M:%S", tz="UTC")
data.select= data.source[data.source$timestamp >= startDate & data.source$timestamp <= endDate, ]

## Create the plots - 4 plots in a single canvas
png(filename="plot4.png", width=480, height=480)
par(mfcol=c(2,2))

# Plot 1
plot(data.select$timestamp, data.select$Global_active_power, type="l", xlab="", ylab="Global Active Power")

# Plot 2
plot(data.select$timestamp, data.select$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
lines(data.select$timestamp, data.select$Sub_metering_2, col="red")
lines(data.select$timestamp, data.select$Sub_metering_3, col="blue")
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       col=c("black", "red", "blue"), 
       lwd=par("lwd"), bty="n")

# Plot 3
plot(data.select$timestamp, data.select$Voltage, type="l", xlab="datetime", ylab="Voltage")

# Plot 4
plot(data.select$timestamp, data.select$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power")

dev.off()
