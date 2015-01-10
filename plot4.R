consumption.txt",stringsAsFactors=F,sep=";",header=TRUE,na.strings="?")
power$Date <- as.Date(power$Date, "%d/%m/%Y")
## Create a file with only 2-1-07 and 2-2-07 data
library(dplyr)
power_2days <- filter(power, Date == "2007-02-01" | Date == "2007-02-02")
## Combine the Date and Time columns into one
formatDateTime <- as.POSIXct(paste(as.character(power_2days$Date),as.character(power_2days$Time)))
power_2days <- cbind(formatDateTime, power_2days)
power_2days[2:3] <- list(NULL)

png(file="plot4.png", width=480, height=480, units="px")
par(mfrow = c(2,2))
with(power_2days, {
    plot(formatDateTime, Global_active_power, type="l", ylab="Global Active Power (Kilowatts)", xlab="")
    plot(formatDateTime, Voltage, type="l", xlab="datetime")
    plot(formatDateTime, Sub_metering_1, type="n", ylab="Energy sub metering", xlab="")
        lines(formatDateTime, Sub_metering_1, col="black")
        lines(formatDateTime, Sub_metering_2, col="red")
        lines(formatDateTime, Sub_metering_3, col="blue")
        legend("topright",lty=1, bty="n", col=c("black","red","blue"), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
    plot(formatDateTime, Global_reactive_power, type="l", xlab="datetime")
})
dev.off()