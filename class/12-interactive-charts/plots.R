
library(knitr)
library(tidyverse)
library(fontawesome)
library(plotly)
library(rnaturalearth)
library(rnaturalearthhires)
library(leaflet)
library(DT)
library(reactable)
library(reactablefmtr)
library(sparkline)

# Read in data sets for class
gapminder <- read_csv(here::here("data", "gapminder.csv"))
coffee_shops <- read_csv(here::here("data", "us_coffee_shops.csv"))
milk_production <- read_csv(here::here('data', 'milk_production.csv'))
internet_users <- read_csv(here::here('data', 'internet_users_country.csv'))

# Process 
dc_coffee_shops <- coffee_shops %>%
  filter(state == "District of Columbia")
milk_2017 <- milk_production %>%
  filter(year == 2017) %>%
  select(name = state, milk_produced) %>%
  mutate(milk_produced = milk_produced / 10^9)
state_milk <- ne_states(
  country = 'united states of america',
  returnclass = 'sf') %>%
  left_join(milk_2017, by = 'name') %>%
  mutate(label = paste(
    name, ": ", round(milk_produced, 2), " B lbs", sep = "")) 
world_internet_2015 <- ne_countries(
  scale = "medium", returnclass = "sf") %>% 
  select(code = iso_a3) %>% 
  left_join(internet_users, by = "code") %>% 
  filter(year == 2015)

# Use ggplotly -------

plot <- gapminder %>%
  filter(year == 2007) %>%
  ggplot(
    aes(x = gdpPercap, y = lifeExp,
    size = pop, color = continent,
    label = country)) +
  geom_point(alpha = 0.7) +
  scale_color_brewer(palette = 'Set2') +
  scale_size_area(
    guide = FALSE, max_size = 15) +
  scale_x_log10() +
  theme_bw(base_size = 16) +
  labs(x = 'GDP per capita',
       y = 'Life expectancy',
       color = 'Continent')

# Save
htmlwidgets::saveWidget(
  ggplotly(plot),
  here::here('figs', 'gapminder.html')
)

htmlwidgets::saveWidget(
  ggplotly(plot, tooltip = c("country", "pop")),
  here::here('figs', 'gapminder_tooltip.html')
)

htmlwidgets::saveWidget(
  ggplotly(plot, tooltip = c("country", "pop")) %>%
  layout(legend = list(orientation = "h", x = 0, y = -0.3)),
  here::here('figs', 'gapminder_legend.html')
)

# Use plot_ly -------

gapminder_plot_ly <- plot_ly(
  data = gapminder %>% filter(year == 2007),
  x = ~gdpPercap,
  y = ~lifeExp,
  size = ~pop,
  color = ~continent,
  text = ~country,
  mode = "markers",
  sizes = c(10, 1000),
  marker = list(opacity = 0.5),
  type = 'scatter',
  hoverinfo = "text"
  ) %>%
  layout(xaxis = list(type = "log"))

gapminder_plot_ly_anim <- plot_ly(
  data = gapminder,
  x = ~gdpPercap,
  y = ~lifeExp,
  size = ~pop,
  color = ~continent,
  text = ~country,
  frame = ~year,
  mode = "markers",
  sizes = c(10, 1000),
  marker = list(opacity = 0.5),
  type = 'scatter',
  hoverinfo = "text"
  ) %>%
  layout(xaxis = list(type = "log"))

# Save
htmlwidgets::saveWidget(
  gapminder_plot_ly,
  here::here('figs', 'gapminder_plot_ly.html')
)

htmlwidgets::saveWidget(
  gapminder_plot_ly_anim,
  here::here('figs', 'gapminder_plot_ly_anim.html')
)

# Leaflet --------

# Coffee points -------

pal <- colorFactor(
  palette = "Set2",
  levels  = c(
    "Starbucks",
    "Dunkin' Donuts",
    "Peet's Coffee & Tea",
    "Baskin Robbins",
    "The Coffee Bean & Tea Leaf"))

coffee_map <- leaflet(data = dc_coffee_shops) %>%
  addProviderTiles(providers$CartoDB.DarkMatter) %>%
  addCircleMarkers(
    lng = ~long,
    lat = ~lat,
    popup = ~name,
    color = ~pal(name),
    radius = 2) %>%
  addLegend(
    position = "bottomright",
    pal = pal,
    values = ~name,
    title = "Coffee Shop",
    opacity = 1)

htmlwidgets::saveWidget(
  coffee_map,
  here::here('figs', 'coffee_map.html')
)

# Milk Choropleth -------

pal <- colorBin(
  palette = "YlOrRd",
  bins = round(seq(0, sqrt(40), length.out = 8)^2, 1), 
  domain = state_milk$milk_produced)

state_milk_label <- leaflet(data = state_milk) %>%
  setView(-96, 37.8, 4) %>%
  addPolygons(
    fillColor = ~pal(milk_produced),
    weight = 2,
    opacity = 1,
    color = "white",
    dashArray = "3",
    fillOpacity = 0.7,
    highlight = highlightOptions(
      weight = 5,
      color = "#666",
      dashArray = "",
      fillOpacity = 0.7,
      bringToFront = TRUE),
    label = state_milk$label)

state_milk_legend <- state_milk_label %>% 
  addLegend( 
    pal = pal, values = ~milk_produced, opacity = 0.7,
    title = "Billions lbs milk",
    position = "bottomright")

htmlwidgets::saveWidget(
  state_milk_label,
  here::here('figs', 'state_milk_label.html')
)

htmlwidgets::saveWidget(
  state_milk_legend,
  here::here('figs', 'state_milk_legend.html')
)

# Internet Choropleth -------

pal <- colorBin(
  palette = "viridis",
  domain = world_internet_2015$percent)

