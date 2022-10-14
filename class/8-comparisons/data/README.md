---

Data file: college_all_ages.csv

Date downloaded: January 17, 2020

Description: The raw data behind the story "The Economic Guide To Picking A College Major" https://fivethirtyeight.com/features/the-economic-guide-to-picking-a-college-major/.

Source of downloaded file: These are from the fivethirtyeight R package:
https://www.rdocumentation.org/packages/fivethirtyeight/versions/0.5.0

Dictionary here: https://www.rdocumentation.org/packages/fivethirtyeight/versions/0.5.0/topics/college_all_ages

---

Data files:
- fed_spend_orig.csv
- fed_spend_wide.csv
- fed_spend_long.csv

Date downloaded: January 27, 2020

Description: R&D spending by different federal agencies from 1976 to 2017.

Source of downloaded file:
- The fed_spend_orig.csv file was downloaded from this Github repo: https://github.com/rfordatascience/tidytuesday/blob/master/data/2019/2019-02-12/readme.md
- Link to the raw data file: https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2019/2019-02-12/fed_r_d_spending.csv

Original source:
- The original data source is the American Association for the Advancement of Science Historical Trends website: https://www.aaas.org/programs/r-d-budget-and-policy/historical-trends-federal-rd

Modifications:
- fed_spend_long.csv is the same as fed_spend_orig.csv, except with units of money converted to millions of dollars and with only the R&D spending variable by department and year (the other spending variables are dropped).
- The fed_spend_wide.csv is the same as fed_spend_long.csv but in "wide" format.

Dictionary of fed_spend_orig.csv:

|variable              |class     |description |
|:---|:---|:-----------|
|department            |character | US agency/department          |
|year                  |date/integer   | Fiscal Year           |
|rd_budget             |double    | Research and Development Dollars in inflation-adjusted (constant) dollars           |
|total_outlays         |double    | Total Federal Government spending in inflation-adjusted (constant) dollars         |
|discretionary_outlays |double    | Total Discretionary Federal Government spending in inflation-adjusted (constant) dollars           |
|gdp                   |double    | Total US Gross Domestic Product in inflation-adjusted (constant) dollars         |

Dictionary of fed_spend_long.csv:

|variable              |class     |description |
|:---|:---|:-----------|
|department            |character | US agency/department          |
|year                  |date/integer   | Fiscal Year           |
|rd_budget_mil         |double    | Research and Development Dollars in inflation-adjusted (constant) millions of dollars           |

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


---

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

Data file: `lotr_words.csv`

Date downloaded: January 5, 2020

Description: Words spoken by characters of different races and gender in the Lord of the Rings movie trilogy.

Source of downloaded file:

- Jenny Bryan's Github repo on tidy data: https://github.com/jennybc/lotr-tidy/tree/master/data
- I merged the three separate .csv files for each film into one .csv file.

Original data source:

- Original data file was found here: http://www-958.ibm.com/software/data/cognos/manyeyes/datasets/words-spoken-by-character-race-scene/versions/1.txt
- Note: website above no longer exist.

Dictionary:

variable |class     |description
---------|----------|----------------------
Film     |character |Title of the film
Race     |character |US State
Female   |double    |Number of words spoken by female characters
Male     |double    |Number of words spoken by male characters)

---

Data file: marathon.csv

Date downloaded: January 14, 2020

Description: Data on the finishers of the 2017 Boston Marathon.

Source of downloaded file:
- Downloaded from Kaggle: https://www.kaggle.com/rojour/boston-results/data#
- Original downloaded file name: marathon_results_2017.csv

Original data source:
- Data was scrapped from the official marathon website: http://registration.baa.org/2017/cf/Public/iframe_ResultsSearch.cfm

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
