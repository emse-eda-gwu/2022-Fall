
Data file: gapminder.csv

Date downloaded: February 11, 2020

Description: Health and income outcomes for 142 countries from 1952 to 2017.

Source of downloaded file:
- Downloaded from the gapminder library: https://cran.r-project.org/web/packages/gapminder/README.html

Dictionary:

Variable  | Description
----------|----------------------------
country   |
continent |
year      |
lifeExp   | life expectancy at birth
pop       | total population
gdpPercap | per-capita GDP

---

Data file: hot_dog_winners.csv

Date downloaded: February 13, 2020

Description: Winners of the annual Nathan's hot dog eating contest

Source of downloaded file:
- Plot of this data is from flowingdata.com: https://flowingdata.com/2009/07/02/whos-going-to-win-nathans-hot-dog-eating-contest/
- Original data source is wikipedia: https://en.wikipedia.org/wiki/Nathan%27s_Hot_Dog_Eating_Contest

Dictionary:

Variable           | Description
-------------------|-----------------------------------------
Year               |
Winner             | Name of winner
Competition        | Mens vs. Womens competition
Dogs eaten         | Number of hot dogs eaten
Country of winner  | total population
New record         | 1 or 0 for whether new record was set

---

Data file:
- internet_users_region_country.csv
- internet_users_region.csv

Date downloaded: February 13, 2020

Description: Data on the number of people using the Internet in different countries and world regions between 1990 and 2015.

Source of downloaded file:
- This data comes from Max Roser's Our World in Data project. They processed the originaldata to estimate the number of users based on the usage rate times the population: https://ourworldindata.org/internet
- The original data come from the World Bank: https://data.worldbank.org/indicator/it.net.user.zs

Dictionaries:

Region data:

Variable   | Description
-----------|----------------------------
region     | region
year       | year
numUsers   | Number of Internet users

Country data:

Variable   | Description
-----------|----------------------------
country    | country
year       | year
percent    | Percent of population in country using the Internet

---

Data file: milk_production.csv

Date downloaded: January 5, 2020

Description: U.S. Milk production (in pounds) by state from 1970 to 2017

Source of downloaded file:
- The Tidy Tuesday challenge here: https://github.com/rfordatascience/tidytuesday/tree/master/data/2019/2019-01-29
- Here's the link to the original file I downloaded: https://github.com/rfordatascience/tidytuesday/blob/master/data/2019/2019-01-29/state_milk_production.csv

Original data source: The original data source is the USDA (United States Department of Agriculture). See the website here:
https://www.ers.usda.gov/data-products/dairy-data/documentation/#Loc3

Dictionary:

variable      |class     |description
--------------|----------|----------------------
region        |character |Region of the US
state         |character |US State
year          |date      |Year
milk_produced |double    |Pounds of Milk Produced

---

Data file:
- nasa_global_temps.txt
- nasa_global_temps.csv

Date downloaded: March 1, 2021

Description: NASA data on the change in global surface temperature relative to 1951-1980 average temperatures.

Source of downloaded file:
- Originally downloaded from NASA here: https://data.giss.nasa.gov/gistemp/graphs/graph_data/Global_Mean_Estimates_based_on_Land_and_Ocean_Data/graph.txt
- I modified two of the column names

Original data source: NASA

Other:
- View the NASA plot of these data here: https://climate.nasa.gov/vital-signs/global-temperature/

Dictionary:

variable    | description
------------|----------------------
year        | year (1880 - 2020)
meanTemp    | Global annual mean temperature anomaly wrt 1951-80 (Celsius)
smoothTemp  | Five-year lowess smooth of the "No_Smoothing" variable

---

Data file:
- `us_covid_full.csv`
- `us_covid.csv`

Date downloaded: March 2, 2021

Source of downloaded file: The full data set are from the Hopkins data hosted on datahub.io:
https://datahub.io/core/covid-19#resource-us_simplified

The `us_covid.csv` file is the same as the full one but aggregated by state

---

Data file: us_contagious_diseases.csv

Date downloaded: February 14, 2020

Description: Weekly reported counts for seven diseases from 1928 to 2011, from all fifty states.

Source of downloaded file:
- These are from the dslabs R package:
https://www.rdocumentation.org/packages/dslabs/versions/0.7.3

Dictionary:

variable        | description
----------------|----------------------
disease         | A factor containing disease names.
state           | A factor containing state names.
year            | year
weeks_reporting | Number of weeks counts were reported that year.
count           | Total number of reported cases.
population      | State population, interpolated for non-census years.
