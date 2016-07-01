library(shiny)

shinyServer(function(input, output) {
  result <- reactive({
    if (!is.null(input$xml.document)) {
      workout.tracker::generate.report(input$xml.document$datapath)
    } else {
      NULL
    }
  })
  
  output$workouts.table <- renderTable({
    if (!is.null(result())) result()$data
  })
  
  output$current.bmi <- renderText({
    if (!is.null(result())) tail(result()$data$bmi, n=1)
  })
  
  output$workouts.this.week <- renderText({
    if (!is.null(result())) tail(result()$week.workouts$talley, n=1)
  })
  
  output$workout.frequency.plot <- renderPlot({
    if (!is.null(result())) {
      workout.frequency <- result()$week.workouts
      date.3.months.ago <- Sys.Date() - as.difftime(30 * 3, unit="days")
      workout.frequency.3.months <- subset(workout.frequency, date > date.3.months.ago)
      ggplot(workout.frequency.3.months, aes(x = date, y = talley)) + geom_line()
    } 
  })
  
  output$weight.plot <- renderPlot({
    if (!is.null(result())) {
      data.table <- result()$data
      date.3.months.ago <- Sys.Date() - as.difftime(30 * 3, unit="days")
      data.last.3.months = subset(data.table, date > date.3.months.ago)
      ggplot(data.last.3.months, aes(x = date, y = weightKg)) + geom_line()
    }
  })
  
  output$distance.covered.plot <- renderPlot({
    if (!is.null(result())) {
      data.table <- result()$data
      date.3.months.ago <- Sys.Date() - as.difftime(30 * 3, unit="days")
      data.last.3.months = subset(data.table, date > date.3.months.ago)
      ggplot(data.last.3.months, aes(x = date, y = distanceCoveredKm)) + geom_line()
    }
  })
  
  output$waist.size.plot <- renderPlot({
    if (!is.null(result())) {
      data.table <- result()$data
      date.3.months.ago <- Sys.Date() - as.difftime(30 * 3, unit="days")
      data.last.3.months = subset(data.table, date > date.3.months.ago)
      ggplot(data.last.3.months, aes(x = date, y = waistSizeCm)) + geom_line()
    }
  })
})
