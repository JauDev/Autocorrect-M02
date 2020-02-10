#install.packages("RMySQL")
library(RMySQL)
library(data.table)

source("myFuncs.R")

mydb <- dbconn()

#TODO: crear un array d'errors on cada element serà un tipus d'error


#Comparador de taules
#Aquest script farà una comparació de taules per checkejar que siguin iguals en estructura
refTable <- 'log'
table <- 'series'
errorMsg <- array()


# 1. Num columnes
tableFields <- dbListFields(mydb, table)
refTableFields <- dbListFields(mydb, refTable)

if(length(tableFields) != length(refTableFields)){
  addError("Number of colums are distinct")
}


# 2. ColumnNames
if(!any(tableFields == refTableFields)){
  addError("Column names do not match")
}


# 3. Data type
sql <- paste0("SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE table_name = '", table, "'")
rs <- dbSendQuery(mydb, sql)
data <- setDT(fetch(rs, n=-1))

sql <- paste0("SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE table_name = '", refTable, "'")
rs <- dbSendQuery(mydb, sql)
refData <- setDT(fetch(rs, n=-1))

if(!any(refData[,'DATA_TYPE'] != refData[,'DATA_TYPE'])){
  addError("Column types do not match")
}



dbDisconnect(mydb)

errorMsg
