library(shiny)

shinyUI(fluidPage(
  
  # Application title
  titlePanel("Workout Tracker Dashboard"),
  
  sidebarLayout(
    mainPanel(
      h3('3 Month summary'),
      h4('Workout Frequency'),
      plotOutput("workout.frequency.plot"),
      h4('Distance Covered'),
      plotOutput('distance.covered.plot'),
      h4('Weight'),
      plotOutput('weight.plot'),
      h4('Waist size'),
      plotOutput('waist.size.plot'),
      h3('Workout data'),
      tableOutput("workouts.table")
    ),
    
    sidebarPanel(
      fileInput("xml.document",
                "Workout data (xml)",
                multiple=F,
      ),
      h3('This week stats'),
      h4('BMI:  '),
      p(textOutput("current.bmi")),
      h4('Num workouts:  '),
      p(textOutput("workouts.this.week")))
  )
))
