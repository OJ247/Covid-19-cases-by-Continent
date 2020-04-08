# Loading required packages
suppressMessages(library(tidyverse))
suppressMessages(library(lubridate))


# importing the data
covid_world <- read_csv("covid_19_data.csv")

# creating a character vector with all the 54 African countries recognized by the UN
# modifications were made to the names to match those covid_19_data.csv
africa <- c("Algeria", "Angola", "Benin", "Botswana", "Burkina Faso",
          "Burundi", "Cameroon", "Cabo Verde", "Central African Republic", "Chad", 
          "Comoros", "Congo (Brazzaville)", "Congo (Kinshasa)", "Djibouti", "Egypt",
          "Equatorial Guinea", "Eritrea", "Eswatini", "Ethiopia", "Gabon", 
          "Gambia", "Ghana", "Guinea", "Guinea-Bissau", "Ivory Coast", 
          "Kenya", "Lesotho", "Liberia", "Libya", "Madagascar",
          "Malawi", "Mali", "Mauritania", "Mauritius", "Morocco", 
          "Mozambique", "Namibia", "Niger", "Nigeria", "Rwanda", 
          "Sao Tome and Principe", "Senegal", "Seychelles", "Sierra Leone", "Somalia", 
          "South Africa", "South Sudan", "Sudan", "Tanzania", "Togo", 
          "Tunisia", "Uganda", "Zambia", "Zimbabwe")

# Separating Africa's covd-19 cases from the rest of the world
covid_africa <- covid_world %>%
        
        # removing undesired columns
        select(-c(SNo, `Province/State`, `Last Update`)) %>% 
        
        #obtaining all covid-19 cases in affected African countries
        filter(`Country/Region` %in% africa) %>%
        
        # converting all columns of class double to class integer
        mutate_if(is.double, as.integer) %>%
        
        # changing ObservationDate from class Character to class Date
        mutate(ObservationDate = mdy(ObservationDate)) %>%
        
        # renaming `Country/Region` column to Country
        rename(Country = `Country/Region`)

# looking at resultant dataset
covid_africa

# checking and confirming the number of african countries with confirmed cases
# at the time of uploading this script only 52 of the 54 African countries had confirmed cases
length(unique(covid_africa$Country))

# storing the data set
write_csv(covid_africa, "covid_19_africa.csv")

# session information
sessionInfo()

# References
# 1. John Hopkins University Covid_19 datasets: 
# https://github.com/CSSEGISandData/COVID-19/tree/master/csse_covid_19_data/csse_covid_19_daily_reports
# 2. SRk's dataset on kaggle: https://www.kaggle.com/sudalairajkumar/novel-corona-virus-2019-dataset#covid_19_data.csv
# 3. Names of African Countries from the United Nations Department of General Assembly and Conference Management:
# https://www.un.org/depts/DGACM/RegionalGroups.shtml




        




        










