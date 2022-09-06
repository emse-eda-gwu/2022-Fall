library(here)
source(here::here('setup.R'))

# joins ------------------------------------------------------

band_members %>% 
    full_join(band_instruments)

band_members 
band_instruments

band_members %>% 
    inner_join(band_instruments)

band_members %>% 
    left_join(band_instruments)

band_members %>% 
    right_join(band_instruments)

band_members %>% 
    full_join(band_instruments)

band_members %>% 
    full_join(band_instruments, by = 'name')

band_members
band_instruments2
band_members %>% 
    full_join(band_instruments2, by = c("name" = "artist"))

milk_production %>% 
    left_join(state_abbs, by = c("state" = "state_name"))

# Practice
state_data <- milk_production %>%
    left_join(state_abbs, by = c('state' = 'state_name')) %>% 
    select(region, state_name = state, state_abb) %>% 
    distinct()

# Add regions & abbreviations to wildlife_impacts 
wildlife_impacts2 <- wildlife_impacts %>%
    left_join(state_data, by = c('state' = 'state_abb')) %>%
    rename(state_abb = state) %>%
    mutate(state_abb = ifelse(state_abb == 'N/A', NA, state_abb))

glimpse(wildlife_impacts2)


# Reading in data - col_types ---------------------------------------------

# https://readxl.tidyverse.org/articles/cell-and-column-types.html

wind <- read_excel(here::here('data', 'US_State_Wind_Energy_Facts_2018.xlsx'),
                   sheet = 'Sheet1', 
                   col_types = c('numeric', 'text', rep('numeric', 5))) %>% 
    clean_names() %>% 
    mutate(state = str_to_title(state))

glimpse(wind)

milk <- read_csv(here::here('data', 'milk_production.csv'), 
                 col_types = cols(year = col_character()))

glimpse(milk)



# renaming variables ---------------------------------------------

# janitor
wind <- read_excel(here::here('data', 'US_State_Wind_Energy_Facts_2018.xlsx'),
                       sheet = 'Sheet1') %>% 
    clean_names()

glimpse(wind)


# select() - more powerful than you probably thought
# 1) simple string matching
ends_with()
contains()

# 2) simple renaming 
hot_dogs <- read_excel(here::here('data', 'hot_dog_winners.xlsx'),
                       sheet = 'hot_dog_winners') %>% 
    clean_names() %>% 
    select(
        year, 
        competitor.mens   = mens,
        competitor.womens = womens, 
        dogs_eaten.mens   = dogs_eaten_3, 
        dogs_eaten.womens = dogs_eaten_6, 
        country.mens      = country_4,
        country.womens    = country_7) 

# 3) multi-column renaming
select(tech_ = starts_with("tr"))
select(everything(), tech_ = starts_with("tr"))


# Recoding variables --------------------------------------------

# ifelse()
wildlife_impacts1 <- wildlife_impacts %>%
    mutate(season = ifelse(
        incident_month %in% c(3, 4, 5), 'spring', ifelse(
        incident_month %in% c(6, 7, 8), 'summer', ifelse(
        incident_month %in% c(9, 10, 11), 'fall', 'winter'))))

# case_when()
wildlife_impacts2 <- wildlife_impacts %>%
    mutate(season = case_when(
        between(incident_month, 3, 5) ~ 'spring',
        between(incident_month, 6, 8) ~ 'summer',
        between(incident_month, 9, 11) ~ 'fall',
        TRUE ~ 'winter'))

# Example 2:
unique(wildlife_impacts$num_engs)
wildlife_impacts3 <- wildlife_impacts %>%
    mutate(num_engs = case_when(
        num_engs == 1 ~ 'one', 
        num_engs == 2 ~ 'two', 
        num_engs == 3 ~ 'three', 
        num_engs == 4 ~ 'four'))
unique(wildlife_impacts3$num_engs)

