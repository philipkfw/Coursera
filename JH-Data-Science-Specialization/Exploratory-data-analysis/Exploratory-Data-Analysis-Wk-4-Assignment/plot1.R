# Exploratory Data Analysis - Wk 4 Assignment - Plot 1 --------------------

# Question #1:
# Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
# Using the base plotting system, make a plot showing the total PM2.5 emission from 
# all sources for each of the years 1999, 2002, 2005, and 2008.

# Answer: Yes.

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
SSC_df <- readRDS("input/Source_Classification_Code.rds")

# Verify null values ------------------------------------------------------
colSums(is.na(NEI_df)) # appears that there is 0 null/NA values

# Visualize Plot 1 --------------------------------------------------------
NEI_summary_df <- NEI_df %>% 
  group_by(year) %>% 
  summarise(total_emissions = sum(Emissions)) %>% ungroup()

png("output/plot1.png", width = 480, height = 480)
with(NEI_summary_df, barplot(total_emissions, names.arg = year, xlab = "Year", main = "Total PM2.5 Emissions 1999-2008"))
dev.off()
