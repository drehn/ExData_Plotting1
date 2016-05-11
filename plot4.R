setwd("./Coursera/datasciencecoursera")
library(ggplot2)
library(data.table)
library(dplyr)
library(plyr)
library(lubridate)

## read data in
raw = as.data.table(read.table("household_power_consumption.txt", header = TRUE, sep=";", na.strings = "?", stringsAsFactors = FALSE))
hpc = mutate(raw, DateTime = dmy_hms(paste(Date,Time)))
hpc = filter(hpc, as.Date(DateTime) %in% c(as.Date("2007/02/01"),as.Date("2007/02/02")))

## create png plot
png("plot4.png",  width = 480, height = 480, units = "px")

par(mfrow = c(2,2))

## Plot top left
plot(hpc$DateTime, hpc$Global_active_power, 
     type = "l",
     col = "black",
     ylab = "Global Active Power (kilowatts)", 
     xlab = "", 
     main = "")

## plot top right

plot(hpc$DateTime, hpc$Voltage, 
     type = "l",
     col = "black",
     ylab = "Voltage", 
     xlab = "datetime", 
     main = "")

## plot bottom left
with(hpc, plot(DateTime, Sub_metering_1, type = "n", ylab = "Energy sub metering", xlab = ""))

with(hpc, lines(DateTime, Sub_metering_1, col = "black"))
with(hpc, lines(DateTime, Sub_metering_2, col = "red"))
with(hpc, lines(DateTime, Sub_metering_3, col = "blue"))
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"),
       lwd = 2, lty = 1)

## plot bottom right

plot(hpc$DateTime, hpc$Global_reactive_power, 
     type = "l",
     col = "black",
     ylab = "Global_reactive_power", 
     xlab = "datetime", 
     main = "")

dev.off()
