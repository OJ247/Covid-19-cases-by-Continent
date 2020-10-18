# Description -------------------------------------------------------------

# This R script scrapes world population data from 
# https://www.worldometers.info/world-population/population-by-country/
# and stores it as a data frame

# Load packages -----------------------------------------------------------

suppressMessages(library(tidyverse))
suppressMessages(library(rvest))

# Scrape -------------------------------------------------------------

world_population <- read_html("https://www.worldometers.info/world-population/population-by-country/") %>%
        html_nodes(xpath = '//*[@id="example2"]') %>%
        html_table()

# Wrangle ------------------------------------------------------------

# convert list to data frame
world_population <- world_population[[1]]

# convert to a tibble and remove undesired columns
world_population <- as_tibble(world_population) %>%
        select(-`#`) %>%
        arrange(`Country (or dependency)`)

# remove commas from cols
world_population %>% 
        mutate(across(`Population (2020)`:`World Share`, ~ str_replace_all(.x, ",", "")))


# Save --------------------------------------------------------------------

write_csv(world_population, "World_population(2020).csv")
