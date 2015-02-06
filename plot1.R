# data: https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip

# calculate an estimate of the memory usage in bytes, assuming 8 bytes / numeric
no_of_columns = 9
no_of_rows = 2075259
memory_required = no_of_columns * no_of_rows * 8 
cat("calculated memory required in bytes = ", memory_required/(1024*1024), units = "MB")
cat("\nfile size = ", file.info("./household_power_consumption.txt")$size/(1024*1024))

# read data in
colClasses = c("character", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric")
householdPowerConsumption <- read.table("./household_power_consumption.txt", header = T, na.strings = "?", sep=";", quote="", comment.char = "")
cat("\nactual object size = ", format(object.size(householdPowerConsumption), units = "MB"))

# transform to dates and times
householdPowerConsumption$datetime <- as.POSIXct(strptime(
  paste(householdPowerConsumption$Date, householdPowerConsumption$Time, sep=" ")
  , "%d/%m/%Y %H:%M:%S"))
householdPowerConsumption$Date <- as.Date(strptime(householdPowerConsumption$Date, "%d/%m/%Y"))

# select dates between "2007-02-01" and "2007-02-02"
householdPowerConsumption <- householdPowerConsumption[ (householdPowerConsumption$Date >= "2007-02-01" & householdPowerConsumption$Date <= "2007-02-02"), ]

# create png file
png(filename = "plot1.png", width = 480, height = 480, units = "px")
# create plot
hist(householdPowerConsumption$Global_active_power,
     col="red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)" )
#dev.copy(png, file = "plot1.png")
dev.off()
