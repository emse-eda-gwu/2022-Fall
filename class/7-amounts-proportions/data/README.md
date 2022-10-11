---

Data file: avengers.csv

Date downloaded: January 17, 2020

Description: The raw data behind the story "Joining The Avengers Is As Deadly As Jumping Off A Four-Story Building" https://fivethirtyeight.com/features/avengers-death-comics-age-of-ultron/.

Source of downloaded file: These are from the fivethirtyeight R package:
https://www.rdocumentation.org/packages/fivethirtyeight/versions/0.5.0

Dictionary here: https://www.rdocumentation.org/packages/fivethirtyeight/versions/0.5.0/topics/avengers

---

Data files:
- fed_spending_wide.csv
- fed_spending_long.csv

Date downloaded: January 27, 2020

Description: R&D spending by different federal agencies from 1976 to 2017.

Source of downloaded file:
- The fed_spend_orig.csv file was downloaded from this Github repo: https://github.com/rfordatascience/tidytuesday/blob/master/data/2019/2019-02-12/readme.md
- Link to the raw data file: https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2019/2019-02-12/fed_r_d_spending.csv

Original source:
- The original data source is the American Association for the Advancement of Science Historical Trends website: https://www.aaas.org/programs/r-d-budget-and-policy/historical-trends-federal-rd

Notes:
- fed_spending_wide.csv is the same as fed_spending_long.csv but in "wide" format.

Dictionary of fed_spending_long.csv:

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

Data files:
- milk_prod_long.csv
- milk_prod_wide.csv
- milk_production.csv

Date downloaded: January 5, 2020

Description: U.S. Milk production (in pounds) by state from 1970 to 2017

Source of downloaded file:
- The Tidy Tuesday challenge here: https://github.com/rfordatascience/tidytuesday/tree/master/data/2019/2019-01-29
- Here's the link to the original file I downloaded: https://github.com/rfordatascience/tidytuesday/blob/master/data/2019/2019-01-29/state_milk_production.csv

Original data source: The original data source is the USDA (United States Department of Agriculture). See the website here:
https://www.ers.usda.gov/data-products/dairy-data/documentation/#Loc3

Notes:
- milk_prod_wide.csv is the same as milk_prod_long.csv but in "wide" format.

Dictionary for milk_prod_long.csv:

variable      |class     |description
--------------|----------|----------------------
region        |character |Region of the US
year          |date      |Year
milk_produced |double    |Pounds of Milk Produced

---

Data file:
- north_america_bear_killings.csv

Date downloaded: January 15, 2020

Description: Bear killings in the U.S.

Source of downloaded file: https://data.world/makeovermonday/2019w21

Original source: The data was collected, prepared, and distributed by Ali Sanne on data.world.

variable        | description
----------------|----------------------
Name            | Name of victim
age             | Age of victim
gender          | Gender of victim
Date            | Date of incident
Month           | Month of incident
Year            | Year of incident
Type            | type
Location        | Location of incident
Description     | Description of incident
Type of bear    | Type of bear
Hunter          | Whether the victim was a hunter
Grizzly         | Whether the bear was a brizzly
Hikers          | Whether the victim was a hiker
Only one killed | Whether there was only one victim killed

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
