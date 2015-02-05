
# read data in
colClasses = c("character", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric")
householdPowerConsumption <- read.table("./household_power_consumption.txt", header = T, na.strings = "?", sep=";", quote="", comment.char = "")

# transform to dates and times
householdPowerConsumption$datetime <- as.POSIXct(strptime(
  paste(householdPowerConsumption$Date, householdPowerConsumption$Time, sep=" ")
  , "%d/%m/%Y %H:%M:%S"))
householdPowerConsumption$Date <- as.Date(strptime(householdPowerConsumption$Date, "%d/%m/%Y"))

# select dates between "2007-02-01" and "2007-02-02"
householdPowerConsumption <- householdPowerConsumption[ (householdPowerConsumption$Date >= "2007-02-01" & householdPowerConsumption$Date <= "2007-02-02"), ]

# create plot on the screen and copy to png file
plot(householdPowerConsumption$Global_active_power ~ householdPowerConsumption$datetime, type="l", ann=F)
title( ylab = "Global Active Power (kilowatts)")
dev.copy(png, file = "plot2.png")
dev.off()
