# Workout Tracker

A small R library to generate a report of data collated from exercising using a _Reebok ZR8_ exercise bike

## Installation
If you are running Ubuntu, you'll need to install libxml2-dev
```bash
sudo apt-get install libxml2-dev
```

Then you can install this library from github using `devtools`:

```R
# install.packages("devtools")
devtools::install_github("hiraethus/workout.tracker")
```

## Usage
Currently, workout.tracker takes an valid document containing descriptions of workouts validated against `workout_data.xsd` which is found in the `inst/` directory of this project.

A typical workout xml document will be formed as follows:

```XML
<?xml version="1.0" encoding="UTF-8"?>
<workout-tracker>
  <configuration>
    <heightCm>160.1</heightCm> <!-- takes positive decimal value -->
  </configuration>
  <workouts>
    <workout>
      <date>2013-12-30</date> <!-- takes a date in _big endian_ format -->
      <level>1</level> <!-- takes positive integer value -->
      <timeInMinutes>20</timeInMinutes> <!-- takes positive integer value -->
      <caloriesBurned>340</caloriesBurned> <!-- takes positive integer value -->
      <distanceCoveredKm>9.62</distanceCoveredKm> <!-- takes positive decimal value -->
      <recoveryScore>F4</recoveryScore> <!-- takes the values F1 through F6 -->
      <waistSizeCm>110.1</waistSizeCm> <!-- optional - takes positive decimal value -->
      <weightKg>80</weightKg> <!-- optional - takes positive decimal value -->
    </workout>
  </workouts>
</workout-tracker>
```

Once this xml document has been loaded, the data can be loaded in to  R using:

```R
workout.tracker::generate.report(path.to.workout.xml = "<path-to-xml-document>")
```
The result contains a list containing a `data.frame` with all of the workout data as well as a second `data.frame` which shows the number of workouts per week for each week since the first workout in the xml document.

## Shiny Dashboard
Also under development is a dashboard to give prerendered visualisations of data to the user for daily analysis. To run the shiny app:

```R
workout.tracker::run.server()
```

## To do
* Allow varying the time interval to show on the graphs
* Allow adding/removing trend lines