library(shiny)
library(tidyverse)

ui <- fluidPage(

  sidebarLayout(

    sidebarPanel(
      textInput(
        inputId = "inputText",
        label = "Input text to convert:"
      )
    ),

    mainPanel(

      h3("Lower case:"),
      textOutput(
        outputId = "lowercaseText"
      )

    )
  )
)

server <- function(input, output, session) {

  output$lowercaseText <- renderText({

  })

}

shinyApp(ui, server)
