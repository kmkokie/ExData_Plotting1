##JHU Data Science Specialization - Exploring Data -Week 1 Project
## PLOT 1
## script reads a zip file of power consumption, unzips the file
## and creates a histogram of Frequency for Global Active Power readings
## for 2/1/2007 & 2/2/2007
## output can be found in plot1.png in your working directory

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
                    colClasses = c("character","character","numeric", "numeric","numeric",
                                   "numeric","numeric","numeric","numeric"))

##retain subset of data for the days of interest only
powerD <- powerD[((powerD$Date == "1/2/2007") | (powerD$Date == "2/2/2007")),]

## convert Date column to date type
powerD$Date <- lapply(powerD$Date, as.Date, "%d/%m/%y")

##create output file & plot
png(file = "plot1.png", width = 480, height = 480)
hist(v<-powerD$Global_active_power, main = "Global Active Power", 
     xlab = "Global Active Power (kilowatts)", ylab = "Frequency", col = "red")

##close device
dev.off()
