##
##  Coursera/Johns Hopkins 
##      Exploratory Data Analysis
##      Sep 1, 2014
##  Project number 1 
##
##  Method to generate the 2nd plot required in the assignment
##
##      There are two functions provided
##          A standalone verion, plot2_Standalone(), which downloads, unzips and loads the remote data file
##          A version, plot2(dSet) that simply reads the data.frame supplied as a parameter and 
##              generates the plot. 


plot2 <- function(dSet) {
    png("plot2.png",width=480, height=480)
    
    
    plot(dSet$reading_ts, dSet$Global_active_power, xaxt="n", ylab="Global Active Power (kilowatts)")
    axis(1, at=seq(0,nrow(dSet),nrow(dSet)/2), labels=c("Thu","Fri","Sat"))
    
    points(x=dSet$reading_ts, y=dSet$Global_active_power, type='l', lwd=1)
    
    dev.off()
}


plot2_Standalone <- function() {
    source("fetchRemoteFile.R")
    source("constructDataSet.R")
    
    remoteFileURL <-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
    destLocalDir <- "data"
    
    dataFile <- fetchRemoteFile(locRemote = remoteFileURL, dirDest = destLocalDir, unzip = TRUE)
    
    datesOfInterest <- c('1/2/2007', '2/2/2007')
    
    dSet <- constructDataSet(dataFile, datesOfInterest)
    plot2(dSet)
}

