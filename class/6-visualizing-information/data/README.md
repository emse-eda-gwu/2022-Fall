
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

Data file: wildlife_impacts.csv

Date downloaded: January 5, 2020

Description: Impacts of wildlife with aircraft by 4 major US airlines

Source of downloaded file:
- The Tidy Tuesday challenge here: https://github.com/rfordatascience/tidytuesday/tree/master/data/2019/2019-07-23
- Here's the link to the original file I downloaded: https://github.com/rfordatascience/tidytuesday/blob/master/data/2019/2019-07-23/wildlife_impacts.csv?raw=true

Original data source:
- FAA wildlife strike database: https://wildlife.faa.gov/home

Notes:
- Note that the wildlife impact data is only from the big 4 airlines - 70% of the full database.
- The data have been pre-processed

Link to full data dictionary:
https://wildlife.faa.gov/downloads/fieldlist.xls

---

Data file:
- nasa_global_temps.txt
- nasa_global_temps.csv

Date downloaded: January 5, 2020

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
year        | year
meanTemp    | Global annual mean temperature anomaly wrt 1951-80 (Celsius)
smoothTemp  | Five-year lowess smooth of the "No_Smoothing" variable
