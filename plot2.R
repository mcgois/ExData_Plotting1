
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

createPlot2 <- function(data) {
  # starts saving to file
  png("plot2.png", width=480, height=480)
  
  # generates plot2
  with(data, plot(DateTime, Global_active_power, type = "l", 
                  ylab = "Global Active Power (kilowatts)", xlab = ""))
  
  # ends saving to file
  dev.off()
}

data <- loadData()
createPlot2(data)