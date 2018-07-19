library(tidyverse)

source("https://bit.ly/byuisql")
source("connect.R")

# Establish a connection to a database on our SQL server
connection <- connect("melaleuca")

# Specify a connection to table in the database
# (keep in mind that cust is NOT a data frame or tibble 
#  but rather still just a connection to the server. 
#  In other words, the data in this table is NOT on your 
#  laptop yet.)
cust <- tbl(connection, "customer")

# Simple operations like filter can be done on these remote tables
english_speakers <- cust %>%
  filter(PreferredLanguage == "English")

# In fact, even complex dplyr functions work on the remote data
max_age_by_participation <- english_speakers %>%
  group_by(ParticipationLevel) %>%
  summarize(birth = min(DateOfBirth)) %>%
  arrange(ParticipationLevel)

# The beauty of this all is that not until we call "complete"
# is the data actually brought to our local computer
local_data <- max_age_by_participation %>%
  collect()

View(local_data)
