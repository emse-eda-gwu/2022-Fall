library(shiny)
library(tidyverse)
library(cowplot)

# load the data
federal_spending <- read_csv(
  here::here('data', 'federal_spending_long.csv'))

ui <- fluidPage(

  h1("Federal R&D Spending by Department"),

  sidebarLayout(

    sidebarPanel(
      selectInput(
        inputId = "department",
        label = "Choose a department:",
        selected = "DOD",
        choices = c(
          "Deparment of Defense"                          = "DOD",
          "National Aeronautics and Space Administration" = "NASA",
          "Department of Energy"                          = "DOE",
          "Department of Health and Human Services"       = "HHS",
          "National Institute of Health"                  = "NIH",
          "National Science Foundation"                   = "NSF",
          "US Department of Agriculture"                  = "USDA",
          "Department of Interior"                        = "Interior",
          "Deparment of Transportation"                   = "DOT",
          "Environmental Protection Agency"               = "EPA",
          "Department of Corrections"                     = "DOC",
          "Department of Homeland Security"               = "DHS",
          "Department of Veterands Affairs"               = "VA")
      )
    ),

    mainPanel(
      plotOutput("spendingPlot")
    )
  )
)

server <- function(input, output){
  output$spendingPlot <- renderPlot({

    # Filter out the data based on the user input
    data <- federal_spending %>%
      filter(department == input$department)

    ggplot(data) +
      geom_col(
        aes(x = year, y = rd_budget),
        fill = "steelblue", width = 0.7, alpha = 0.8) +
      scale_y_continuous(
        labels = scales::dollar,
        expand = expansion(mult = c(0, 0.05))) +
      theme_half_open(font_size = 18) +
      labs(
        x = "Year",
        y = "$USD Millions",
        title = paste("Federal R&D Spending"))

  })
}

shinyApp(ui = ui, server = server)
