# loading the required packages
library(dplyr)
library(lubridate)
library(rvest)


# getting the data from "2 days ago" tab
covid19_data <- read_html("https://www.worldometers.info/coronavirus/") %>%
        html_nodes(xpath = '//*[@id="main_table_countries_yesterday2"]') %>%
        html_table()

# converting from list to data frame
covid19_data <- covid19_data[[1]]

# selecting ONLY covid19 test information
covid19_tests <- covid19_data %>%
        tbl_df() %>%
        filter(!is.na(`#`)) %>%
        select(`Country,Other`, `TotalTests`, `Population`, `Tests/1M pop`, `1 Testevery X ppl`) %>%
        arrange(`Country,Other`)

# minimal data wrangling
# turn all unaviable observations into NA
covid19_tests <- na_if(covid19_tests,"")

# adding the date
covid19_tests <- covid19_tests %>%
        mutate(Date = today() - 2) %>%
        select(Date, everything())

# gettig the data from the "yesterday" tab
yesterday <-  read_html("https://www.worldometers.info/coronavirus/") %>%
        html_nodes(xpath = '//*[@id="main_table_countries_yesterday"]') %>%
        html_table()

# converting from list to data frame
yesterday <- yesterday[[1]]

# selecting ONLY covid19 test information
yesterday <- yesterday %>%
        tbl_df() %>%
        filter(!is.na(`#`)) %>%
        select(`Country,Other`, `TotalTests`, `Population`, `Tests/1M pop`, `1 Testevery X ppl`) %>%
        arrange(`Country,Other`)

# minimal data wrangling
# turn all unaviable observations into NA
yesterday <- na_if(yesterday, "")

# adding the date
yesterday <- yesterday %>%
        mutate(Date = today() - 1) %>%
        select(Date, everything())

# append to covid19_tests data
covid19_tests <- rbind(covid19_tests, yesterday)

# save file
write_csv(covid19_tests, "covid19_tests.csv")


