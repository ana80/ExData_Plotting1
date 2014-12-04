## data reading description:
## after downloading the zip file from the assignment page I have put it in the R working directory and unzip it with the following command

	unzip("exdata-data-household_power_consumption.zip")

## reading the data in a table format for 2 target days 1st and 2end of February 2007

	HHdata <- read.table(pipe("findstr /B /R ^[1-2]/2/2007 household_power_consumption.txt"), header = FALSE, 
		colClasses = c("character", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric"), 
		sep = ";", stringsAsFactors = FALSE, na.strings = "?")

## adding the column title

	colnames(HHdata) <- c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3")

## Date and time merging and its class conversion - two columns got merged as "Date_Time" and the originals got removed

	Date_Time <- paste(HHdata$Date, HHdata$Time, sep=" ")
	Hdata <- subset(HHdata, select = -c(Date, Time))
	HHdata2 <- cbind(Date_Time, Hdata)
	HHdata2$Date_Time <- strptime(HHdata2$Date_Time, "%d/%m/%Y %H:%M:%S")


## PLOT3 description:
## plotting against the first attribute, then adding the second one and third one by subseting the data, exposing in different colors
## the legend is assigned according to tree level of metering by the legend function

png(file = "plot3.png", width=480, height=480)

	with(HHdata2, plot(HHdata2$Date_Time, HHdata2$Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering"))
	with(subset(HHdata2, select = c(7)), lines(HHdata2$Date_Time, HHdata2$Sub_metering_2, col = "red"))
	with(subset(HHdata2, select = c(8)), lines(HHdata2$Date_Time, HHdata2$Sub_metering_3, col = "blue"))
	
	 legend("topright",
		legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
		col=c("black","red","blue"), lwd=1, lty=c(1,1,1))

dev.off()