# Example 3:
unique(wildlife_impacts$phase_of_flt)
wildlife_impacts4 <- wildlife_impacts %>%
    mutate(phase_of_flt = str_to_lower(phase_of_flt))
sort(unique(wildlife_impacts4$phase_of_flt))
wildlife_impacts4 <- wildlife_impacts %>%
    mutate(phase_of_flt = str_to_lower(phase_of_flt)) %>% 
    mutate(phase_of_flt = case_when(
        phase_of_flt %in% c('approach', 'arrival', 'descent', 
                            'landing roll') ~ 'landing', 
        phase_of_flt %in% c('climb', 'departure', 
                            'take-off run') ~ 'take-off', 
        TRUE ~ phase_of_flt))
sort(unique(wildlife_impacts4$phase_of_flt))
        

# separate() - when one column encodes two variables -------------------

tuberculosis_rates <- table3

tuberculosis_rates %>% 
  separate(rate, into = c("cases", "population"))

tuberculosis_rates %>% 
  separate(rate, into = c("cases", "population"), convert = TRUE)

tuberculosis_rates %>% 
  separate(year, into = c("century", "year"), sep = 2)

tuberculosis_rates %>% 
  separate(year, into = c("century", "year"), sep = 2) %>% 
  unite(year_new, century, year)

tuberculosis_rates %>% 
  separate(year, into = c("century", "year"), sep = 2) %>% 
  unite(year_new, century, year, sep = "")

# lubridate ------------------------------------------------

# Practice: 
# 1) Compute the day of attack as a separate variable
# 2) Compute the year of birth of the victim?

# The ONLY thing that matters is the order!
# Create dates from strings 
ymd('2020-02-29')
ymd('2020 Feb 29')
ymd('2020 February 29')
ymd('2020 February 29')
mdy('February 29, 2020')
mdy('Feb. 29, 2020')
dmy('29 Feb. 2020')


# Manipulate dates
date <- today()
year(date)
month(date)
day(date)
wday(date)
wday(date, label = TRUE)

year(date) <- 2016
date

wday(date, label = TRUE)

wildlife_impacts <- wildlife_impacts %>% 
    mutate(day = day(incident_date),
           weekday = wday(incident_date), 
           weekday_name = wday(incident_date, label = TRUE))

wildlife_impacts_2016 <- wildlife_impacts %>% 
    filter(incident_year == 2016) %>% 
    count(weekday_name)

ggplot(wildlife_impacts_2016) + 
    geom_col(aes(x = weekday_name, y = n))


# Strategy: divide & conquer ------------------------------------------------

hot_dogs <- read_excel(here::here('data', 'hot_dog_winners.xlsx'),
                       sheet = 'hot_dog_winners') %>% 
    clean_names() %>% 
    filter(!is.na(mens))

hot_dogs_m <- hot_dogs %>% 
    select(
        year, 
        competitor = mens, 
        dogs_eaten = dogs_eaten_3, 
        country = country_4) %>% 
    mutate(competition = 'Mens')

hot_dogs_w <- hot_dogs %>% 
    select(
        year, 
        competitor = womens, 
        dogs_eaten = dogs_eaten_6, 
        country = country_7) %>% 
    filter(!is.na(competitor)) %>% 
    mutate(competition = 'Womens')

hot_dogs <- bind_rows(hot_dogs_m, hot_dogs_w) %>% 
    mutate(
        new_record = str_detect(dogs_eaten, "\\*"),
        dogs_eaten = parse_number(dogs_eaten),
        year = as.numeric(year))

glimpse(hot_dogs)

# Strategy: gather, separaate, spread --------------------------------------

