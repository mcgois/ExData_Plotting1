
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

createPlot3 <- function(data) {
  # starts saving to file
  png("plot3.png", width=480, height=480)
  
  # generates plot3
  with(data, plot(DateTime, Sub_metering_1, type = "n", ylab = "Energy sub metering", xlab = ""))
  with(data, points(DateTime, Sub_metering_1, type = "l"))
  with(data, points(DateTime, Sub_metering_2, type = "l", col = "red"))
  with(data, points(DateTime, Sub_metering_3, type = "l", col = "blue"))
  legend("topright", col = c("black", "red", "blue"), 
         legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = 1)
  
  
  # ends saving to file
  dev.off()
}

data <- loadData()
createPlot3(data)