
loadData <- function(input = file.path("household_power_consumption.txt")) {
  # read just header
  header <- read.csv(input, nrows = 1, header = FALSE, sep =';', stringsAsFactors = FALSE)
  
  # read data
  electric.data <- read.csv(input, skip = 66636, nrows = 2880, na.strings = "?", sep =';')
  
  # puts back header
  colnames( electric.data ) <- unlist(header)
  
  # inserts datetime
  electric.data$DateTime <- strptime(paste(electric.data$Date, electric.data$Time), "%d/%m/%Y %H:%M:%S")
  
  electric.data
}

createPlot4 <- function(data) {
  # starts saving to file
  png("plot4.png", width=480, height=480)
  
  # generates plot4
  par(mfrow = c(2,2))
  with(data, plot(DateTime, Global_active_power, type = "l", ylab = "Global Active Power", xlab = ""))
  with(data, plot(DateTime, Voltage, type = "l", ylab = "Voltage", xlab = "datetime"))
  with(data, plot(DateTime, Sub_metering_1, type = "n", ylab = "Energy sub metering", xlab = ""))
  with(data, points(DateTime, Sub_metering_1, type = "l"))
  with(data, points(DateTime, Sub_metering_2, type = "l", col = "red"))
  with(data, points(DateTime, Sub_metering_3, type = "l", col = "blue"))
  legend("topright", col = c("black", "red", "blue"), 
         legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = 1, bty = "n")
  with(data, plot(DateTime, Global_reactive_power, type = "l", ylab = "Global_reactive_power", xlab = "datetime"))
  
  # ends saving to file
  dev.off()
}

data <- loadData()
createPlot4(data)