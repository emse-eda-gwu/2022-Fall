source('setup.R')

# Projections 

# Albers
# "ESRI:102003"

# Robinson
# "ESRI:54030"
# "+proj=robin"

# https://ggplot2-book.org/maps.html

# Polygon maps -----------------------------------------------------
# https://www.r-graph-gallery.com/map.html

# Polygon maps
world <- map_data("world")
polygon_world <- ggplot(world,
       aes(x = long, y = lat, group = group)) +
    geom_polygon(fill = "grey90", color = "grey60")

ggsave(here::here('images', 'plots', 'polygon_world.png'),
       polygon_world, width = 6, height = 3.7)

us_states <- map_data("state")
polygon_us <- ggplot(us_states,
       aes(x = long, y = lat, group = group)) +
    geom_polygon(fill = "grey90", color = "grey60")

ggsave(here::here('images', 'plots', 'polygon_us.png'),
       polygon_us, width = 6, height = 3.7)

# Simple features maps -----------------------------------------------------

# World
world <- ne_countries(scale = "medium", returnclass = "sf")

sf_world <- ggplot(data = world) +
    geom_sf(fill = 'grey90', color = 'grey60')

ggsave(here::here('images', 'plots', 'sf_world.png'),
       sf_world, width = 6, height = 3.7)

# ggplot(data = world) +
#     geom_sf(aes(fill = pop_est)) +
#     scale_fill_viridis_c(option = "plasma", trans = "sqrt")

# US States
us_states <- ne_states(
    country = 'united states of america',
    returnclass = 'sf')

sf_us <- ggplot(data = us_states) +
    geom_sf(fill = 'grey90', color = 'grey60')

ggsave(here::here('images', 'plots', 'sf_us.png'),
       sf_us, width = 6, height = 3.7)

# US States, continental
us_states_cont <- ne_states(
    country = 'united states of america',
    returnclass = 'sf') %>%
    filter(! name %in% c('Alaska', 'Hawaii'))

sf_us_cont <- ggplot(data = us_states_cont) +
    geom_sf(fill = 'grey90', color = 'grey60')

ggsave(here::here('images', 'plots', 'sf_us_cont.png'),
       sf_us_cont, width = 6, height = 3.7)

# US Counties
library(maps)

us_counties <- st_as_sf(map("county", plot = FALSE, fill = TRUE))

sf_us_counties <- ggplot(data = us_counties) +
    geom_sf(fill = 'grey90', color = 'grey60')

ggsave(here::here('images', 'plots', 'sf_us_counties.png'),
       sf_us_counties, width = 6, height = 3.7)

sf_us_counties_albers <- ggplot(data = us_counties) +
    geom_sf(fill = 'grey90', color = 'grey60') +
    coord_sf(crs = "ESRI:102003")

ggsave(here::here('images', 'plots', 'sf_us_counties_albers.png'),
       sf_us_counties_albers, width = 6, height = 3.7)

# China
china <- ne_states(
    country = 'china',
    returnclass = 'sf')

sf_china <- ggplot(data = china) +
    geom_sf(fill = 'grey90', color = 'grey60')

ggsave(here::here('images', 'plots', 'sf_china.png'),
       sf_china, width = 6, height = 3.7)

# Africa
world <- ne_countries(scale = "medium", returnclass = "sf")
africa <- world %>% 
    filter(continent == 'Africa')

sf_africa <- ggplot(data = africa) +
    geom_sf(fill = 'grey90', color = 'grey60')

ggsave(here::here('images', 'plots', 'sf_africa.png'),
       sf_africa, width = 6, height = 3.7)


# Read shape file --------------------------------------------------------

world <- st_read(here::here(
    'data', 'natural_earth_countries',
    'ne_50m_admin_0_countries.shp')) %>%
    clean_names()

ggplot(data = world) +
    geom_sf(fill = 'grey90', color = 'grey60') 

central_park <- st_read(here::here(
    'data', 'central_park', 'CentralPark.shp'))

