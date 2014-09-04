##
##  Coursera/Johns Hopkins 
##      Exploratory Data Analysis
##      Sep 1, 2014
##  Project number 1 
##
##  Method to generate the 3rd plot required in the assignment
##
##      There are two functions provided
##          A standalone verion, plot2_Standalone(), which downloads, unzips and loads the remote data file
##          A version, plot2(dSet) that simply reads the data.frame supplied as a parameter and 
##              generates the plot. 





plot3 <- function(dSet) {
    png("plot3.png",width=480, height=480)
    
    clrSM1 <- 'black'
    clrSM2 <- 'red'
    clrSM3 <- 'blue'
    plot(dSet$reading_ts, dSet$Sub_metering_1, xaxt="n", ylab="Energy sub metering", col='black')
    points(x=dSet$reading_ts, y=dSet$Sub_metering_1, col=clrSM1, type='l', lwd=1)
    points(x=dSet$reading_ts, y=dSet$Sub_metering_2, col=clrSM2, type='l', lwd=1)
    points(x=dSet$reading_ts, y=dSet$Sub_metering_3, col=clrSM3, type='l', lwd=1)
    
    legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), pch="-", lwd=1, col=c(clrSM1, clrSM2, clrSM3))
    axis(1, at=seq(0,nrow(dSet),nrow(dSet)/2), labels=c("Thu","Fri","Sat"))
    
    dev.off()
}


plot3_Standalone <- function() {
    source("fetchRemoteFile.R")
    source("constructDataSet.R")
    
    remoteFileURL <-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
    destLocalDir <- "data"
    
    dataFile <- fetchRemoteFile(locRemote = remoteFileURL, dirDest = destLocalDir, unzip = TRUE)
    
    datesOfInterest <- c('1/2/2007', '2/2/2007')
    
    dSet <- constructDataSet(dataFile, datesOfInterest)
    plot3(dSet)
}
