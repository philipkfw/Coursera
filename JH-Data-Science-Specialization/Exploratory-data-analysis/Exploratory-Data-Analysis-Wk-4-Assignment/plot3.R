# Exploratory Data Analysis - Wk 4 Assignment - Plot 3 --------------------

# Question:
# Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") 
# from 1999 to 2008? Use the base plotting system to make a plot answering this question.

# Answer: Yes, from 1999 to 2002 as well as from 2005 to 2008

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

# Visualize Plot 3 --------------------------------------------------------
NEI_summary_Maryland_df <- NEI_df %>% 
    filter(fips == "24510") %>% 
    group_by(year) %>% 
    summarise(total_emissions = sum(Emissions)) %>% ungroup()

png("output/plot3.png", width = 480, height = 480)
with(NEI_summary_Maryland_df, barplot(total_emissions, names.arg = year, xlab = "Year", main = "Total PM2.5 Emissions from Baltimore City, Maryland"))
dev.off()


