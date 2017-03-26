library(readr)

# Reading the file and formatting dates and times

Elec <- read_delim("household_power_consumption.txt", 
                   ";", escape_double = FALSE, 
                   col_types = cols(Date = col_date(format = "%d/%m/%Y"), 
                                    Time = col_time(format = "%H:%M:%S")), 
                   trim_ws = TRUE)

# Subsetting the two days required

elec <- subset(Elec, Date == "2007-02-01" | Date == "2007-02-02")
rm(Elec) # Removing the other data

# Creating the new field with the datetime

elec$DateTime <- as.POSIXct(paste(elec$Date, elec$Time), format="%Y-%m-%d %H:%M:%S")
colors1 <- c("black", "red", "blue") # Vector of colors

png(filename = "plot3.png", width = 480, height = 480) # Open device

# Creating the empty plot

with(elec, plot(DateTime, Sub_metering_1, type = "n",
                ylab = "Energy sub metering",
                xlab = ""))

# Introducing the three series

with(elec, lines(DateTime, Sub_metering_1, type = "l", col = colors1[1]))
with(elec, lines(DateTime, Sub_metering_2, type = "l", col = colors1[2]))
with(elec, lines(DateTime, Sub_metering_3, type = "l", col = colors1[3]))

# Configuring the legend

legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lty = 1, col = colors1)
dev.off() # Disconnection of device