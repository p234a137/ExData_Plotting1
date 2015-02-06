
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

# create png file
png(filename = "plot3.png", width = 480, height = 480, units = "px")
# create plot
plot(householdPowerConsumption$Sub_metering_1 ~ householdPowerConsumption$datetime, type="l", ann=F)
points(householdPowerConsumption$Sub_metering_2 ~ householdPowerConsumption$datetime, type="l", col="red", ann=F)
points(householdPowerConsumption$Sub_metering_3 ~ householdPowerConsumption$datetime, type="l", col="blue", ann=F)
title( ylab = "Energy sub metering")
legend("topright", lty = 1, col = c("black", "blue", "red"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
#dev.copy(png, file = "plot3.png")
dev.off()
