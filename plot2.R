## Eploratory Data Analysis - Course Project 1
## plot2.R : To generate plot2.png

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

## Create the plot
png(filename="plot2.png", width=480, height=480)
plot(data.select$timestamp, data.select$Global_active_power, type="1", xlab="", ylab="Global Active Power (kilowatts)")
dev.off()

