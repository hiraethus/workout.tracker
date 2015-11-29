#'
#' Takes a workout tracker xml file  and returns a Data frame of the data 
#' if it is valid (see /inst/workout_tracker.xsd in order 
#' to see how a valid xml file should be constructed).
#' 
#' If invalid, the function exits prematurely
load.workout.data <- function(path.to.workout.xml) {
  schema <- XML::xmlParse("inst/workout_data.xsd", isSchema=T)
  doc <- XML::xmlParse(path.to.workout.xml)
  validate <- XML::xmlSchemaValidate(schema, doc)
  isDocValid <- validate$status == 0
  
  if (!isDocValid) {
    stop(cat(path.to.workout.xml, "contains invalid formatted workout data. Exiting...\n"))
  }
  
  XML::xmlToDataFrame(doc)
}

#'
#' Saves a workout tracker data frame that is valid to a file as a valid workout tracker xml file
#' *Not yet implemented*
save.workout.data <- function(workout.data.frame, path.to.workout.xml) {
  stop("Not yet implemented. Exiting...")
}