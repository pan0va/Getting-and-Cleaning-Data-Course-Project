data<- read.table ("household_power_consumption.txt", header = TRUE, nrows=2075260, sep = ";", na.strings = "?")
data<- subset(data, data$Date %in% c("1/2/2007","2/2/2007"))
data$DateTime<- strptime(paste(data$Date,data$Time), format = "%d/%m/%Y %H:%M:%S" )
data<- na.omit(data)
Sys.setlocale("LC_TIME", "English")
data$DateTime<-as.POSIXct(data$DateTime)

dev.copy(png,'plot4.png', width = 480, height = 480)
par(mfrow = c(2,2))
with(data, {
  plot(DateTime, Global_active_power, type = "l", ylab = "Global Active Power", xlab =NA)
  plot(DateTime, Voltage, type = "l", ylab = "Voltage", xlab = "datetime")
  {plot(DateTime, Sub_metering_1, type = "l", ylab = "Energy sub metering", xlab =NA)
  
  lines(DateTime, Sub_metering_2, col = "red")
  lines(DateTime, Sub_metering_3, col = "blue")
  legend("topright",  lty=1, col = c("black", "red", "blue"), bty = "n", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), border="white", cex = 0.8)
  }
  plot(DateTime, Global_reactive_power, type = "l", xlab ="datetime", ylim = c(0.0, 0.5))
   
})

dev.off()