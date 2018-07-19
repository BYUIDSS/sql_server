connect <- function(database) {
  if(!require(dbplyr)) {
    install.packages("dbplyr")
    library(dbplyr) }
  if(!require(DBI)) {
    install.packages("DBI")
    library(DBI) }
  if(!require(odbc)) {
    install.packages("odbc")
    library(odbc) }
  return(dbConnect(odbc(),
                   driver = "SQL Server",
                   server = "shiny.byui.edu",
                   database = "melaleuca",
                   uid = "student",
                   pwd = rstudioapi::askForPassword("Student Password")))
  return(connection)
}
