## Projet 1

##Getting Data

dataset_url <- dataset_url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

#Create Directory
if(!file.exists("./Exploratory Data Analysis")) {dir.create("./Exploratory Data Analysis")}

#Download DataSet
download.file(dataset_url, destfile = "./Exploratory Data Analysis/household_power_consumption.zip" )

#Unzip Data Sets
unzip ("./Exploratory Data Analysis/household_power_consumption.zip", exdir = "./Exploratory Data Analysis")

#Load DataSets in R

household <-read.table(text = grep("^[1,2]/2/2007", readLines("./Exploratory Data Analysis/household_power_consumption.txt"), value = TRUE), col.names = c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), sep = ";", header = TRUE)

#create datetime column

x <- household$Date
y <- household$Time
z <- paste(x,y)
DateTime <-strptime(z,format = "%d/%m/%Y %H:%M:%S")
household_time <- data.frame(household,DateTime)

#Transform in data.table

library(data.table)

dataplot <- data.table(household_time)


#Plot4.png
png(filename = "plot4.png",    width = 480, height = 480, units = "px")
par(mfrow = c(2,2), mar = c(4,4,2,1), oma = c(0,0,2,0))
with(dataplot, {
     plot(Global_active_power ~ DateTime, type = "l", 
     ylab = "Global Active Power", xlab = "")
     plot(Voltage ~ DateTime, type = "l", ylab = "Voltage", xlab = "datetime")
     plot(Sub_metering_1 ~ DateTime, type = "l", ylab = "Energy sub metering",
          xlab = "")
     lines(Sub_metering_2 ~ DateTime, col = 'Red')
     lines(Sub_metering_3 ~ DateTime, col = 'Blue')
     legend("topright", col = c("black", "red", "blue"), lty = 1, lwd = 2, 
             bty = "n",
             legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
     plot(Global_reactive_power ~ DateTime, type = "l", 
          ylab = "Global_rective_power", xlab = "datetime")
})
dev.off()
