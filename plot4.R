##
##  Coursera/Johns Hopkins 
##      Exploratory Data Analysis
##      Sep 1, 2014
##  Project number 1 
##
##  Method to generate the 4th plot required in the assignment
##
##      There are two functions provided
##          A standalone verion, plot4_Standalone(), which downloads, unzips and loads the remote data file
##          A version, plot4(dSet) that simply reads the data.frame supplied as a parameter and 
##              generates the plots. 




plot4 <- function(dSet) {
    
    png("plot4.png",width=480, height=480)
    
    par(mfrow=c(2,2))
    
    ## (Plot #2 from assignment)    
    plot(dSet$reading_ts, dSet$Global_active_power, xaxt="n", ylab="Global Active Power")
    axis(1, at=c(0,nrow(dSet),nrow(dSet)/2), labels=c("Thu","Fri","Sat"))
    lines(dSet$reading_ts, dSet$Global_active_power)
    
    ## Voltage
    plot(dSet$reading_ts, dSet$Voltage, xaxt="n", ylab="Voltage",  xlab="datetime")
    axis(1, at=c(0,nrow(dSet),nrow(dSet)/2), labels=c("Thu","Fri","Sat"))
    lines(dSet$reading_ts, dSet$Voltage)
    
    
    
    ## Plot #3 from assignment
    clrSM1 <- 'black'
    clrSM2 <- 'red'
    clrSM3 <- 'blue'
    plot(dSet$reading_ts, dSet$Sub_metering_1, xaxt="n", ylab="Energy sub metering", col='black')
    axis(1, at=seq(0,nrow(dSet),nrow(dSet)/2), labels=c("Thu","Fri","Sat"))
    points(x=dSet$reading_ts, y=dSet$Sub_metering_1, col=clrSM1, type='l', lwd=1)
    points(x=dSet$reading_ts, y=dSet$Sub_metering_2, col=clrSM2, type='l', lwd=1)
    points(x=dSet$reading_ts, y=dSet$Sub_metering_3, col=clrSM3, type='l', lwd=1)
    
    legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), pch="-", lwd=1, col=c(clrSM1, clrSM2, clrSM3), bty='n')
    
    ## Global_reactive_power
    plot(dSet$reading_ts, dSet$Global_reactive_power, xaxt="n", ylab="Global_reactive_power", xlab="datetime")
    axis(1, at=c(0,nrow(dSet),nrow(dSet)/2), labels=c("Thu","Fri","Sat"))
    lines(dSet$reading_ts, dSet$Global_reactive_power)
    
    dev.off()
}

plot4_Standalone <- function() {
    source("fetchRemoteFile.R")
    source("constructDataSet.R")
    
    remoteFileURL <-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
    destLocalDir <- "data"
    
    dataFile <- fetchRemoteFile(locRemote = remoteFileURL, dirDest = destLocalDir, unzip = TRUE)
    
    datesOfInterest <- c('1/2/2007', '2/2/2007')
    
    dSet <- constructDataSet(dataFile, datesOfInterest)
    plot4(dSet)
}
