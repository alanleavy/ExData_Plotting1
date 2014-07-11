## Exploratory Data Analysis - Course Project 1 - Plot 2


## COMMON FUNCTIONS ##############

DownloadData <- function(){
  ## Download in the Electric power consumption dataset, unzip it into a new timestamped directory 
  ##  and make that the working directory.
  
  fileURL <- 'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip'
  download.file(fileURL, "HPC_Dataset.zip")
  destinationFolder <- paste("HPC_Dataset", Sys.Date(), sep="__")
  unzip("HPC_Dataset.zip", exdir = destinationFolder, setTimes = T)
  setwd(destinationFolder)
}

PrepareData <- function(){
  hHPC <- file("./household_power_consumption.txt")
  
    ## Read in the file, replacing '?' with NA and leaving Date and Time as strings
  dfHPC <- read.csv(hHPC, sep = ";", quote = "", na.strings="?", as.is=c(1,2))
  
    ## FIlter for the dates we're interested in
  ## dfHPC <- dfHPC[which(dfHPC$DateTime[] >= as.POSIXct("2007-02-01 00:00:00 GMT") & dfHPC$DateTime[] < as.POSIXct("2007-02-03 00:00:00 GMT")),]
  dfHPC <- dfHPC[which(dfHPC$Date == "1/2/2007" | dfHPC$Date == "2/2/2007"),]
  
    ## Concatenate Date and Time and convert to POSIXct
  dfHPC$DateTime<-as.POSIXct(paste(dfHPC$Date, dfHPC$Time), format="%d/%m/%Y %H:%M:%S")
  dfHPC
}




## PLOT-SPECIFIC CODE ############

Plot2_content <- function(dfHPC){
  ## create device-independent output for plot 2
  
  with(dfHPC, plot(DateTime, Global_active_power, type="l", xlab="", ylab = "Global Active Power (kilowatts)"))
}




if(!file.exists("household_power_consumption.txt")){
  DownloadData()
}

dfHPC <-PrepareData()

png(filename = "plot2.png", width = 480, height = 480, units = "px", bg="transparent")
Plot2_content(dfHPC)
dev.off()

