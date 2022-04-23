# Exploratory Data Analysis - Wk 1 Assignment - Plot 4 --------------------
# Set directory to directory of script if running in rstudio --------------
library(rstudioapi)
if(rstudioapi::isAvailable()){
  path <- rstudioapi::getActiveDocumentContext()$path
  Encoding(path) <- "UTF-8"
  setwd(dirname(path))
}

# Import Packages & Data --------------------------------------------------
library(tidyverse)
file_directory <- "input/household_power_consumption.txt"
df <- read.table(file_directory, header = TRUE, sep = ";", stringsAsFactors = FALSE)

# Capture dates, exclusively 2007-02-01 & 2007-02-02 ----------------------
filtered_df <- df[df$Date %in% c("1/2/2007", "2/2/2007"),]

# Create new column which merges date and time ----------------------------
Date_Time <- strptime(paste(filtered_df$Date, filtered_df$Time, sep=" "), "%d/%m/%Y %H:%M:%S")
filtered_df <- cbind(filtered_df, Date_Time)

# Visualize Plot 4 --------------------------------------------------------
png("output/plot4.png", width = 480, height = 480)
par(mfrow=c(2,2))
with(filtered_df, plot(Date_Time, Global_active_power, type="l", ylab="Global Active Power", xlab = ""))
with(filtered_df, plot(Date_Time, Voltage, type = "l", ylab="Voltage", xlab = ""))
with(filtered_df, plot(Date_Time, Sub_metering_1, type="l", ylab="Energy sub metering", xlab = ""))
lines(filtered_df$Date_Time, filtered_df$Sub_metering_2,type="l", col= "red")
lines(filtered_df$Date_Time, filtered_df$Sub_metering_3,type="l", col= "blue")
legend(c("topright"), c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty= 1, lwd=2, col = c("black", "red", "blue"))
with(filtered_df, plot(Date_Time, Global_reactive_power, type="l", ylab="Global_reactive_power", xlab = ""))
dev.off()