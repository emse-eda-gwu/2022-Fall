library(shiny)
library(tidyverse)

ui <- fluidPage(
  sidebarLayout(
    sidebarPanel(
      radioButtons(
        inputId = "xvar",
        label = "Select the x-axis variable:",
        selected = "displ",
        choices = c(
          "Highway miles per gallon" = "hwy",
          "City miles per gallon" = "cty",
          "Engine displacement, in litres" = "displ")
      ),
      radioButtons(
        inputId = "yvar",
        label = "Select the y-axis variable:",
        selected = "hwy",
        choices = c(
          "Highway miles per gallon" = "hwy",
          "City miles per gallon" = "cty",
          "Engine displacement, in litres" = "displ")
      )
    ),
    mainPanel(
      plotOutput(
        outputId = "mpg_plot" 
      ) 
    )
  )
)

server <- function(input, output, session) {
  output$mpg_plot <- renderPlot({ 
    ggplot(mpg) +
    geom_point(
      aes_string(x = input$xvar, y = input$yvar, color = "class"))
  })
}

shinyApp(ui, server)
