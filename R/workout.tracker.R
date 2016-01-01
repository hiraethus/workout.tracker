generate.workout.tracker.report <- function(path.to.workout.xml) {
  doc <- XML::xmlParse(path.to.workout.xml)
  if (!is.doc.valid(doc)) stop(cat(path.to.workout.xml, "contains invalid formatted workout data. Exiting...\n"))
  
  workout.data.frame <- load.workout.data(doc)
  
  # append average speed for each session
  workout.data.frame <- cbind(workout.data.frame,average.velocity=calculate.average.velocity(workout.data.frame))
  
  result <- list(
    data = workout.data.frame,
    week.workouts = workouts.per.week(workout.data.frame)
  )
  class(result) <- append(class(result), "WorkoutResult")
  
  return(result)
}

#'
#' Function to ensure that the workout document `doc` conforms to the 
#' xsd.
#' 
#' @return `True` if valid, `False` if invalid
is.doc.valid <- function(doc) {
  workout.data.xsd <- system.file("workout_data.xsd", package="workout.tracker")
  schema <- XML::xmlParse(workout.data.xsd, isSchema=T)
  validate <- XML::xmlSchemaValidate(schema, doc)
  
  validate$status == 0
}

#'
#' Takes a workout tracker xml file  and returns a Data frame of the data 
#' if it is valid (see /inst/workout_tracker.xsd in order 
#' to see how a valid xml file should be constructed).
#' 
#' If invalid, the function exits prematurely
load.workout.data <- function(doc) {
  workout.nodes <- getNodeSet(doc=doc, "//workout-tracker/workouts/workout")
  df <- XML::xmlToDataFrame(workout.nodes, stringsAsFactors = F)
  df$date <- as.Date(df$date)
  df$level <- as.integer(df$level)
  df$timeInMinutes <- as.integer(df$timeInMinutes)
  df$caloriesBurned <- as.integer(df$caloriesBurned)
  df$distanceCoveredKm <- as.numeric(df$distanceCoveredKm)
  df$recoveryScore <- as.factor(df$recoveryScore)
  if ("waistSizeCm" %in% colnames(df)) {
    df$waistSizeCm <- as.numeric(df$waistSizeCm)
  }
  if ("weightKg" %in% colnames(df)) {
    df$weightKg <- as.numeric(df$weightKg)
  }
  
  return(df)
}

workouts.per.week <- function(workout.data) {
  workout.dates <- trunc(workout.data$date, "day")
  
  earliest.date <- min(workout.dates)
  sunday.of.earliest <- earliest.date - as.POSIXlt(earliest.date)$wday
  
  sundays.since.earliest <- seq(from=sunday.of.earliest, to=Sys.Date(), by=7)
  talley.df <- data.frame(date=sundays.since.earliest, talley=rep(0, length(sundays.since.earliest)))
  
  days.after.sunday <- as.POSIXlt(workout.dates)$wday
  workout.weeks <- workout.dates - days.after.sunday
  
  for (workout.week in workout.weeks) {
    index <- which(talley.df$date == workout.week)
    talley.df[["talley"]][index] <- talley.df[["talley"]][index] + 1
  }

  return(talley.df)
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