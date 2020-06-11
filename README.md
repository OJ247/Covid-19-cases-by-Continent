# COVID-19 CASES BY CONTINENT
### Context
Late in December 2019, the [World Health Organisation (WHO) China Country Office](https://www.who.int/emergencies/diseases/novel-coronavirus-2019/events-as-they-happen) obtained information about severe pneumonia of an unknown cause, detected in the city of Wuhan in Hubei province, China. This later turned out to be the **novel coronavirus disease** (COVID-19), an infectious disease caused by **severe acute respiratory syndrome coronavirus-2** (SARS-CoV-2) of the coronavirus family. The disease causes respiratory illness characterized by [primary symptoms ](https://www.cdc.gov/coronavirus/2019-ncov/symptoms-testing/symptoms.html) like cough, fever, and in more acute cases, difficulty in breathing. **WHO** later [declared COVID-19 as a Pandemic](https://time.com/5791661/who-coronavirus-pandemic-declaration/) because of its fast rate of spread across the Globe. 

### Content
The COVID-19  datasets organized by continent contain daily level information about the COVID-19 cases in the different continents of the world.  It is a time-series data and **the number of cases on any given day is cumulative**. The original datasets can be found on this [John Hopkins University Github repository](https://github.com/CSSEGISandData/COVID-19). I will be updating the COVID-19 datasets on a daily basis, with every update from John Hopkins University. I have also included the World COVID-19 tests data [scraped](https://github.com/ju-ok/Covid-19-cases-by-Continent/blob/master/covid19_tests.R) from [Worldometer](https://www.worldometers.info/coronavirus/) and 2020 world population also [scraped](https://github.com/ju-ok/Covid-19-cases-by-Continent/blob/master/world_population(2020).R) from [worldometer](https://www.worldometers.info/world-population/population-by-country/). 

### The datasets
COVID-19 cases
`covid19_world.csv`. It contains the cumulative number of COVID-19 cases from around the world since January 22, 2020, as compiled by John Hopkins University.
`covid19_asia.csv`, `covid19_africa.csv`, `covid19_europe.csv`, `covid19_northamerica.csv`, `covid19.southamerica.csv`, `covid19_oceania.csv`, and `covid19_others.csv`. These contain the cumulative number of COVID-19 cases organized by the continent.

**Field description**
- ObservationDate: Date of observation in YY/MM/DD
- Country_Region: name of Country or Region
- Province_State: name of Province or State
- Confirmed: the number of COVID-19 confirmed cases
- Deaths:  the number of deaths from COVID-19
- Recovered: the number of recovered cases
- Active: the number of people still infected with COVID-19
Note: Active = Confirmed - (Deaths + Recovered)

COVID-19 tests
`covid19_tests.csv`. It contains the cumulative number of COVID tests data from worldometer conducted since the onset of the pandemic. Data available from June 01, 2020.

**Field description**
Date: date in YY/MM/DD
Country, Other: Country, Region, or dependency
TotalTests: cumulative number of tests up till that date
Population: population of Country, Region, or dependency
Tests/1M pop: tests per 1 million of the population
1 Testevery X ppl: 1 test for every X number of people 

2020 world population
`world_population(2020).csv`. It contains the 2020 world population as reported by woldometer.

**Field description**
Country (or dependency): Country or dependency
Population (2020): population in 2020
Yearly Change: yearly change in population as a percentage
Net Change: the net change in population
Density(P/km2): population density
Land Area(km2): land area
Migrants(net): net number of migrants
Fert. Rate: Fertility Rate
Med. Age: median age
Urban pop: urban population
World Share:  share of the world population as a percentage

### Acknowledgements
1. John Hopkins University for making COVID-19 datasets available to the public: 
https://github.com/CSSEGISandData/COVID-19/tree/master/csse_covid_19_data/csse_covid_19_daily_reports
2. John Hopkins University COVID-19 Dashboard: https://coronavirus.jhu.edu/map.html
3. COVID-19 Africa dashboard: http://covid-19-africa.sen.ovh/
4. Worldometer: https://www.worldometers.info/
5. United Nations Department of General Assembly and Conference Management:
https://www.un.org/depts/DGACM/RegionalGroups.shtml
6. wallpapercave.com: https://wallpapercave.com/covid-19-wallpapers