sf_central_park <- ggplot(data = central_park) +
    geom_sf(color = 'grey75')

ggsave(here::here('images', 'plots', 'sf_central_park.png'),
       sf_central_park, width = 8, height = 7)

# Projections Polygons --------------------------------------------------------

us_states <- map_data("state")
polygon_us <- ggplot(us_states,
       aes(x = long, y = lat, group = group)) +
    geom_polygon(fill = "grey90", color = "grey60")

polygon_us +
    coord_map(projection = "albers", lat0 = 39, lat1 = 45)


# Projections sf --------------------------------------------------------

# World
world <- ne_countries(scale = "medium", returnclass = "sf")

sf_world_robinson <- ggplot(data = world) +
    geom_sf() +
    coord_sf(crs = "ESRI:54030")

ggsave(here::here('images', 'plots', 'sf_world_robinson.png'),
       sf_world_robinson, width = 6, height = 3.7)

sf_world_mollweide <- ggplot(data = world) +
    geom_sf() +
    coord_sf(crs = "ESRI:54009")

ggsave(here::here('images', 'plots', 'sf_world_mollweide.png'),
       sf_world_mollweide, width = 6, height = 3.7)

# North America, Albers projection
us_states_cont <- ne_states(
    country = 'united states of america',
    returnclass = 'sf') %>%
    filter(! name %in% c('Alaska', 'Hawaii'))

sf_us_cont_albers <- ggplot(data = us_states_cont) +
    geom_sf() +
    coord_sf(crs = "ESRI:102003")

ggsave(here::here('images', 'plots', 'sf_us_cont_albers.png'),
       sf_us_cont_albers, width = 6, height = 3.7)

sf_us_cont_nad83 <- ggplot(data = us_states_cont) +
    geom_sf() +
    coord_sf(crs = 4269)

ggsave(here::here('images', 'plots', 'sf_us_cont_nad83.png'),
       sf_us_cont_nad83, width = 6, height = 3.7)

sf_us_cont_merc <- ggplot(data = us_states_cont) +
    geom_sf() +
    coord_sf(crs = "ESRI:54004")

ggsave(here::here('images', 'plots', 'sf_us_cont_merc.png'),
       sf_us_cont_merc, width = 6, height = 3.7)

sf_us_cont_robinson <- ggplot(data = us_states_cont) +
    geom_sf() +
    coord_sf(crs = "ESRI:54030")

ggsave(here::here('images', 'plots', 'sf_us_cont_robinson.png'),
       sf_us_cont_robinson, width = 6, height = 3.7)

# China 
china <- ne_states(
    country = 'china',
    returnclass = 'sf')

china_crs <- '+proj=robin +datum=WGS84'
sf_china_proj <- ggplot(data = china) +
    geom_sf() +
    coord_sf(crs = st_crs(china_crs))

ggsave(here::here('images', 'plots', 'sf_china_proj.png'),
       sf_china_proj, width = 6, height = 3.7)

# Choropleth milk -------------------------------------------------------
# https://www.r-graph-gallery.com/327-chloropleth-map-from-geojson-with-ggplot2.html

# Milk 2017
milk_2017 <- milk_production %>% 
    filter(year == 2017) %>% 
    select(name = state, milk_produced) %>% 
    mutate(milk_produced = milk_produced / 10^9)

# US States, continental data
us_states <- ne_states(
    country = 'united states of america',
    returnclass = 'sf') %>%
    filter(! name %in% c('Alaska', 'Hawaii')) %>% 
    left_join(milk_2017, by = 'name')

# Milk fill
sf_us_milk_2017 <- ggplot(us_states) +
    geom_sf(aes(fill = milk_produced)) + #<<
    scale_fill_viridis(
        option = "plasma", 
        limits = c(0, 40)) +
    theme_void(base_size = 15) +
    theme(legend.position = 'bottom') +
    labs(fill = 'Milk produced\n(billions lbs)', 
         title = 'Milk Production by State in 2017')

