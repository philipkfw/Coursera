# Exploratory Data Analysis - Wk 4 Assignment - Plot 6 --------------------

# Question #6:
# Compare emissions from motor vehicle sources in Baltimore City with emissions 
# from motor vehicle sources in Los Angeles County, California (fips == "06037"). 
# Which city has seen greater changes over time in motor vehicle emissions?

# Answer: Greater changes occur in Los Angeles County, California relative to Baltimore City.

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

# Visualize Plot 6 --------------------------------------------------------
SCC_vehicle_df <- SCC_df %>% filter(str_detect(tolower(SCC.Level.Two), "vehicle")) %>% select(SCC,SCC.Level.Two)

NEI_summary_vehicle_city_df <- NEI_df %>% 
    filter(SCC %in% SCC_vehicle_df$SCC) %>%
    filter(fips %in% c("24510","06037")) %>%
    group_by(fips,year) %>% 
    summarise(total_emissions = sum(Emissions)) %>% ungroup() %>% 
    mutate(
        City = case_when(
            fips == "24510" ~ "Baltimore City",
            TRUE ~ "Los Angeles County, California"
        )
    )

png("output/plot6.png", width = 480, height = 480)
NEI_summary_vehicle_city_df %>% ggplot(aes(x = factor(year), y = total_emissions, fill = City)) +
    geom_bar(stat = 'identity') +
    labs(
        title = "Total PM2.5 Emissions in Baltimore & LA County 1999-2008",
        x = "Year",
        y = "Total Emissions"
    ) +
    theme_light() +
    facet_grid(cols = vars(City)) +
    theme(legend.position = "bottom", legend.title = element_blank())
dev.off()


