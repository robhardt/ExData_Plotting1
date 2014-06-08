## install.packages("data.table")
library(data.table)
png(filename='plot4.png')
cons <- fread("household_power_consumption.txt")
cons <- cons[cons$Date == '2/2/2007' | cons$Date == '1/2/2007',]
cons$Time <- as.POSIXct(strptime(paste(cons$Date, cons$Time, sep=' '), "%d/%m/%Y %H:%M:%S"))
cons$Date <- as.Date(cons$Date, format='%d/%m/%Y')
cons$Global_active_power <- as.numeric(cons$Global_active_power)
cons$Global_reactive_power <- as.numeric(cons$Global_reactive_power)
cons$Voltage <- as.numeric(cons$Voltage)
cons$Global_intensity <- as.numeric(cons$Global_intensity)
cons$Sub_metering_1 <- as.numeric(cons$Sub_metering_1)
cons$Sub_metering_2 <- as.numeric(cons$Sub_metering_2)
cons$Sub_metering_3 <- as.numeric(cons$Sub_metering_3)

par(mfrow=c(2,2))


plot(cons$Time, cons$Global_active_power, type='n', xlab='', ylab='Global Active Power')
lines(cons$Time, cons$Global_active_power)

plot(cons$Time, cons$Voltage, type='n', xlab='datetime', ylab='Voltage')
lines(cons$Time, cons$Voltage)


yrange <- range(c(cons$Sub_metering_1, cons$Sub_metering_2, cons$Sub_metering_3))
plot(cons$Time, cons$Sub_metering_1, type='n', xlab='', ylab='Energy sub metering', ylim=yrange)
lines(cons$Time, cons$Sub_metering_1, type='l')
lines(cons$Time, cons$Sub_metering_2, type='l', col='red')
lines(cons$Time, cons$Sub_metering_3, type='l', col='blue')
legend(x="topright", legend=c('Sub_metering_1','Sub_metering_2','Sub_metering_3'), lty=c(1,1,1), col=c('black', 'red', 'blue'), bty='n')

plot(cons$Time, cons$Global_reactive_power, type='n', xlab='datetime', ylab='Global_reactive_power')
lines(cons$Time, cons$Global_reactive_power)

dev.off()