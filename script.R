library(RCurl)
library(dplyr)

# krävs "RSQLite"

load(url("http://capa.ddb.umu.se/cedaR/Data/births.rda"))

# skapa en databas SQL lite
unlink("births.sqlite3")
my_db <- src_sqlite("births.sqlite3", create = T)

tmp <- copy_to(my_db, births, temporary = FALSE, indexes = list(
  "sex"))

## Koppla upp sig till databasen


my_db <- src_sqlite("births.sqlite3")

births_sql <- tbl(my_db, "births")

n_child <- tbl(my_db, sql("
    SELECT sex, count(*) as n 
    FROM births 
    GROUP BY sex
    ")) %>% collect()

n_chilt2 <- births_sql %>% group_by(sex) %>% 
  summarise(n = n()) %>% collect()

# fungerar inte
a <- tbl(my_db, sql("UPDATE births SET parity = (parity -1)"))


# Skapa egen database wrapper
source("R/sql_db.R")


db <- sql_db()

db$get("SELECT * FROM births LIMIT 10")


db$send("UPDATE births SET parity = (parity -1 )")

# From sql file

statment <- readLines("R/test.sql")

db$get(paste(statment, collapse = ""))


# foreign 