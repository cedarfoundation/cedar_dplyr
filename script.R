library(RCurl)
library(dplyr)

load(url("http://capa.ddb.umu.se/cedaR/Data/births.rda"))

my_db <- src_sqlite("births.sqlite3", create = T)

tmp <- copy_to(my_db, births, temporary = FALSE, indexes = list(
  "sex"))

births_sql <- tbl(my_db, "births")

tbl(my_db, sql("
    SELECT sex, count(*) FROM births GROUP BY sex
    ")) %>% collect()

