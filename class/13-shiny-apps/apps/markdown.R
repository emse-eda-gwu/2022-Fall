library(shiny)

ui <- fluidPage(
  markdown("
  # Header 1

  ## Header 2

  ### Header 3

  #### Header 4

  Some text

  **Some bold text**

  _Some italic text_

  `Some code`

  [Class home page](https://eda.seas.gwu.edu/2021-Spring/)
  ")
)

server <- function(input, output, session) {

}

shinyApp(ui, server)
