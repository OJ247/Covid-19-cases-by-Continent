# Loading required packages
suppressMessages(library(tidyverse))
suppressMessages(library(lubridate))


# importing the data
covid_world <- read_csv("covid_19_data.csv")

# creating a character vector with all the 54 African countries recognized by the UN
# modifications were made to the names to match those in the covid_19_data.csv
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
        
        # add the cumulative number of active cases
        mutate(Active = Confirmed - (Deaths + Recovered))
        
        
        # changing ObservationDate from class Character to class Date
        mutate(ObservationDate = mdy(ObservationDate)) %>%
        
        # renaming `Country/Region` column to Country
        rename(Country = `Country/Region`)

# looking at resultant dataset
covid_africa

# checking and confirming the number of african countries with confirmed cases
# at the time of uploading this script only 52 of the 54 African countries had confirmed cases
length(unique(covid_africa$Country))

# adding the daily update from John Hopkins University. adjust the name of the csv "04-24-2020.csv" accordingly
daily_update <- read_csv("https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_daily_reports/04-24-2020.csv")


# modifications where made to some names to match those in the daily updates from JHU
africa_1 <- c("Algeria", "Angola", "Benin", "Botswana", "Burkina Faso",
            "Burundi", "Cameroon", "Cabo Verde", "Central African Republic", "Chad", 
            "Comoros", "Congo (Brazzaville)", "Congo (Kinshasa)", "Cote d'Ivoire", "Djibouti",
            "Egypt", "Equatorial Guinea", "Eritrea", "Eswatini", "Ethiopia",
            "Gabon", "Gambia", "Ghana", "Guinea", "Guinea-Bissau", 
            "Kenya", "Lesotho", "Liberia", "Libya", "Madagascar",
            "Malawi", "Mali", "Mauritania", "Mauritius", "Morocco", 
            "Mozambique", "Namibia", "Niger", "Nigeria", "Rwanda", 
            "Sao Tome and Principe", "Senegal", "Seychelles", "Sierra Leone", "Somalia", 
            "South Africa", "South Sudan", "Sudan", "Tanzania", "Togo", 
            "Tunisia", "Uganda", "Zambia", "Zimbabwe")

daily_update <- daily_update %>%
        
        # selecting only the desired columns
        select(Last_Update, Country_Region, Confirmed, Deaths, Recovered, Active) %>%
        
        #obtaining all covid-19 cases in affected african countries
        filter(Country_Region %in% africa_1) %>%
        
        # renaming the columns to match those in the covid_africa dataset
        rename(ObservationDate =  Last_Update, Country = Country_Region) %>%
        
        # changing the column classes to match those in the covid_africa dataset
        mutate(ObservationDate = as_date(ObservationDate),
               Confirmed = as.integer(Confirmed),
               Deaths = as.integer(Deaths),
               Recovered = as.integer(Recovered),
               Active = as.integer(Active)) %>%

        # replace Cote'd'Ivoire with Ivory Coast to match the original dataset. 
        # Do this for any country with different names in the covid_19_data.csv and the JHU daily update
        mutate(Country = replace(Country, Country == "Cote d'Ivoire", "Ivory Coast"))
 
# correction on date
daily_update <- daily_update %>%
        mutate(ObservationDate = "2020-04-24") %>%
        mutate(ObservationDate = as_date(ObservationDate))

# checking for number of african countries in the daily update. These should be the same as those in
# the covid_africa dataset
length(unique(daily_update$Country))

# join covid_africa with the daily_update. Joining will be done on all variables
covid_africa <- full_join(covid_africa, daily_update)

# having a look at the updated dataset. notice the change in number of observations
covid_africa

# storing the data set
write_csv(covid_africa, "covid_19_africa.csv")

# References
# 1. John Hopkins University Covid_19 datasets: 
# https://github.com/CSSEGISandData/COVID-19/tree/master/csse_covid_19_data/csse_covid_19_daily_reports
# 2. SRk's dataset on kaggle: https://www.kaggle.com/sudalairajkumar/novel-corona-virus-2019-dataset#covid_19_data.csv
# 3. Names of African Countries from the United Nations Department of General Assembly and Conference Management:
# https://www.un.org/depts/DGACM/RegionalGroups.shtml




        












