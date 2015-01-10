## I unzipped the downloaded file and placed the file in my current working directory
power <- read.table("household_power_consumption.txt",stringsAsFactors=F,sep=";",header=TRUE,na.strings="?")
power$Date <- as.Date(power$Date, "%d/%m/%Y")
## Create a file with only 2-1-07 and 2-2-07 data
library(dplyr)
power_2days <- filter(power, Date == "2007-02-01" | Date == "2007-02-02")
## Create a histogram of the data
library(datasets)
data(power_2days)
hist(power_2days$Global_active_power, main="Global Active Power", xlab="Global Active Power (in Kilowatts)", col="red")
## Copy graph to a PNG file
dev.copy(png, file="plot1.png", width=480, height=480, units="px")
dev.off()