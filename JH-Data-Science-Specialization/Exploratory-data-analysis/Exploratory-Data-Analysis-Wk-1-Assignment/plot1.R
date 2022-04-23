# Exploratory Data Analysis - Wk 1 Assignment - Plot 1 --------------------
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

# Visualize Plot 1 --------------------------------------------------------
png("output/plot1.png", width = 480, height = 480)
hist(as.numeric(filtered_df$Global_active_power), main = "Global Active Power", col = "red", xlab = "Global Active Power (kilowatts)")
dev.off()
