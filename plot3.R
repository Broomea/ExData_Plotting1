## I unzipped the downloaded file and placed the file in my current working directory
power <- read.table("household_power_consumption.txt",stringsAsFactors=F,sep=";",header=TRUE,na.strings="?")
power$Date <- as.Date(power$Date, "%d/%m/%Y")
## Create a file with only 2-1-07 and 2-2-07 data
library(dplyr)
power_2days <- filter(power, Date == "2007-02-01" | Date == "2007-02-02")
## Combine the Date and Time columns into one
formatDateTime <- as.POSIXct(paste(as.character(power_2days$Date),as.character(power_2days$Time)))
power_2days <- cbind(formatDateTime, power_2days)
power_2days[2:3] <- list(NULL)
## Create a graph of the data
library(datasets)
data(power_2days)
png(file="plot3.png", width=480, height=480, units="px")
with(power_2days, plot(formatDateTime, Sub_metering_1, type="n", ylab="Energy sub metering", xlab=""))
with(power_2days, lines(formatDateTime, Sub_metering_1, col="black"))
with(power_2days, lines(formatDateTime, Sub_metering_2, col="red"))
with(power_2days, lines(formatDateTime, Sub_metering_3, col="blue"))
legend("topright", lty=1, col=c("black","red","blue"), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()