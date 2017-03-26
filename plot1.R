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

png(filename = "plot1.png", width = 480, height = 480) # Open device

# Plot construction

hist(elec$Global_active_power, main = "Global Active Power", 
     xlab = "Global Active Power (kilowatts)", col = "red")
dev.off() # Disconnect from the device
