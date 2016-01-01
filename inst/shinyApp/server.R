library(shiny)

shinyServer(function(input, output) {
  output$workouts.table <- shiny::renderTable(workout.tracker::generate.report(input$xml.document$datapath)$data)
})