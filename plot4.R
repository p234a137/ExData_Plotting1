
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
png(filename = "plot4.png", width = 480, height = 480, units = "px")
par(mfcol = c(2, 2))
# create (1,1)
plot(householdPowerConsumption$Global_active_power ~ householdPowerConsumption$datetime, type="l", ann=F)
title( ylab = "Global Active Power (kilowatts)")
# create (1,2)
plot(householdPowerConsumption$Sub_metering_1 ~ householdPowerConsumption$datetime, type="l", ann=F)
points(householdPowerConsumption$Sub_metering_2 ~ householdPowerConsumption$datetime, type="l", col="red", ann=F)
points(householdPowerConsumption$Sub_metering_3 ~ householdPowerConsumption$datetime, type="l", col="blue", ann=F)
title( ylab = "Energy sub metering")
legend("topright", lty = 1, col = c("black", "blue", "red"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
# create(2,1)
with(householdPowerConsumption, plot(Voltage ~ datetime, type = "l"))
# create(2,2)
with(householdPowerConsumption, plot(Global_reactive_power ~ datetime, type = "l"))
dev.off()
