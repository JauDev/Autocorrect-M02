# Recover ROUTINES

library(RMySQL)
library(data.table)
source("myFuncs.R")


user = 'test01'
date = ''




mydb <- dbconn()



sql <- paste0("SELECT DEFINER, CREATED, ROUTINE_NAME, ROUTINE_SCHEMA, ROUTINE_DEFINITION 
              FROM INFORMATION_SCHEMA.ROUTINES ")

if (user != '' || date != ''){
  sql = paste0(sql,' WHERE ')
  if(user != ''){
    sql = paste0(sql,' DEFINER LIKE "%', user, '%"')
  }
  if(date != ''){
    sql = paste0(sql,' CREATE > "', date, '"')
  }
}

routines <- DTquery(mydb, sql)





dbDisconnect(mydb)
