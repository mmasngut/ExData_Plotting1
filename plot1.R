## Eploratory Data Analysis - Course Project 1
## plot1.R : To generate plot1.png (histogram)

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

## Reformat the date and select data dated 2007-02-01 and 2007-02-02 only
data.source$Date = as.Date(data.source$Date, format="%d/%m/%Y")
startDate = as.Date("01/02/2007", format="%d/%m/%Y")
endDate = as.Date("02/02/2007", format="%d/%m/%Y")
data.select = data.source[data.source$Date >= startDate & data.source$Date <= endDate, ]

## Create the plot
png(filename="plot1.png", width=480, height=480)
hist(data.select$Global_active_power, main="Global Active Power",
     xlab="Global Active Power (kilowatts)", col="red")
dev.off()
