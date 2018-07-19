# This file can be accessed at https://bit.ly/byuisql
# or https://raw.githubusercontent.com/BYUIDSS/sql_server/master/connect.R

# dbplyr package for server-side dplyr operations
if(!require(dbplyr)) {
  install.packages("dbplyr") }

# DBI package for general database connection
if(!require(DBI)) {
  install.packages("DBI") }

# odbc package for specific SQL Server functionality
if(!require(odbc)) {
  install.packages("odbc") }

# Function that takes a database name and returns a connection
connect <- function(database) {
  return(DBI::dbConnect(odbc::odbc(),
                        driver = "SQL Server",
                        server = "shiny.byui.edu",
                        database = database,
                        uid = "student",
                        pwd = rstudioapi::askForPassword()))
}