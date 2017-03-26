library(readr)

# Reading the file and formatting the dates and times

Elec <- read_delim("household_power_consumption.txt", 
                   ";", escape_double = FALSE, 
                   col_types = cols(Date = col_date(format = "%d/%m/%Y"), 
                                    Time = col_time(format = "%H:%M:%S")), 
                   trim_ws = TRUE)

# Subsetting the two days required

elec <- subset(Elec, Date == "2007-02-01" | Date == "2007-02-02")
rm(Elec) # Removing the other data

# Creating the new column with the datetime

elec$DateTime <- as.POSIXct(paste(elec$Date, elec$Time), format="%Y-%m-%d %H:%M:%S")
png(filename = "plot2.png", width = 480, height = 480) # Open device

# Creating the plot

with(elec, plot(DateTime, Global_active_power, type = "l",
                ylab = "Global Active Power (kilowatts)", 
                xlab = ""))

dev.off() # Disconnection of device