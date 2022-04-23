# Exploratory Data Analysis - Wk 4 Assignment - Plot 4 --------------------

# Question #4:
# Across the United States, how have emissions from coal combustion-related 
# sources changed from 1999–2008?

# Answer: Yes, there's a decreasing trend from 1999 to 2008.

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

# Visualize Plot 4 --------------------------------------------------------
SCC_coal_df <- SCC_df %>% filter(str_detect(tolower(EI.Sector), "coal")) %>% select(SCC)
NEI_summary_coal_df <- NEI_df %>% 
    filter(SCC %in% SCC_coal_df$SCC) %>% 
    group_by(year) %>% 
    summarise(total_emissions = sum(Emissions)) %>% ungroup()

png("output/plot4.png", width = 480, height = 480)
with(NEI_summary_coal_df, barplot(total_emissions, names.arg = year, xlab = "Year", main = "Total PM2.5 Emissions from Coal Combustion-Related 1999-2008"))
dev.off()