ggsave(here::here('images', 'plots', 'sf_us_milk_2017.png'),
       sf_us_milk_2017, width = 6, height = 3.7)

# Milk fill quad
sf_us_milk_2017_quad <- ggplot(us_states) +
    geom_sf(aes(fill = milk_produced)) + #<<
    scale_fill_viridis(
        trans = 'sqrt',
        option = "plasma", 
        limits = c(0, 40)) +
    theme_void(base_size = 15) +
    theme(legend.position = 'bottom') +
    labs(fill = 'Milk produced\n(billions lbs)', 
         title = 'Milk Production by State in 2017')

ggsave(here::here('images', 'plots', 'sf_us_milk_2017_quad.png'),
       sf_us_milk_2017_quad, width = 6, height = 3.7)

# Albers projection
sf_us_milk_2017_albers <- ggplot(us_states) +
    geom_sf(aes(fill = milk_produced)) +
    coord_sf(crs = "ESRI:102003") +
    scale_fill_viridis(
        option = "plasma", 
        limits = c(0, 40)) +
    theme_void(base_size = 15) +
    theme(legend.position = 'bottom') +
    labs(fill = 'Milk produced\n(billions lbs)', 
         title = 'Milk Production by State in 2017')

ggsave(here::here('images', 'plots', 'sf_us_milk_2017_albers.png'),
       sf_us_milk_2017_albers, width = 6, height = 3.7)
# 
# # Animation...broken
# milk_years <- milk_production %>% 
#     select(name = state, year, milk_produced) %>% 
#     mutate(milk_produced = milk_produced / 10^9,
#            year = as.integer(year))
# 
# us_states <- ne_states(
#     country = 'united states of america',
#     returnclass = 'sf') %>%
#     filter(! name %in% c('Alaska', 'Hawaii')) %>% 
#     right_join(milk_years, by = 'name')
# 
# us_milk_anim_plot <- ggplot(us_states) +
#     geom_sf(aes(fill = milk_produced)) +
#     scale_fill_viridis(
#         option = "plasma", 
#         limits = c(0, 40)) +
#     theme_void(
#         base_size = 15,
#         base_family = 'Roboto Condensed') +
#     theme(legend.position = 'bottom') +
#     labs(fill = 'Milk produced (billions lbs)', 
#          title = 'Milk Production by State')
# 
# library(gganimate)
# 
# us_milk_anim_plot +
#     transition_time(year) 
# 
# us_milk_anim <- us_milk_anim_plot +
#     transition_time(year)
# labs(title = "Year: {frame_time}")
# 
# # transition_reveal(year)
# 
# # Render the animation
# animate(us_milk_anim, end_pause = 10,
#         width = 800, height = 600, res = 150)



# Choropleth internet -------------------------------------------------------

internet_users_2015 <- internet_users %>% 
    filter(year == 2015)

world <- ne_countries(scale = "medium", returnclass = "sf")

# Join internet user data to world shape file
world_int <- world %>% 
    left_join(internet_users_2015, by = c('iso_a3' = 'code')) %>% 
    filter(iso_a3 != "ATA")  # No internet in Antarctica...sorry penguins.

# Base map 
sf_world_internet <- ggplot(world_int) +
    geom_sf(aes(fill = percent), color = NA) +
    scale_fill_gradient(
        low = "#e7e1ef",
        high = "#dd1c77",
        na.value = "grey70",
        limits = c(0, 100)) +
    guides(fill = guide_colorbar(
        title.position = "top",
        title.hjust = 0.5,
        barwidth = 10, barheight = 0.5)) +
    theme_void() +
    theme(
        legend.position = 'bottom',
        plot.title = element_text(hjust = 0.5)) +
    labs(
        title = "Internet access by country in 2015",
        fill = '% of population with access')

# Robinson
sf_world_internet_robinson <- sf_world_internet +
    coord_sf(crs = "ESRI:54030")

