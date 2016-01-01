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
      p('BMI:  '),
      p(textOutput("current.bmi")),
      p('Num workouts:  '),
      p(textOutput("workouts.this.week")),
      tableOutput("workouts.table")
    )
  )
))