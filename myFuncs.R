dbconn <- function() {
  mydb <- dbConnect(MySQL(), user='root', password='', dbname='misseries', host='localhost')
  return(mydb)
}

addError <- function(msg){
  prevErrorMsg <- errorMsg
  errorMsg <<- append(prevErrorMsg, msg, after = length(errorMsg))
}

DTquery <- function(mydb, sql){
  rs <- dbSendQuery(mydb, sql)
  return(setDT(fetch(rs, n=-1)))
}