# Mercator
sf_world_internet_mercator <- sf_world_internet +
    coord_sf(crs = "ESRI:54004")

ggsave(here::here('images', 'plots', 'sf_world_internet.png'),
       sf_world_internet, width = 6, height = 3.7)

ggsave(here::here('images', 'plots', 'sf_world_internet_robinson.png'),
       sf_world_internet_robinson, width = 6, height = 3.7)

ggsave(here::here('images', 'plots', 'sf_world_internet_mercator.png'),
       sf_world_internet_mercator, width = 6, height = 3.7)



# Bubble map - England -------------------------------------------------------
# https://www.r-graph-gallery.com/330-bubble-map-with-ggplot2.html

uk_shape <- map_data("world") %>%
    filter(region == "UK")

uk_cities <- world.cities %>%
    filter(country.etc == "UK") %>%
    mutate(pop = pop / 10^6) %>%
    arrange(pop)

uk_top10cities <- uk_cities %>%
    arrange(desc(pop)) %>%
    slice(1:10)

# All cities as points
ggplot() +
    geom_polygon(data = uk_shape,
                 aes(x = long, y = lat, group = group),
                 fill = "grey", alpha = 0.3) +
    geom_point(data = uk_cities,
               aes(x = long, y = lat)) +
    scale_y_continuous(limits = c(50, 59)) +
    coord_map() +
    theme_void()

# Second graphic with names of the 10 biggest cities
uk_cities_plot <- ggplot() +
    geom_polygon(data = uk_shape,
                 aes(x = long, y = lat, group = group),
                 fill = "grey60", alpha = 0.3) +
    geom_point(data = uk_top10cities,
               aes(x = long, y = lat)) +
    geom_text_repel(data = uk_top10cities,
                    aes(x = long, y = lat, label = name),
                    size = 5) +
    geom_point(data = uk_top10cities,
               aes(x = long, y = lat),
               color = "red", size = 3) +
    scale_y_continuous(limits = c(50, 59)) +
    coord_map() +
    theme_void()

ggsave(here::here('images', 'plots', 'uk_cities_plot.png'),
       uk_cities_plot, width = 4.5, height = 4.5)

# Now all cities with population and color scale
ggplot() +
    geom_polygon(data = uk_shape,
                 aes(x = long, y = lat, group = group),
                 fill = "grey", alpha = 0.3) +
    geom_point(data = uk_cities,
               aes(x = long, y = lat,
                   size = pop, color = pop),
               alpha = 0.9) +
    scale_size_area() +
    scale_color_viridis(trans = 'log') +
    scale_y_continuous(limits = c(50, 59)) +
    coord_map() +
    theme_void()

# Same as above but polished
mybreaks <- c(0.02, 0.04, 0.08, 1, 7)

uk_pop_area <- ggplot() +
    geom_polygon(data = uk_shape,
                 aes(x = long, y = lat, group = group),
                 fill = "grey70", alpha = 0.3) +
    geom_point(data = uk_cities,
               aes(x = long, y = lat,
                   size = pop, color = pop),
               alpha = 0.9) +
    scale_size(range = c(0.02, 7), breaks = mybreaks) +
    scale_alpha_continuous(
        trans="log", range = c(0.1, 0.9), breaks = mybreaks) +
    scale_color_viridis(
        option = "magma", trans = "log", breaks = mybreaks) +
    scale_y_continuous(limits = c(50, 59)) +
    guides( colour = guide_legend()) +
    coord_map() +
    theme_void(base_family = 'Roboto Condensed') +
    theme(legend.position = c(0.95, 0.7)) +
    labs(size = "Population\n(in Millions)",
         alpha = "Population\n(in Millions)",
         color = "Population\n(in Millions)",
         title = "The 1000 most populous cities in the UK")

uk_pop_radius <- uk_pop_area +
    scale_radius(range = c(0.02, 7), breaks = mybreaks)

ggsave(here::here('images', 'plots', 'uk_pop_area.png'),
       uk_pop_area, width = 4.5, height = 4.5)

