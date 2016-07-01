run.server <- function() {
  appDir <- system.file("shinyApp", package = "workout.tracker")
  if (appDir == "") {
    stop("Could not find example directory. Try re-installing `mypackage`.", call. = FALSE)
  }
  
  shiny::runApp(appDir, display.mode = "normal", port = 9999)
}