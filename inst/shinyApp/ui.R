library(shiny)

shinyUI(fluidPage(
  
  # Application title
  titlePanel("Workout Tracker Dashboard"),
  
  sidebarLayout(
    sidebarPanel(
      fileInput("xml.document",
                  "Workout xml doc",
                  multiple=F,
    )),
    
    mainPanel(
      tableOutput("workouts.table")
    )
  )
))