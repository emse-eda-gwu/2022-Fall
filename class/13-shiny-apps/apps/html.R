library(shiny)

ui <- fluidPage(
  h1("Header 1"),
  h2("Header 2"),
  h3("Header 3"),
  h4("Header 4"),
  p("Some text"),
  br(),
  p(strong("Some bold text")),
  p(em("Some italic text")),  
  p(code("Some code")),  
  hr(),
  a(href="https://eda.seas.gwu.edu/2021-Spring/", "Class home page"),
  HTML("<p>Raw html</p>")
)

server <- function(input, output, session) {

}

shinyApp(ui, server)
