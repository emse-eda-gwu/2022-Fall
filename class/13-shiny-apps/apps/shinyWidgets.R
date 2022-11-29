library(shiny)
library(shinyWidgets)

ui <- fluidPage(

  sidebarLayout(

    sidebarPanel(

      switchInput(
        inputId = "switchInput",
        onStatus = "success", 
        offStatus = "danger"
      ),
      radioGroupButtons(
        inputId = "radioGroupButtons",
        label = "Label",
        choices = c("A", "B", "C", "D"),
        justified = TRUE,
        checkIcon = list(yes = icon("ok", lib = "glyphicon"))
      )

    ),

    mainPanel(

    ) # mainPanel
  ) # sidebarLayout
) # fluidPage

server <- function(input, output, session) {

}

shinyApp(ui, server)