hot_dogs <- read_excel(here::here('data', 'hot_dog_winners.xlsx'),
                       sheet = 'hot_dog_winners') %>% 
    clean_names() %>% 
    filter(!is.na(mens)) %>% 
    select(
        year, 
        competitor.mens   = mens,
        competitor.womens = womens, 
        dogs_eaten.mens   = dogs_eaten_3, 
        dogs_eaten.womens = dogs_eaten_6, 
        country.mens      = country_4,
        country.womens    = country_7) %>% 
    gather(key = 'variable', value = 'value', 
           competitor.mens:country.womens) %>% 
    separate(variable, into = c('variable', 'competition'), 
             sep = '\\.') %>% 
    spread(key = variable, value = value) %>% 
    mutate(
        new_record = str_detect(dogs_eaten, "\\*"),
        dogs_eaten = parse_number(dogs_eaten), 
        year       = as.numeric(year)) %>% 
    arrange(competition, year) 
    
glimpse(hot_dogs)


# Strategy: manual filtering with passenger car sales ----------------

regions <- c(
    'EUROPE', 'EU 28 countries + EFTA', 'EU 15 countries + EFTA',
    'EUROPE NEW MEMBERS', 'RUSSIA, TURKEY & OTHER EUROPE', 'AMERICA',
    'NAFTA', 'CENTRAL & SOUTH AMERICA', 'ASIA/OCEANIA/MIDDLE EAST',
    'AFRICA', 'ALL COUNTRIES')

pc_sales <- read_excel(here::here('data', 'pc_sales_2018.xlsx'),
                       sheet = 'pc_sales', skip = 5)

pc_sales <- pc_sales %>%
    gather(key = 'year', value = 'num_cars', `2005`:`2018`) %>%
    clean_names() %>%
    select(country = regions_countries, year, num_cars) %>%
    filter(! country %in% regions,
           !is.na(country)) %>%
    mutate(
        country = str_to_title(country),
        year = as.numeric(year),
        num_cars = num_cars / 10^6)

ggplot(pc_sales %>% filter(country %in% c(
    "United States Of America", "China"))) +
    geom_line(aes(x = year, y = num_cars, color = country)) +
    theme_half_open()

# Case study: Weather ------------------------------------------------

weather <- readRDS(here::here('data', 'weather.Rds'))

weather <- weather %>%
    # 1) Column names are values: X1:X31 should be "days"
    gather(key = 'day', value = 'val', X1:X31) %>% 
    # 2) Row numbers are a variable
    select(-X) %>% 
    # 3) Values are variable names 
    spread(key = measure, value = val) %>% 
    # 4) Clean up the dates 
    mutate(
        day = as.numeric(str_replace(day, 'X', '')),
        date = str_c(year, month, day, sep = "-"), 
        date = ymd(date)) %>% 
    # 5) Rearrange column order 
    select(date, year, month, day, Events, CloudCover:WindDirDegrees) %>% 
    # 6) Convert strings to numbers - use View(weather)
    mutate(PrecipitationIn = ifelse(PrecipitationIn == 'T', 0, PrecipitationIn)) %>% 
    mutate_at(vars(CloudCover:WindDirDegrees), as.numeric) %>% 
    # 7) Fix column names 
    clean_names()

glimpse(weather)    

# Find missing values
summary(weather)

# Fix errors
weather %>% filter(mean_visibility_miles < 0)
weather %>% filter(max_humidity > 100)
unique(weather$events)
weather <- weather %>% 
    mutate(
        mean_visibility_miles = if_else(
            mean_visibility_miles < 0, median(mean_visibility_miles), 
            mean_visibility_miles),
        max_humidity = if_else(max_humidity > 100, 100, max_humidity),
        events = if_else(events == '', 'None', events))

glimpse(weather)

# Case study: PV Cells ------------------------------------------------

pv_cells <- read_excel(here::here('data', 'pv_cell_production.xlsx'),
                       sheet = 'Cell Prod by Country', skip = 2, 
                       col_types = 'numeric') %>% 
    filter(! is.na(Year)) %>% 
    gather(key = 'country', value = 'n', China:Others) %>% 
    select(-World)

glimpse(pv_cells)
