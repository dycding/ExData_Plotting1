library(sqldf)

# Inside the folder that holds the dataset file (.zip)
if (!file.exists("household_power_consumption.txt")) {
	unzip("exdata_data_household_power_consumption.zip")
}

# Load the dataset, with Date from 2007-02-01 to 2007-02-02
dataset <- read.csv.sql("household_power_consumption.txt", sql = "select * from file where Date = '1/2/2007' or Date = '2/2/2007'", header = TRUE, sep = ";")

# Convert to Date/Time class
dataset$Date_time <- strptime(paste(dataset$Date, dataset$Time, sep = " "), "%d/%m/%Y %H:%M:%S")

# Make the plot
with(dataset, {plot(Date_time, Sub_metering_1, type = "l", xlab = "", ylab = "Energy Submetering")
			lines(Date_time, Sub_metering_2, type = "l", col = "red")
			lines(Date_time, Sub_metering_3, type = "l", col = "blue")
			legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = c(1, 1, 1), col = c("black", "red", "blue"))
})

# Copy to a PNG file (480px * 480 px by default) and close the device
dev.copy(png, file = "plot3.png")
dev.off()