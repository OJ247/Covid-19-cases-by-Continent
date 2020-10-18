# Description -------------------------------------------------------------

# This function scrapes Covid-19 test data from https://www.worldometers.info/coronavirus/
#
# use: scrape_tests(test_date) 
# where; test_date = today() - 2 to scrape test data from the "2 Days Ago" tab 
#        OR
#        test_date = today() - 1 to scrape test data from the "Yesterday" tab

# Load libraries ----------------------------------------------------------

library(tidyverse)
library(lubridate)
library(rvest)

# Function ----------------------------------------------------------------

scrape_tests <- function(test_date) {
        
        # path to test_data
        if (test_date == today() - 2) {
                test_data <- read_html("https://www.worldometers.info/coronavirus/") %>%
                        html_nodes(xpath = '//*[@id="main_table_countries_yesterday2"]') %>%
                        html_table()
        } else if (test_date == today() - 1) {
                test_data <- read_html("https://www.worldometers.info/coronavirus/") %>%
                        html_nodes(xpath = '//*[@id="main_table_countries_yesterday"]') %>%
                        html_table()
        } else {
                stop("Incorrect date or date format. Enter correct date in the format 'YY-MM-DD'")
        }
        
        test_data <- test_data[[1]]
        
        # select ONLY Covid19 test information
        test_data <- test_data %>%
                as_tibble() %>%
                filter(!is.na(`#`)) %>%
                select(`Country,Other`, `TotalTests`, `Population`, `Tests/1M pop`, `1 Testevery X ppl`) %>%
                arrange(`Country,Other`)
        
        # convert unavailable observations into NA
        test_data <- na_if(test_data, "")
        
        # add the date
        test_data <- test_data %>%
                mutate(Date = {{ test_date }}) %>%
                select(Date, everything())
        
        # remove commas from cols and change cols to desired classes
        test_data <- test_data %>%
                mutate(
                        across(TotalTests:`1 Testevery X ppl`, ~str_replace_all(.x, ",", "")),
                        across(TotalTests:`1 Testevery X ppl`, as.integer)
                )
        
        # save
        test_data <- write_csv(test_data, "test_data.csv")
        
        # assign to global env and return test_data
        assign("test_data", test_data, envir = globalenv())
        test_data
}





