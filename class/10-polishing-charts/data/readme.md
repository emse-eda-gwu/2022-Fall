# ----------------------------------------------------------------------
Data file: avengers.csv

Date downloaded: January 17, 2020

Description: The raw data behind the story "Joining The Avengers Is As Deadly As Jumping Off A Four-Story Building" https://fivethirtyeight.com/features/avengers-death-comics-age-of-ultron/.

Source of downloaded file:
- These are from the fivethirtyeight R package:
https://www.rdocumentation.org/packages/fivethirtyeight/versions/0.5.0

Dictionary here: https://www.rdocumentation.org/packages/fivethirtyeight/versions/0.5.0/topics/avengers



# ----------------------------------------------------------------------
Data file: candy_rankings.csv

Date downloaded: January 17, 2020

Description: The raw data behind the story "The Ultimate Halloween Candy Power Ranking" https://fivethirtyeight.com/features/the-ultimate-halloween-candy-power-ranking/.

Source of downloaded file:
- These are from the fivethirtyeight R package:
https://www.rdocumentation.org/packages/fivethirtyeight/versions/0.5.0

Dictionary here: https://www.rdocumentation.org/packages/fivethirtyeight/versions/0.5.0/topics/candy_rankings



# ----------------------------------------------------------------------
Data file: college_all_ages.csv

Date downloaded: January 17, 2020

Description: The raw data behind the story "The Economic Guide To Picking A College Major" https://fivethirtyeight.com/features/the-economic-guide-to-picking-a-college-major/.

Source of downloaded file:
- These are from the fivethirtyeight R package:
https://www.rdocumentation.org/packages/fivethirtyeight/versions/0.5.0

Dictionary here: https://www.rdocumentation.org/packages/fivethirtyeight/versions/0.5.0/topics/college_all_ages



# ----------------------------------------------------------------------
Data file: ComicRelief_360Giving_International.xlsx

Date downloaded: January 26, 2020

Description: Comic Relief International grants awarded from Jan '15
to Nov '19.

Source of downloaded file:
- These are from 360giving.org: http://data.threesixtygiving.org/
- Here's the specific link to the file: https://assets.ctfassets.net/zsfivwzfgl3t/4WBPSDLiK9RA2P0qkGJYJR/d9a499329bebe4ebebd8c62587f00700/360_Giving_International.xlsx

Dictionary here: http://standard.threesixtygiving.org/en/latest/reference/#spreadsheet-format



# ----------------------------------------------------------------------
Data files:
- federal_spending_orig.csv
- federal_spending_wide.csv
- federal_spending_long.csv

Date downloaded: January 27, 2020

Description: R&D spending by different federal agencies from 1976 to 2017. Dollar amounts are in units of millions of dollars.

Source of downloaded file:
- The federal_spending_orig.csv file was downloaded from this Github repo: https://github.com/rfordatascience/tidytuesday/blob/master/data/2019/2019-02-12/readme.md
- Link to the raw data file: https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2019/2019-02-12/fed_r_d_spending.csv

Original source:
- The original data source is the American Association for the Advancement of Science Historical Trends website: https://www.aaas.org/programs/r-d-budget-and-policy/historical-trends-federal-rd

Modifications:
- federal_spending_long.csv file is the same as federal_spending_orig.csv except with units of money converted to millions of dollars and with only the R&D spending variable by department and year (the other spending variables are dropped).
- The federal_spending_wide.csv is the same as federal_spending_long.csv but in wide format.

Dictionary of federal_spending.csv:

variable      | class     |description
--------------|-----------|---------------------------------------
department    | character | US agency/department
year          | date/integer   | Fiscal Year
rd_budget     | double    | Research and Development Dollars in **millions** of inflation-adjusted (constant) dollars
total_outlays | double    | Total Federal Government spending in **millions** of inflation-adjusted (constant) dollars
gdp           | double    | Total US Gross Domestic Product in **millions** of inflation-adjusted (constant) dollars

For reference:
* DOD - Deparment of Defense
* NASA - National Aeronautics and Space Administration
* DOE - Department of Energy
* HHS - Department of Health and Human Services
* NIH - National Institute of Health
* NSF - National Science Foundation
* USDA - US Department of Agriculture
* Interior - Department of Interior
* DOT - Deparment of Transportation
* EPA - Environmental Protection Agency
* DOC - Department of Corrections
* DHS - Department of Homeland Security
* VA - Department of Veterands Affairs
* Other - other research and development spending



# ----------------------------------------------------------------------
(Data file: diamonds.csv

Date downloaded: January 15, 2020

Description: A dataset containing the prices and other attributes of almost 54,000 diamonds.

Source of downloaded file:
- Built in dataset that comes with R.
- More info here: https://ggplot2.tidyverse.org/reference/diamonds.html

Dictionary:

Variable  | Description
----------|------------------------------------------------
`carat`   | Weight of the diamond [0.2 - 5.01]
`cut`     | Quality of the cut [Fair (worst), Good, Very Good, Premium, Ideal (best)]
`color`   | Diamond color, from J (worst) to D (best)
`clarity` | A measurement of how clear the diamond is [I1 (worst), SI2, SI1, VS2, VS1, VVS2, VVS1, IF (best)]
`depth`   | Total depth percentage = z / mean(x, y) = 2 * z / (x + y) [43–79]
`table`   | Width of top of diamond relative to widest point [43–95]
`price`   | Price in US dollars [$326 - $18,823]
`x`       | Length in mm [0 – 10.74]
`y`       | Width in mm [0 – 58.9]
`z`       | Depth in mm [0 – 31.8])



# ----------------------------------------------------------------------
Data file: faithful.csv

Date downloaded: January 14, 2020

