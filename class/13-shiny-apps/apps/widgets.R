library(shiny)

ui <- fluidPage(

  sidebarLayout(

    sidebarPanel(

      actionButton(
          inputId = "action",
          label = "Action"
      ),
      
      submitButton(
          text = "Submit"
      ),
      
      selectInput(
          inputId = "select",
          label = "Select input",
          choices = list(
              "Choice 1" = 1,
              "Choice 2" = 2,
              "Choice 3" = 3
          )
      ),
      
      checkboxGroupInput(
          inputId = "checkGroup",
          label = "Check box",
          choices = list(
              "Choice 1" = 1,
              "Choice 2" = 2,
              "Choice 3" = 3
          ),
          selected = 1
      ),
      
      textInput(
          inputId = "text",
          label = "Input some text"
      )

    ),

    mainPanel(

    ) # mainPanel
  ) # sidebarLayout
) # fluidPage

server <- function(input, output, session) {

}

shinyApp(ui, server)
