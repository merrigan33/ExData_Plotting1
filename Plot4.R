########################### Coursera Exploratory Data Annalysis Project 1 ######################################

##### Load Data and identify missing values as "?" #####
household_energy_data <- read.table("household_power_consumption.txt", header= TRUE, sep=";", stringsAsFactors=FALSE, dec=".")
summary(household_energy_data)
# Create subset of data to only include necessary dates 
subsetdata <- household_energy_data[household_energy_data$Date %in% c("1/2/2007","2/2/2007"),]
# can also use as.date function to come to the same result may help with time variable creation 
household_energy_data$Date <- as.Date(household_energy_data$Date, format = c("%d/%m/%Y"))
Sub_Energy_Data <- subset(household_energy_data,Date >= as.Date("2007/2/1") & Date <= as.Date("2007/2/2"))
# Remove incomplete data point from series 
Sub_Energy_Data <- Sub_Energy_Data[complete.cases(Sub_Energy_Data),]
# Create a variable for time series by combining the columns of date and time then correct column format  
Sub_Energy_Data$TimeSeries <- paste(Sub_Energy_Data$Date, Sub_Energy_Data$Time)
Sub_Energy_Data$TimeSeries <- as.POSIXct(TimeSeries)
# Last data preparation step is to set values from characters to numeric for plotting
Sub_Energy_Data$Global_active_power <- as.numeric(Sub_Energy_Data$Global_active_power)
Sub_Energy_Data$Global_reactive_power <- as.numeric(Sub_Energy_Data$Global_reactive_power)
Sub_Energy_Data$Voltage <- as.numeric(Sub_Energy_Data$Voltage)
Sub_Energy_Data$Sub_metering_1 <- as.numeric(Sub_Energy_Data$Sub_metering_1)
Sub_Energy_Data$Sub_metering_2 <- as.numeric(Sub_Energy_Data$Sub_metering_2)
Sub_Energy_Data$Sub_metering_3 <- as.numeric(Sub_Energy_Data$Sub_metering_3)

##################### Plot 4: Subplot combining 4 plots #####################################
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))
with(Sub_Energy_Data, {
  plot(Global_active_power~TimeSeries, type="l", 
       ylab="Global Active Power (kilowatts)", xlab="")
  plot(Voltage~TimeSeries, type="l", 
       ylab="Voltage (volt)", xlab="")
  plot(Sub_metering_1~TimeSeries, type="l", 
       ylab="Global Active Power (kilowatts)", xlab="")
  lines(Sub_metering_2~TimeSeries,col='Red')
  lines(Sub_metering_3~TimeSeries,col='Blue')
  legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
         col=c("black", "red", "blue"), lty=1, lwd=2, bty="n",)
  plot(Global_reactive_power~TimeSeries, type="l", 
       ylab="Global Rective Power (kilowatts)",xlab="")
})

# Save as a png with file name plot# and height and width at 480 
dev.copy(png, file="plot4.png", height=480, width=480)
# remove plot settings before moving forward 
dev.off()