world_internet_2015 <- world_internet_2015 %>% 
  mutate(label = paste(country, ": ", round(percent, 2), "%", sep = ""))
  
world_internet_legend <- leaflet(data = world_internet_2015) %>%
  addPolygons(
    fillColor = ~pal(percent),
    weight = 2,
    opacity = 1,
    color = "white",
    dashArray = "3",
    fillOpacity = 0.7,
    highlight = highlightOptions(
      weight = 5,
      color = "#666",
      dashArray = "",
      fillOpacity = 0.7,
      bringToFront = TRUE),
    label = world_internet_2015$label) %>% 
  addLegend( 
    pal = pal, values = ~percent, opacity = 0.7,
    title = "% Pop w/internet access",
    position = "bottomright")

htmlwidgets::saveWidget(
  world_internet_legend,
  here::here('figs', 'world_internet_legend.html')
)

# Tables - DT ---------

dt_options <- list(
  autoWidth = TRUE,
  columnDefs = list(
    list(width = '100px', targets = c(1, 2, 5, 6)), 
    list(width = '50px', targets = c(3, 4)))
)

gapminder_dt <- gapminder %>% 
  datatable(
    width = 700,
    options = dt_options)

gapminder_dt_pages <- gapminder %>% 
  datatable(
    width = 700,
    options = list(
      pageLength = 5,
      lengthMenu = c(5, 10, 15, 20),
      autoWidth = TRUE,
      columnDefs = list(
        list(width = '100px', targets = c(1, 2, 5, 6)), 
        list(width = '50px', targets = c(3, 4)))
))

gapminder_dt_style <- gapminder %>% 
  datatable(
    width = 700,
    options = dt_options) %>% 
  formatCurrency('gdpPercap') %>%
  formatStyle('country', color = 'red', backgroundColor = 'black', fontWeight = 'bold')

gapminder_dt_bars <- gapminder_dt_style %>% 
  formatStyle(
    'lifeExp',
    background = styleColorBar(gapminder$lifeExp, 'dodgerblue'),
    backgroundSize = '100% 90%',
    backgroundRepeat = 'no-repeat',
    backgroundPosition = 'center'
  )

htmlwidgets::saveWidget(
  gapminder_dt,
  here::here('figs', 'gapminder_dt.html')
)

htmlwidgets::saveWidget(
  gapminder_dt_pages,
  here::here('figs', 'gapminder_dt_pages.html')
)

htmlwidgets::saveWidget(
  gapminder_dt_style,
  here::here('figs', 'gapminder_dt_style.html')
)

htmlwidgets::saveWidget(
  gapminder_dt_bars,
  here::here('figs', 'gapminder_dt_bars.html')
)

# Tables - reactable ---------

gapminder_reactable <- gapminder %>% 
  reactable()

gapminder_reactable_options <- gapminder %>% 
  reactable(
    searchable = TRUE, 
    highlight = TRUE,
    filterable = TRUE,
    defaultPageSize = 5,
    showPageSizeOptions = TRUE,
    pageSizeOptions = c(5, 10, 15)
  )

gapminder_reactable_bars <- gapminder %>% 
  reactable(
    searchable = TRUE, 
    highlight = TRUE,
    filterable = TRUE,
    defaultPageSize = 5, 
    showPageSizeOptions = TRUE, 
    pageSizeOptions = c(5, 10, 15),
    columns = list(
      lifeExp = colDef(
        minWidth = 175, 
        cell = data_bars_pos_neg(
          gapminder,
          colors = c("#d7191c", "#ffffbf", "#1a9641")),
        align = "center")) ## align column header
  )

gapminder_summary <- gapminder %>%
  group_by(country) %>%
  summarise(lifeExp = list(lifeExp)) %>% 
  mutate(leftExpTrend = NA)

gapminder_reactable_sparkline <- gapminder_summary %>% 
  reactable(
    searchable = TRUE, 
    highlight = TRUE,
    filterable = TRUE,
    defaultPageSize = 5,
    showPageSizeOptions = TRUE,
    columns = list(
      lifeExp = colDef(
        cell = function(values) {
          sparkline(
            values, type = "bar", chartRangeMin = 0, 
            chartRangeMax = max(gapminder$lifeExp))
        }),
      leftExpTrend = colDef(
        cell = function(value, index) {
          sparkline(gapminder_summary$lifeExp[[index]])
        })
    )
  )

gapminder_flags <- gapminder %>% 
  mutate(flag = paste(
    "https://flagshub.com/images/flag-of-", 
    str_to_lower(country), ".png", sep = "")) %>% 
  select(flag, country, everything())
  
gapminder_reactable_flags <- gapminder_flags %>% 
  reactable(
    searchable = TRUE, 
    highlight = TRUE,
    filterable = TRUE,
    defaultPageSize = 5, 
    showPageSizeOptions = TRUE, 
    pageSizeOptions = c(5, 10, 15),
    columns = list(flag = colDef(cell = embed_img(
      width = "30", height = "20")))
  )

htmlwidgets::saveWidget(
  gapminder_reactable,
  here::here('figs', 'gapminder_reactable.html'), 
  selfcontained = TRUE
)

htmlwidgets::saveWidget(
  gapminder_reactable_options,
  here::here('figs', 'gapminder_reactable_options.html')
)

htmlwidgets::saveWidget(
  gapminder_reactable_bars,
  here::here('figs', 'gapminder_reactable_bars.html')
)

htmlwidgets::saveWidget(
  gapminder_reactable_sparkline,
  here::here('figs', 'gapminder_reactable_sparkline.html')
)

htmlwidgets::saveWidget(
  gapminder_reactable_flags,
  here::here('figs', 'gapminder_reactable_flags.html')
)
