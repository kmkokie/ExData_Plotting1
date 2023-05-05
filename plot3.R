##JHU Data Science Specialization - Exploring Data -Week 1 Project
## PLOT 3
## script reads a zip file of power consumption, unzips the file
## and creates a plot showing 3 Engergy Submetering readings over time 
## for 2/1/2007 & 2/2/2007
## output can be found in plot3.png in your working directory

##define variable for directories and files to be used
power_url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
power_dir <- paste(getwd(),"/power_data", sep = "")
power_zip <- paste(power_dir,"/power.zip", sep = "")
power_file <- paste(power_dir,"/household_power_consumption.txt", sep = "")

##creates data folder if it doesn't exist and clears old downloaded files 
if (!dir.exists(power_dir)) {
        dir.create(power_dir)
} else
        if (file.exists(power_zip)) {
                unlink(power_zip)
        }

##download and unzip source file
download.file(power_url,destfile = power_zip)
unzip(power_zip, exdir=power_dir, overwrite=TRUE)

##load data into a table
powerD <- read.table(power_file,header = TRUE, sep = ";", na.strings = "?", 
                     colClasses = c("character","character","numeric", "numeric",
                                    "numeric","numeric","numeric","numeric",
                                    "numeric"))

##retain subset of data for the days of interest only
powerD <- powerD[((powerD$Date == "1/2/2007") | (powerD$Date == "2/2/2007")),]

## create new datetime column to identify time of day for plotting
datetime <- as.POSIXct(paste(powerD$Date, powerD$Time), format = "%d/%m/%Y %H:%M:%S")
powerD <-cbind(powerD, datetime) 

##create output file, plot the first readings and add the two additional plot lines
png(file = "plot3.png", width = 480, height = 480)
with(powerD, plot(datetime, Sub_metering_1, type = "l", xlab = "",
                  ylab = "Energy sub metering"))
with(powerD, lines(datetime, Sub_metering_2, col = "red"))
with(powerD, lines(datetime, Sub_metering_3, col = "blue"))

legend("topright"
       ,col = c("black","red","blue") 
       ,legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3")
       ,lty = c(1,1), lwd = c(1,1))

##close device
dev.off()