ggsave(here::here('images', 'plots', 'uk_pop_radius.png'),
       uk_pop_radius, width = 4.5, height = 4.5)

# Bubble map squirrels ------------------------------------------------------

central_park <- st_read(here::here(
    'data', 'central_park', 'CentralPark.shp'))
squirrels <- read_csv(here::here('data', 'nyc_squirrels.csv'))

squirrels <- squirrels %>% 
    filter(!is.na(primary_fur_color))

sf_central_park_squirrels <- ggplot(data = central_park) +
    geom_sf(color = 'grey75') + 
    geom_point(data = squirrels,
        aes(x = long, y = lat, color = primary_fur_color),
               size = .5) + 
    theme_void(base_size = 15) +
    theme(legend.position = 'bottom') +
    guides(color = guide_legend(title.position = "top")) +
    labs(color = 'Primary fur color', 
         title = 'Squirrels in NYC Central Park')

ggsave(here::here('images', 'plots', 'sf_central_park_squirrels.png'),
       sf_central_park_squirrels, width = 8, height = 7)

# Facets
sf_central_park_squirrels_facet <- ggplot(data = central_park) +
    geom_sf(color = 'grey75') + 
    geom_point(data = squirrels,
        aes(x = long, y = lat, color = primary_fur_color),
               size = .5) +
    facet_wrap(~primary_fur_color, nrow = 1) +
    theme_void(base_size = 15) +
    theme(legend.position = 'none',
          plot.title = element_text(hjust = 0.5)) +
    labs(title = 'Squirrels in NYC Central Park')

ggsave(here::here('images', 'plots', 'sf_central_park_squirrels_facet.png'),
       sf_central_park_squirrels_facet, width = 10, height = 4)



# Coffee maps ----------------------------------------------------

# US States, continental data
us_states_cont <- ne_states(
    country = 'united states of america',
    returnclass = 'sf') %>%
    filter(! name %in% c('Alaska', 'Hawaii'))

# Directly plot points
sf_us_coffee <- ggplot() +
    geom_sf(data = us_states_cont) +
    geom_point(
        data = us_coffee_shops,
        aes(x = long, y = lat, color = name),
        size = 0.3) + 
    theme_void(base_size = 15) +
    theme(legend.position = 'bottom') +
    guides(color = guide_legend(
        # Move legend title to top
        title.position = "top",
        # Increase legend point size
        override.aes = list(size = 3))) +
    labs(color = 'Coffee shop', 
         title = 'Coffee Shops in the US')

ggsave(here::here('images', 'plots', 'sf_us_coffee.png'),
       sf_us_coffee, width = 9, height = 6)

# Plot points with Albers projection
sf_us_coffee_albers_bad <- sf_us_coffee +
    coord_sf(crs = "ESRI:102003")

ggsave(here::here('images', 'plots', 'sf_us_coffee_albers_bad.png'),
       sf_us_coffee_albers_bad, width = 9, height = 6)

# First convert coordinate system of coffee shops
us_coffee_shops_sf <- st_as_sf(us_coffee_shops,
    coords = c("long", "lat"),
    crs = st_crs(us_states_cont))

# Now plot both
sf_us_coffee_base <- ggplot() +
    geom_sf(data = us_states_cont) +
    geom_sf(
        data = us_coffee_shops_sf,
        aes(color = name), 
        size = 0.3) +
    theme_void(base_size = 15) +
    theme(legend.position = 'bottom') +
    guides(color = guide_legend(
        # Move legend title to top
        title.position = "top",
        # Increase legend point size
        override.aes = list(size = 3))) +
    labs(fill = 'Coffee shop', 
         title = 'Coffee Shops in the US')

ggsave(here::here('images', 'plots', 'sf_us_coffee_base.png'),
       sf_us_coffee_base, width = 9, height = 6)

# Now add the albers CRS
sf_us_coffee_albers <- sf_us_coffee_base +
    coord_sf(crs = "ESRI:102003")

