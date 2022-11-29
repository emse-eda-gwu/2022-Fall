library(shiny)
library(tidyverse)

ui <- fluidPage(
  
  h1("Case Converter App!"),
  
  sidebarLayout(
    
    sidebarPanel(
      textInput(
        inputId = "inputText",
        label = "Input text to convert:"
      )
    ),
    
    mainPanel(
      
      p("This app converts some user-provided text into lower, upper, and title case"),
      
      h3("Lower case:"),
      textOutput(
        outputId = "lowercaseText"
      ),
      
      h3("Upper case:"),
      textOutput(
        outputId = "uppercaseText"
      ),
      
      h3("Title case:"),
      textOutput(
        outputId = "titlecaseText"
      )
      
    )
  )
)

server <- function(input, output, session) {
  
  output$lowercaseText <- renderText({
    str_to_lower(input$inputText)
  })
  
  output$uppercaseText <- renderText({
    str_to_upper(input$inputText)
  })
  
  output$titlecaseText <- renderText({
    str_to_title(input$inputText)
  })
  
}

shinyApp(ui, server)
