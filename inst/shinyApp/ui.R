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
      h3('3 Month summary'),
      h4('Workout Frequency'),
      plotOutput("workout.frequency.plot"),
      h3('Workout data'),
      tableOutput("workouts.table")
    )
  )
))
