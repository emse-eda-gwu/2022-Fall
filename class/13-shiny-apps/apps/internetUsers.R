library(shiny)
library(tidyverse)
library(rnaturalearth)

# Load the internet user data
internet_users  <- read_csv(here::here('data', 'internet_users_country.csv'))

# Load the world shape file with national borders
world <- ne_countries(
    scale = "medium",
    returnclass = "sf")

# Join the data
data <- world %>%
    left_join(internet_users, by = c('iso_a3' = 'code')) %>%
    filter(iso_a3 != "ATA")  # No internet in Antarctica...sorry penguins

ui <- fluidPage(

  h1("Internet access by country"),

  sidebarLayout(

    sidebarPanel(
      sliderInput(
        inputId = "year",
        label = "Choose a year:",
        min = 1990,
        max = 2015,
        value = 1990, 
        sep = ""
      ),
      
      radioButtons(
        inputId = "projection",
        label = "Choose a map projection:",
        selected = "ESRI:54030",
        choices = c(
          "Robinson" = "ESRI:54030",
          "Mercator" = "ESRI:54004",
          "Equidistant cylindrical" = "ESRI:54002",
          "Sinusoidal" = "ESRI:54008",
          "Mollweide" = "ESRI:54009"
        )
      )
    ),

    mainPanel(
      plotOutput("plot")
    )
  )
)


server <- function(input, output, session) {
  output$plot <- renderPlot({

    # Make the map
    ggplot(plotData) +
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
        fill = '% of population with access') + 
      coord_sf(crs = "ESRI:54030") 

  })
}

shinyApp(ui, server)
