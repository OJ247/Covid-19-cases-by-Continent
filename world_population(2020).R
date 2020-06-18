# loading the required packages
suppressMessages(library(dplyr))
suppressMessages(library(rvest))

# getting the 2020 population data
world_population <- read_html("https://www.worldometers.info/world-population/population-by-country/") %>%
        html_nodes(xpath = '//*[@id="example2"]') %>%
        html_table()

# converting from list to dataframe
world_population <- world_population[[1]]

# converting to a tibble and removing undesired column
world_population <- tbl_df(world_population) %>%
        select(-`#`) %>%
        arrange(`Country (or dependency)`)

# store file as a csv
write_csv(world_population, "World_population(2020).csv")