Description: Waiting time between eruptions and the duration of the eruption for the Old Faithful geyser in Yellowstone National Park, Wyoming, USA.

Source of downloaded file:
- Built in dataset that comes with R.
- More info here: https://stat.ethz.ch/R-manual/R-devel/library/datasets/html/faithful.html

Original data source:
- zzalini, A. and Bowman, A. W. (1990). A look at some data on the Old Faithful geyser. Applied Statistics, 39, 357–365. doi: 10.2307/2347385.

Dictionary:

variable   |class   |description
-----------|--------|----------------------
eruptions  |double  |Eruption time in mins
waiting    |double  |Waiting time to next eruption (in mins)



# ----------------------------------------------------------------------
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



# ----------------------------------------------------------------------
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



# ----------------------------------------------------------------------
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
region     |
year       |
numUsers   | Number of Internet users

Country data:

Variable   | Description
-----------|----------------------------
country    |
year       |
percent    | Percent of population in country using the Internet



# ----------------------------------------------------------------------
Data file: lotr_words.csv

Date downloaded: January 5, 2020

Description: Words spoken by characters of different races and gender in the Lord of the Rings movie trilogy.

Source of downloaded file:
- Jenny Bryan's Github repo on tidy data: https://github.com/jennybc/lotr-tidy/tree/master/data
- I merged the three separate .csv files for each film into one .csv file.

Original data source:
- Original data file was found here: http://www-958.ibm.com/software/data/cognos/manyeyes/datasets/words-spoken-by-character-race-scene/versions/1.txt
- Many Eyes and the website above no longer exist.

Dictionary:

variable |class     |description
---------|----------|----------------------
Film     |character |Title of the film
Race     |character |US State
Female   |double    |Number of words spoken by female characters
Male     |double    |Number of words spoken by male characters



# ----------------------------------------------------------------------
Data file: marathon.csv

Date downloaded: January 14, 2020

Description: Data on the finishers of the 2017 Boston Marathon.

Source of downloaded file:
- Downloaded from Kaggle: https://www.kaggle.com/rojour/boston-results/data#
- Original downloaded file name: marathon_results_2017.csv

Original data source:
- Data was scrapped from the official marathon website: http://registration.baa.org/2017/cf/Public/iframe_ResultsSearch.cfm



# ----------------------------------------------------------------------
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



# ----------------------------------------------------------------------
Data file: msleep.csv

Date downloaded: January 15, 2020

Description: This is an updated and expanded version of the mammals sleep dataset and comes in the ggplot2 package.

Source of downloaded file:
- More info here: https://ggplot2.tidyverse.org/reference/msleep.html
- Updated sleep times and weights were taken from V. M. Savage and G. B. West. A quantitative, theoretical framework for understanding mammalian sleep. Proceedings of the National Academy of Sciences, 104 (3):1051-1056, 2007.

Dictionary:

Variable     | Description
-------------|------------------------------------------------
name         | common name
genus
vore         | carnivore, omnivore or herbivore?
order
conservation | the conservation status of the animal
sleep_total  | total amount of sleep, in hours
sleep_rem    | rem sleep, in hours
sleep_cycle  | length of sleep cycle, in hours
awake        | amount of time spent awake, in hours
brainwt      | brain weight in kilograms
bodywt       | body weight in kilograms



# ----------------------------------------------------------------------
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
year        |
meanTemp    | Global annual mean temperature anomaly wrt 1951-80 (Celsius)
smoothTemp  | Five-year lowess smooth of the "No_Smoothing" variable



# ----------------------------------------------------------------------
Data file: north_america_bear_killings.txt

<need to update>



# ----------------------------------------------------------------------
Data file: pc_sales_2018.xlsx

Date downloaded: January 5, 2020

Description: Annual passenger car sales by country, 2005-2018

Source of downloaded file:
- International Organization of Motor Vehicle Manufacturers
- http://www.oica.net/category/sales-statistics/



# ----------------------------------------------------------------------
Data file: pv_cell_production.xlsx

Date downloaded: January 5, 2020

Description: Annual solar photovoltaics cell production by country, 1995-2013

Source of downloaded file:
- The Earth Policy Institute
- Downloaded file is "book_tgt_solar_9.xlsx" found here: http://www.earth-policy.org/data_center/C23
- Name of file on site is "Annual Solar Photovoltaics Cell Production by Country, 1995-2013"

Original data source:
- The following is copied from the data file itself: "Compiled by Earth Policy Institute (EPI) with 1995-1999 data from Worldwatch Institute, Signposts 2004, CD-ROM (Washington, DC: 2005); 2000 data from Prometheus Institute, "23rd Annual Data Collection - Final," PVNews, vol. 26, no. 4 (April 2007), pp. 8-9; 2001-2006 from Prometheus Institute and Greentech Media, "25th Annual Data Collection Results: PV Production Explodes in 2008," PVNews, vol. 28, no. 4 (April 2009), pp. 15-18; 2007-2013 compiled by Earth Policy Institute from GTM Research, PV Cell Module Production Data, electronic database, updated June 2014."

Dictionary:

variable              |class  |description
----------------------|-------|----------------------
Year                  |double |Year
China - United States |double |Annual solar photovoltaics cell production for each country
Others                |double |Annual solar photovoltaics cell production for all countries other than those in China - United States
World                 |double |World total annual solar photovoltaics cell production



# ----------------------------------------------------------------------
Data file: total_gdp_us_inflation_adjusted.csv

Date downloaded: March 2, 2020

Data source: https://www.gapminder.org/data/



# ----------------------------------------------------------------------
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
year            |
weeks_reporting | Number of weeks counts were reported that year.
count           | Total number of reported cases.
population      | State population, interpolated for non-census years.



# ----------------------------------------------------------------------
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
