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
png("plot2.png",  width = 480, height = 480, units = "px")

plot(hpc$DateTime, hpc$Global_active_power, 
     type = "l",
     col = "black",
     ylab = "Global Active Power (kilowatts)", 
     xlab = "", 
     main = "")

dev.off()