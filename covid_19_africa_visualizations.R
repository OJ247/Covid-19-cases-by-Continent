#loading the required packages
suppressMessages(library(tidyverse))
suppressMessages(library(lubridate))

# setting a general theme for all the plots
theme_set(theme_classic())

# importing the dataset
covid_africa <- read_csv("covid_19_africa.csv")

(covid_africa <- covid_africa %>%
        
        # converting all columns of class double to class integer
        mutate(Confirmed = as.integer(Confirmed), 
               Deaths = as.integer(Deaths),
               Recovered = as.integer(Recovered)))

# checking and confirming the number of african countries with confirmed cases
# at the time of uploading this script only 52 of the 54 African countries had confirmed cases
length(unique(covid_africa$Country))

        
# obtaining the most recent cases in each country
# note that the most recent cases on a given day == cumulative sum of cases reportd on the previous day
# adjust today() - 1 accordingly
latest <- covid_africa %>%
        filter(ObservationDate == today() - 1 )

# visualisation of confirmed cases by country
(latest_confirmed <- latest %>%
                
                # reordering the countries by number of confirmed cases i.e highest to lowest
                mutate(Country = fct_reorder(Country, Confirmed)) %>%
                
                # specifying the values on the x and y axes 
                ggplot(aes(x = Country, y = Confirmed)) +
                
                # setting parameters for the bar plots of confirmed cases by country
                geom_bar(stat = "identity", show.legend = FALSE, fill = "orange", width = 0.6) + 
                
                # specifying and positioning of the bar labels
                geom_text(aes(label = Confirmed), hjust =  0, size = 3) +
                
                # flipping the x and y co-ordinates
                coord_flip(clip = "off", expand = FALSE) +
                
                # specifying desired parameters for the plot title and margin
                theme(plot.title = element_text(hjust = 0, size = 10, face = "bold"),
                      plot.margin = margin(0, 1, 0, 0, unit = "cm")) +
                
                # specifying the plot title
                labs(title = "Africa's Confirmed Covid-19 cases by Country. 2020-04-14"))

# Visualization of confirmed deaths by country
(latest_deaths <- latest %>%
                
                # reordering the countries by number of confirmed deaths i.e highest to lowest
                mutate(Country = fct_reorder(Country, Deaths)) %>%
                
                # specifying the values on the x and y axes 
                ggplot(aes(x = Country, y = Deaths)) +
                
                # setting parameters for the bar plots of confirmed deaths by country
                geom_bar(stat = "identity", show.legend = FALSE, fill = "red", width = 0.6) +
                
                # specifying and positioning of the bar labels
                geom_text(aes(label = Deaths), hjust =  0, size = 3) +
                
                # flipping the x and y co-ordinates
                coord_flip(clip = "off", expand = FALSE) +
                
                # specifying desired parameters for the plot title and margin
                theme(plot.title = element_text(hjust = 0, size = 10, face = "bold"),
                      plot.margin = margin(0, 1, 0, 0, unit = "cm")) +
                
                # specifying the plot title
                labs(title = "Africa's Deaths from Covid-19 by Country. 2020-04-14"))

# Visualization of recovered cases by country
(latest_recovered <- latest %>%
                
                # reordering the countries by number of recovered cases i.e highest to lowest
                mutate(Country = fct_reorder(Country, Recovered)) %>%
                
                #  specifying the values on the x and y axes 
                ggplot(aes(x = Country, y = Recovered)) +
                
                # setting parameters for the bar plots of confirmed recoveries by country
                geom_bar(stat = "identity", show.legend = FALSE, fill = "green", width = 0.6) + 
                
                # specifying and positioning of the bar labels
                geom_text(aes(label = Recovered), hjust =  0, size = 3) +
                
                # flipping the x and y  co-ordinates
                coord_flip(clip = "off", expand = FALSE) +
                
                # specifying desired parameters for the plot title and margin
                theme(plot.title = element_text(hjust = 0, size = 10, face = "bold"),
                      plot.margin = margin(0, 1, 0, 0, unit = "cm")) +
                
                # specifying the plot title
                labs(title = "Africa's Recovered cases from covid-19 by Country. 2020-04-14"))

# latest sum of confirmed cases, Deaths, and recovered cases in africa
sum(latest$Confirmed); sum(latest$Deaths); sum(latest$Recovered)
# date of last update of script
today()

# session information
sessionInfo()

# References
# 1. John Hopkins University Covid_19 datasets: 
# https://github.com/CSSEGISandData/COVID-19/tree/master/csse_covid_19_data/csse_covid_19_daily_reports
# 2. SRk's dataset on kaggle: https://www.kaggle.com/sudalairajkumar/novel-corona-virus-2019-dataset#covid_19_data.csv
# 3. African Arguments, Covid-19 Africa Tracker: 
# https://africanarguments.org/2020/04/07/coronavirus-in-africa-tracker-how-many-cases-and-where-latest/







