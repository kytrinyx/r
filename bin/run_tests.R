library(jsonlite)
library(testthat)
library(magrittr)

test_exercise <- function(exercise) {
  
  solution_file <- paste0(exercise, ".R")
  test_file <- paste0("test_", exercise, ".R")
  
  file.copy(
    file.path("..", "exercises", exercise, "example.R"), 
    solution_file
  )
  file.copy(
    file.path("..", "exercises", exercise, test_file), 
    test_file
  )
  
  source(test_file)
  rm(list = ls())
  
}

run_tests <- function() {

  # create temp directory for testing purposes
  temp_dir <- "temp" 
  dir.create(temp_dir)
  setwd(temp_dir)
  
  on.exit({
    # clean up on exit
    setwd(dir = "../")
    unlink("temp", recursive = TRUE)
  })
  
  # read config and test all exercises
  config <- fromJSON(file.path("..", "config.json"))
  lapply(config$exercises$slug, test_exercise)
    
}

run_tests()
