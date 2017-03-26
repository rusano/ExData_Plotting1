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

# Creating a new field with datetime

elec$DateTime <- as.POSIXct(paste(elec$Date, elec$Time), format="%Y-%m-%d %H:%M:%S")
colors1 <- c("black", "red", "blue") # Vector of colors

png(filename = "plot4.png", width = 480, height = 480) # Open device
par(mfrow = c(2, 2)) # Configuring the device layout

# First plot

with(elec, plot(DateTime, Global_active_power, type = "l",
                ylab = "Global Active Power", 
                xlab = ""))

# Second plot

with(elec, plot(DateTime, Voltage, type = "l",
                ylab =  "Voltage",
                xlab = "datetime"))

# Third plot

with(elec, plot(DateTime, Sub_metering_1, type = "n",
                ylab = "Energy sub metering",
                xlab = ""))

with(elec, lines(DateTime, Sub_metering_1, type = "l", col = colors1[1]))
with(elec, lines(DateTime, Sub_metering_2, type = "l", col = colors1[2]))
with(elec, lines(DateTime, Sub_metering_3, type = "l", col = colors1[3]))

legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lty = 1, col = colors1, bty = "n")

# Fourth plot

with(elec, plot(DateTime, Global_reactive_power, type = "l",
                ylab =  "Global_reactive_power",
                xlab = "datetime"))

dev.off() # Disconnection of device