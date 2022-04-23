# Exploratory Data Analysis - Wk 4 Assignment - Plot 5 --------------------

# Question #5:
# How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?

# Answer: There is a decreasing trend.

# Set directory to directory of script if running in rstudio --------------
library(rstudioapi)
if(rstudioapi::isAvailable()){
    path <- rstudioapi::getActiveDocumentContext()$path
    Encoding(path) <- "UTF-8"
    setwd(dirname(path))
}

# Import Packages & Data --------------------------------------------------
library(tidyverse)
NEI_df <- readRDS("input/summarySCC_PM25.rds")
SCC_df <- readRDS("input/Source_Classification_Code.rds")

# Verify null values ------------------------------------------------------
colSums(is.na(NEI_df)) # appears that there is 0 null/NA values

# Visualize Plot 5 --------------------------------------------------------
SCC_vehicle_df <- SCC_df %>% filter(str_detect(tolower(SCC.Level.Two), "vehicle")) %>% select(SCC,SCC.Level.Two)

NEI_summary_vehicle_df <- NEI_df %>% 
    filter(SCC %in% SCC_vehicle_df$SCC) %>%
    filter(fips == "24510") %>%
    group_by(year) %>% 
    summarise(total_emissions = sum(Emissions)) %>% ungroup()

png("output/plot5.png", width = 480, height = 480)
with(NEI_summary_vehicle_df, barplot(total_emissions, names.arg = year, xlab = "Year", main = "Total PM2.5 Emissions from Motor Vehicles in Baltimore 1999-2008"))
dev.off()