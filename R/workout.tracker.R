#'
#' Takes a workout tracker xml file  and returns a Data frame of the data 
#' if it is valid (see /inst/workout_tracker.xsd in order 
#' to see how a valid xml file should be constructed).
#' 
#' If invalid, the function exits prematurely
load.workout.data <- function(path.to.workout.xml) {
  workout.data.xsd <- system.file("workout_data.xsd", package="workout.tracker")
  schema <- XML::xmlParse(workout.data.xsd, isSchema=T)
  doc <- XML::xmlParse(path.to.workout.xml)
  validate <- XML::xmlSchemaValidate(schema, doc)
  isDocValid <- validate$status == 0
  
  if (!isDocValid) {
    stop(cat(path.to.workout.xml, "contains invalid formatted workout data. Exiting...\n"))
  }
  
  XML::xmlToDataFrame(doc,
                      colClasses = c("character", "integer", "integer",
                                     "integer", "numeric", "character"),
                      stringsAsFactors = F)
}

workouts.per.week <- function(workout.data) {
  workout.dates <- as.Date(workout.data$date)

  # floor dates to nearest sunday
  days.after.sunday <- as.POSIXlt(workout.dates)$wday
  workout.weeks <- workout.dates - days.after.sunday
  
  count(workout.weeks)
}

calculate.average.velocity <- function(workout.data) {
  workout.data$distanceCoveredKm / workout.data$time
}

#'
#' Saves a workout tracker data frame that is valid to a file as a valid workout tracker xml file
#' *Not yet implemented*
save.workout.data <- function(workout.data.frame, path.to.workout.xml) {
  stop("Not yet implemented. Exiting...")
}