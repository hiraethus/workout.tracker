library(shiny)

shinyUI(fluidPage(
  
  # Application title
  titlePanel("Workout Tracker Dashboard"),
  
  sidebarLayout(
    sidebarPanel(
      fileInput("xml.document",
                  "Workout data (xml)",
                  multiple=F,
    )),
    
    mainPanel(
      h3('This week stats'),
      h4('BMI:  '),
      p(textOutput("current.bmi")),
      h4('Num workouts:  '),
      p(textOutput("workouts.this.week")),
      tableOutput("workouts.table")
    )
  )
))