ggsave(here::here('images', 'plots', 'sf_us_coffee_albers.png'),
       sf_us_coffee_albers, width = 9, height = 6)

# LCC projection
sf_us_coffee_lcc <- sf_us_coffee_base +
    coord_sf(crs = "ESRI:102004") 

ggsave(here::here('images', 'plots', 'sf_us_coffee_lcc.png'),
       sf_us_coffee_lcc, width = 9, height = 6)


# State centroid map ------------------------------------------------------

# US States, continental data
us_states_cont <- ne_states(
    country = 'united states of america',
    returnclass = 'sf') %>%
    filter(! name %in% c('Alaska', 'Hawaii')) %>% 
    st_transform(crs = "ESRI:102003")

# Compute centroids of each state
centroids <- as.data.frame(
    st_coordinates(st_centroid(us_states_cont)))
names(centroids) <- c('label_x', 'label_y')
us_states_cont <- bind_cols(us_states_cont, centroids) %>% 
    left_join(state_abbs, by = c('name' = 'state_name'))

# Make the plot 
sf_us_labeled <- ggplot(us_states_cont) +
    geom_sf() + 
    geom_label(aes(x = label_x, y = label_y, label = state_abb)) +
    theme_void(base_size = 15)
    
ggsave(here::here('images', 'plots', 'sf_us_labeled.png'),
       sf_us_labeled, width = 9, height = 5.5)


# Hexbin map -----------------------------------------------------------
# https://www.r-graph-gallery.com/hexbin-map.html
# Also statebins: http://socviz.co/maps.html#maps



# OTHER ----------------------------------------------------------------



# sf & spatial ------------------------------------------------------------
# https://www.r-spatial.org/r/2018/10/25/ggplot2-sf.html


# andrew - world projections ----------------------------------------------------------------
# https://datavizf17.classes.andrewheiss.com/assignment/07-assignment/

int_users_2015 <- internet_users %>%
    filter(year == 2015)

world_shapes <- st_read(here::here(
    'data', 'natural_earth_countries', 'ne_50m_admin_0_countries.shp'),
    stringsAsFactors = FALSE) %>%
    clean_names()

int_users_2015 <- world_shapes %>%
    left_join(int_users_2015, by = c('iso_a3' = 'code')) %>%
    filter(iso_a3 != "ATA")  # No internet in Antarctica...sorry penguins.

ggplot(int_users_2015) +
    geom_sf(aes(fill = percent), color = NA) +
    coord_sf(crs = "ESRI:54030", datum = NA) +
    scale_fill_gradient(
        low = "#e7e1ef",
        high = "#dd1c77",
        na.value = "grey70",
        limits = c(0, 100)) +
    guides(fill = guide_colorbar(
        title.position = "top",
        title.hjust = 0.5,
        barwidth = 10, barheight = 0.5)) +
    theme_void() +
    theme(legend.position = "bottom") +
    labs(fill = '% of population')

# internet animation ----------------------------------------------------------
# https://ourworldindata.org/internet

# Map insets ----------------------------------------------------------
# https://www.r-spatial.org/r/2018/10/25/ggplot2-sf-3.html

# Polygon election ----------------------------------------------------
# http://socviz.co/maps.html#maps

library(socviz)

us_states <- map_data("state")
head(us_states)

ggplot(us_states,
    aes(x = long, y = lat, group = group)) +
    geom_polygon(fill = "white", color = "black")

ggplot(us_states,
    aes(x = long, y = lat, group = group,
        fill = region)) +
    geom_polygon(color = "grey90", size = 0.1) +
    theme(legend.position = 'none')

ggplot(us_states,
       aes(x = long, y = lat, group = group,
           fill = region)) +
    geom_polygon(color = "grey90", size = 0.1) +
    coord_map(projection = "albers", lat0 = 39, lat1 = 45) +
    theme(legend.position = 'none')

