library(shiny)

shinyUI(fluidPage(
  
  # Application title
  titlePanel("Workout Tracker Dashboard"),
  
  sidebarLayout(
    mainPanel(
      h3('3 Month summary'),
      fluidRow(
        column(6,
             h4('Workout Frequency'),
             plotOutput("workout.frequency.plot")
        ),
        column(6,
               h4('Distance Covered'),
               plotOutput('distance.covered.plot')
        )
      ),
      fluidRow(
        column(6,
               h4('Weight'),
               plotOutput('weight.plot')
        ),
        column(6,
               h4('Waist size'),
               plotOutput('waist.size.plot')
        )
        
      ),
      fluidRow(
        column(6,
                h3('Workout data'),
               tableOutput("workouts.table")
        )
      )
    ),
    
    sidebarPanel(
      fileInput("xml.document",
                "Workout data (xml)",
                multiple=F
      ),
      h3('This week stats'),
      fluidRow(
        column(3, h4('BMI:  ')),
        column(2, p(textOutput("current.bmi")))
      ),
      fluidRow(
        column(3,h4('Num workouts:  ')),
        column(2,p(textOutput("workouts.this.week")))
      )
      
    )
  )
))
