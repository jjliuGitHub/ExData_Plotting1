# Archive name, note I assume the file is in the current R working directory
zip_fname <- "exdata-data-household_power_consumption.zip"

# Get the name of the raw data file within the archive (Assume: only one file in the archive)
raw_file <- unzip(zip_fname, list=TRUE)$Name

# Open a temporary file connection for collecting output of filtering
filtered <- file()

# Open a connection for reading the target file in the archive without decompressing to disk
zz <- unz(zip_fname, raw_file)

# Filter observations for target dates. (Fill grep with what you need)
cat(grep("(^Date)|(^[1|2]/2/2007)", readLines(zz), value=TRUE), sep="\n", file=filtered)

# Load filtered data    
power_data <- read.table(filtered, sep=";",header = TRUE)

# Close connections
closeAllConnections()

#plot the histgram of the third variable-global active power into a png file
png(filename = "png1.png", width = 480, height = 480)
hist(power_data$Global_active_power,col = "red", main = "Global Active Power",xlab = "Global Active Power (killowatts)")

#close the device
dev.off()
