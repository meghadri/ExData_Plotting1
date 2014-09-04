##
##  Coursera/Johns Hopkins 
##      Exploratory Data Analysis
##      Sep 1, 2014
##  Project number 1 
##
##
##  Downloads the file from the URL specified into the given directory with the filename specified
##  The function will create the directory if necessary.
##  Ensure that the process in which this script is run has the correct privileges to create/write
##  to the destination directory.
##
##      'locRemote' 
##              The URL (http or https) of the remote file to be downloaded. May not be NULL.
##      'dirDest'
##              The directory in which the local copy of the file is placed. May not be NULL.
##      'unzip'
##              Logical value to indicate whether the file should be unzipped
##      'localFName'
##              The name to be given to the local file. This is optional. If not provided, the following
##              scheme is used to name the file
##                  base of the remote file's name (without the extension) + "=" +  current system time + "." + the extension of the remote file.
##
##      Value
##              Returns the name of the local file, or if unzip is specified will return a character vector of the files extracted into dirDest
##
##

fetchRemoteFile <- function(locRemote, dirDest, unzip = FALSE, localFName = NULL) {
    require(tools)
    
    if(!file.exists(dirDest)) 
        dir.create(dirDest)
    
    if(is.null(localFName) || is.na(localFName) || nchar(localFName) == 0 ) {
        fileExt <- file_ext(basename(URLdecode(locRemote)))
        destFile <- file_path_sans_ext(basename(URLdecode(remoteFileURL)))
        destFile <- paste(dirDest, .Platform$file.sep, destFile, "_", as.Date(Sys.time()), ".", fileExt, sep="")
    } else {
        destFile = localFName
    }
    
    codeSucc <- download.file(locRemote, destFile, method = "curl")
    if(codeSucc != 0) 
        stop(paste("Unable to download file from :", locRemote))
    
    retVal = destFile
    
    if(isTRUE(unzip))
        retVal <- unzip(destFile, exdir=dirDest)
    
    retVal
    
}