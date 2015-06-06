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


#Plot3.png
png(filename = "plot3.png",    width = 480, height = 480, units = "px")
with(dataplot, {
    plot(Sub_metering_1 ~ DateTime, type = "l", 
    ylab = "Global Active Power (kilowatts)", xlab = "")
    lines(Sub_metering_2 ~ DateTime, col = 'Red')
    lines(Sub_metering_3 ~ DateTime, col = 'Blue')
})
legend("topright", col = c("black", "red", "blue"), lty = 1, lwd = 2, 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()


