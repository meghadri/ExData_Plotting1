##
##  Coursera/Johns Hopkins 
##      Exploratory Data Analysis
##      Sep 1, 2014
##  Project number 1 
##



source("fetchRemoteFile.R")
source("constructDataSet.R")

## download
remoteFileURL <-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
destLocalDir <- "data"
dataFile <- fetchRemoteFile(locRemote = remoteFileURL, dirDest = destLocalDir, unzip = TRUE)


## construct the dataset of interest - subsetting for the specified date range
datesOfInterest <- c('1/2/2007', '2/2/2007')
dSet <- constructDataSet(dataFile, datesOfInterest)


## create the plots
source("plot1.R")
plot1(dSet)

source("plot2.R")
plot2(dSet)

source("plot3.R")
plot3(dSet)

source("plot4.R")
plot4(dSet)