election$region <- tolower(election$state)
us_states_elec <- left_join(us_states, election)
party_colors <- c("#2E74C0", "#CB454A")

ggplot(us_states_elec,
       aes(x = long, y = lat,
           group = group, fill = party)) +
    geom_polygon(color = "gray90", size = 0.1) +
    coord_map(projection = "albers", lat0 = 39, lat1 = 45) +
    scale_fill_manual(values = party_colors) +
    theme_void() +
    labs(title = "Election Results 2016", fill = NULL)

ggplot(us_states_elec,
       aes(x = long, y = lat,
           group = group, fill = pct_trump)) +
    geom_polygon(color = "gray90", size = 0.1) +
    coord_map(projection = "albers", lat0 = 39, lat1 = 45) +
    scale_fill_gradient(low = "white", high = "#CB454A") +
    theme_void()
    labs(title = "Trump vote",
         fill = "Percent")

ggplot(us_states_elec,
       aes(x = long, y = lat,
           group = group, fill = d_points)) +
        geom_polygon(color = "gray90", size = 0.1) +
        coord_map(projection = "albers", lat0 = 39, lat1 = 45) +
        scale_fill_gradient2(
            low = "red",
            mid = scales::muted("purple"),
            high = "blue",
            breaks = c(-25, 0, 25, 50, 75)) +
        theme_void() +
        labs(title = "Winning margins",
             fill = "Percent")

ggplot(us_states_elec %>%
           filter(! region %in% "district of columbia"),
       aes(x = long, y = lat,
           group = group, fill = d_points)) +
    geom_polygon(color = "gray90", size = 0.1) +
    coord_map(projection = "albers", lat0 = 39, lat1 = 45) +
    scale_fill_gradient2(
        low = "red",
        mid = scales::muted("purple"),
        high = "blue") +
    theme_void() +
    labs(title = "Winning margins",
         fill = "Percent")

# Polygon population -------------------------------------------------
# http://socviz.co/maps.html#maps

county_full <- county_map %>%
    left_join(county_data, by = "id") %>%
    mutate(
        pop_dens = fct_recode(pop_dens,
            "0-10"        = "[    0,   10)",
            "10-50"       = "[   10,   50)",
            "50-100"      = "[   50,  100)",
            "100-500"     = "[  100,  500)",
            "500-1,000"   = "[  500, 1000)",
            "1,000-5,000" = "[ 1000, 5000)",
            ">5,000"      = "[ 5000,71672]"))

ggplot(county_full,
    aes(x = long, y = lat,
        fill = pop_dens, group = group)) +
    geom_polygon(color = "gray90", size = 0.05) +
    coord_equal() +
    scale_fill_brewer(palette="Blues") +
    guides(fill = guide_legend(nrow = 1)) +
    theme_void() +
    theme(legend.position = "bottom") +
    labs(fill = "Population per\nsquare mile")

ggplot(county_full,
    aes(x = long, y = lat,
        fill = pct_black, group = group)) +
    geom_polygon(color = "gray90", size = 0.05) +
    coord_equal() +
    scale_fill_brewer(palette="Greens") +
    guides(fill = guide_legend(nrow = 1)) +
    theme_void() +
    theme(legend.position = "bottom") +
    labs(fill = "US Population, Percent Black")




# Animation reprex -------------------------------------------------

library(ggplot2)
library(gganimate)

us_states <- ne_states(
    country = 'united states of america',
    returnclass = 'sf') %>%
    filter(! name %in% c('Alaska', 'Hawaii'))

fill_data <- data.frame(
    name = rep(us_states$name, 2), 
    year = c(rep(2000, nrow(us_states)), rep(2001, nrow(us_states))),
    fill = rnorm(2*nrow(us_states)))

us_states <- left_join(us_states, fill_data, by = 'name')

# Static works :)
ggplot(us_states) + 
    geom_sf(aes(fill = fill))

# Animation fails :(
ggplot(us_states) + 
    geom_sf(aes(fill = fill)) + 
    transition_time(year)

