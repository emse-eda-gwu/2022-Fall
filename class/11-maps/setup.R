library(knitr)
library(fontawesome)
library(countdown)
library(metathis)
library(tidyverse)
library(ggrepel)
library(cowplot)
library(viridis)
library(here)
library(janitor)

# Libraries specific for mapping
# install.packages('maps')
# install.packages('mapproj')
# install.packages('sf')
# install.packages('rgeos')
# install.packages('rnaturalearth')
# devtools::install_github("ropensci/rnaturalearthhires")
# devtools::install_github("ropensci/rnaturalearthdata")
library(maps)
library(mapproj)
library(sf)
library(rgeos)
library(rnaturalearth)
library(rnaturalearthdata)
library(rnaturalearthhires)

# Read in data sets for class
# Read in data
milk_production <- read_csv(here::here('data', 'milk_production.csv'))
internet_users  <- read_csv(here::here('data', 'internet_users_country.csv'))
us_coffee_shops <- read_csv(here::here('data', 'us_coffee_shops.csv'))

# Filter out coffee shops to continental 48 states
us_coffee_shops <- us_coffee_shops %>%
    filter(lat > 22,    lat < 50,
           long > -150, long < -66)

# Load state_abbs data frame, containing state abbreviations 
source(here::here('data', 'state_abbs.R'))
