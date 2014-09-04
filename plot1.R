##
##  Coursera/Johns Hopkins 
##      Exploratory Data Analysis
##      Sep 1, 2014
##  Project number 1 
##
##  Method to generate the 1st plot (histogram) required in the assignment
##
##      There are two functions provided
##          A standalone verion, plot1_Standalone(), which downloads, unzips and loads the remote data file
##          A version, plot1(dSet) that simply reads the data.frame supplied as a parameter and 
##              generates the plot. 


plot1 <- function(dSet) {
    ## width & height are redundant since in R v3.1.0 (2014-04-10)/Spring Dance 
    ##  on OSX Mavericks, 480 is the default for both
    
    png("plot1.png",width=480, height=480)
    hist(dSet$Global_active_power, main="Global Active Power", col="red", 
         xlab="Global Active Power (kilowatts)")
    dev.off()
}

plot1_Standalone <- function() {
    source("fetchRemoteFile.R")
    source("constructDataSet.R")
    
    remoteFileURL <-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
    destLocalDir <- "data"
    
    dataFile <- fetchRemoteFile(locRemote = remoteFileURL, dirDest = destLocalDir, unzip = TRUE)
    
    datesOfInterest <- c('1/2/2007', '2/2/2007')
    
    dSet <- constructDataSet(dataFile, datesOfInterest)
    plot1(dSet)
}
