
sql_db <- function(db_cnfg = db_config) {
  drv <- DBI::dbDriver("SQLite")
  con <- DBI::dbConnect(drv, 
                        dbname = "births.sqlite3"
  )
  return(list(
    get_con = function(){
      return(con)
    },
    close = function(){
      DBI::dbDisconnect(con)  
    },
    get = function(query){
      res <- DBI::dbGetQuery(con, query)
      return(res)
    },
    send = function(statement){
      DBI::dbSendQuery(con, statement)
    }
  ))
}