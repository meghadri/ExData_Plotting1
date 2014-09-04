##
##  Coursera/Johns Hopkins 
##      Exploratory Data Analysis
##      Sep 1, 2014
##  Project number 1 
##
##
##
##  Constructs the dataset for the assignment.
##  The constructed dataset includes all the columns in the file with two additional columns
##  which are the epoch time and the day of week. These are computed from the 'Date' and 'Time'
##  columns in the file. 
##  The function used sqldf to extract the rows for the dates specified
##
##      'dataFile'
##          The locally available data file to read
##      'datesOfInterest'
##          A vector containing the dates of interest, as strings, in the format d/m/YYYY
##      
##      Value
##          Returns a data frame with the original columns read in from the file with 2 columns
##          added - the epoch time and the day of week, which are used to plot the timeseries.
##

constructDataSet <- function(fileToUse, datesOfInterest) {
    require(sqldf)
    
    setAs("character","tDate", function(from) as.Date(from, format="%d/%m/%Y") )
    setClass("tDate")
    
    dataColClasses = c(Date='tDate', Time='character', Global_active_power='numeric', Global_reactive_power='numeric', Voltage='numeric', Global_intensity='numeric', Sub_metering_1='numeric', Sub_metering_2='numeric', Sub_metering_3='double')
    
    
    count <- length(datesOfInterest)
    idx <- 1
    sqlStmnt <- 'select * from file where Date IN ('
    for(d in datesOfInterest) {
        sqlStmnt <- paste0(sqlStmnt, '"', d, '"') 
        if(idx < count) sqlStmnt <- paste0(sqlStmnt, ',')  
        if(idx == count) sqlStmnt <- paste0(sqlStmnt,')') 
        idx <- idx + 1;        
    }
    
    dSet <- read.csv2.sql(fileToUse, sql = sqlStmnt, stringsAsFactors = FALSE, na.strings = c("", "?"), colClasses=dataColClasses)
    
    ## Add the epoch time and Day of Week columns
    colsToAdd <-  mapply(dSet$Date, dSet$Time,
                         FUN = function(x, y) { 
                             sVal <- paste(x, y, sep=" ") 
                             posixTm <- strptime(sVal, "%d/%m/%Y %H:%M:%S")
                             doW <- weekdays(posixTm, abbreviate=TRUE)
                             c(ReadingTS=as.numeric(as.POSIXct(strftime(posixTm))), DayOfWeek=doW)
                         })
    colsToAdd = as.data.frame(t(colsToAdd))
    
    dSet$reading_ts <- colsToAdd$ReadingTS
    dSet$day_of_week <- colsToAdd$DayOfWeek
    
    dSet
}