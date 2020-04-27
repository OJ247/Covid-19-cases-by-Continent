#loading the required packages
suppressMessages(library(tidyverse))
suppressMessages(library(lubridate))
suppressMessages(library(plotly))

# setting a general theme for all the plots
theme_set(theme_classic())

# importing the dataset
covid_africa <- read_csv("covid_19_africa.csv")

(covid_africa <- covid_africa %>%
        
        # converting all columns of class double to class integer
        mutate(Confirmed = as.integer(Confirmed), 
               Deaths = as.integer(Deaths),
               Recovered = as.integer(Recovered),
               Active = as.integer(Active)))

# checking and confirming the number of african countries with confirmed cases
# at the time of uploading this script only 52 of the 54 African countries had confirmed cases
length(unique(covid_africa$Country))

        
# obtaining the most recent cases in each country
# note that the most recent cases on a given day == cumulative sum of cases reportd on the previous day
# adjust today() - 1 accordingly
latest <- covid_africa %>%
        filter(ObservationDate == today() - 1 )

# the number of COVID-19 cases in Africa
weekly_cases <- covid_africa %>%
        group_by(ObservationDate) %>%
        summarise(Confirmed = sum(Confirmed), Deaths = sum(Deaths),
                  Recovered = sum(Recovered), Active = sum(Active))

colors <- c("Confirmed" = "orange", "Deaths" = "red", "Recovered" = "green", "Active" = "cyan2")

p <- weekly_cases %>%
        gather(Confirmed, Deaths, Recovered, Active, key = "cases", value = "number") %>%
        ggplot(aes(x = ObservationDate, y = number)) +
        geom_line(aes(color = cases)) +
        scale_x_date(date_labels = "%d-%b", date_breaks = "1 week") +
        scale_color_manual(values = colors) + 
        theme_classic() +
        theme(axis.text.x = element_text(angle = 45, hjust = 1),
              plot.title = element_text(hjust = 0, size = 10, face = "bold"),
              plot.margin = margin(1, 0, 0, 0, unit = "cm")) +
        labs(title = "Number of COVID-19 cases in Africa",
             x = "Date", y = "Number of cases")

ggplotly(p)

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
                labs(title = "Africa's Confirmed Covid-19 cases by Country. 2020-04-27"))


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
                labs(title = "Africa's Deaths from Covid-19 by Country. 2020-04-27"))

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
                labs(title = "Africa's Recovered cases from covid-19 by Country. 2020-04-27"))

# visualization of Active cases by country
(latest_active <- latest %>%
                
                # reordering the countries by number of active cases i.e highest to lowest
                mutate(Country = fct_reorder(Country, Active)) %>%
                
                #  specifying the values on the x and y axes 
                ggplot(aes(x = Country, y = Active)) +
                
                # setting parameters for the bar plots of active cases by country
                geom_bar(stat = "identity", show.legend = FALSE, fill = "cyan2", width = 0.6) + 
                
                # specifying and positioning of the bar labels
                geom_text(aes(label = Active), hjust =  0, size = 3) +
                
                # flipping the x and y  co-ordinates
                coord_flip(clip = "off", expand = FALSE) +
                
                # specifying desired parameters for the plot title and margin
                theme(plot.title = element_text(hjust = 0, size = 10, face = "bold"),
                      plot.margin = margin(0, 1, 0, 0, unit = "cm")) +
                
                # specifying the plot title
                labs(title = "Africa's Active cases of COVID-19 by Country. 2020-04-27"))

# latest sum of confirmed cases, Deaths, and recovered cases in africa
sum(latest$Confirmed); sum(latest$Deaths); sum(latest$Recovered)

# References
# 1. John Hopkins University Covid_19 datasets: 
# https://github.com/CSSEGISandData/COVID-19/tree/master/csse_covid_19_data/csse_covid_19_daily_reports
# 2. SRk's dataset on kaggle: https://www.kaggle.com/sudalairajkumar/novel-corona-virus-2019-dataset#covid_19_data.csv
# 3. African Arguments, Covid-19 Africa Tracker: 
# https://africanarguments.org/2020/04/07/coronavirus-in-africa-tracker-how-many-cases-and-where-latest/







