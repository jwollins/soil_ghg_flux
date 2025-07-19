# read Gas Chromatography data ####



## SOURCE SCRIPTS ####

source("functions/gc.csv.FUN.R")

### CALIBRATION OF STATIC CHAMBERS ####

# Read REPORT00.CSV as data frame
col.df <- read.csv("data/JC_St_Ch_calibration/data/REPORT00.CSV", 
                   header = FALSE, sep = ",", fileEncoding = "UTF-16LE")

# Extract batch name (first row, V3)
batch.name <- col.df$V3[1]

# Extract all remaining rows of V3 as character vector (skip batch name row)
col.nam <- as.character(col.df$V3[2:15])

# Load CSV data (without header)
dat1 <- read.csv("data/JC_St_Ch_calibration/data/REPORT01.CSV", 
                 header = FALSE, sep = ",", fileEncoding = "UTF-16LE")

dat2 <- read.csv("data/JC_St_Ch_calibration/data/RUN2/REPORT01.CSV", 
                 header = FALSE, sep = ",", fileEncoding = "UTF-16LE")

# Combine datasets
dat <- rbind(dat1, dat2)

# Check: do lengths match?
if (length(col.nam) != ncol(dat)) {
  stop(paste("Number of column names (", length(col.nam), 
             ") does not match number of columns in dat (", ncol(dat), ")"))
}

# Assign column names
colnames(dat) <- col.nam

# Check if 'Sample' column exists
if (!"Sample" %in% colnames(dat)) {
  stop("Column 'Sample' not found in dat after renaming. Check REPORT00.CSV.")
}

# Run your transformation function
dat <- datFUN(dat)


# # load column names
# col.nam <- read.csv("data/JC_St_Ch_calibration/data/REPORT00.CSV", header = FALSE, sep = ",", fileEncoding="UTF-16LE")
# 
# # extract batch name
# batch.name <- col.nam$V3[1]
# 
# 
# # load csv data from gc output
# dat <- read.csv("data/JC_St_Ch_calibration/data/REPORT01.CSV", header = FALSE, sep = ",", fileEncoding="UTF-16LE")
# 
# dat2 <- read.csv("data/JC_St_Ch_calibration/data/RUN2/REPORT01.CSV", header = FALSE, sep = ",", fileEncoding="UTF-16LE")
# 
# dat <- rbind(dat, dat2)
# 
# 
# 
# # Extract all V3 rows after batch name
# col.nam <- as.character(col.nam$V3[-1])  # drop first row, keep rest
# 
# # Check lengths
# if (length(col.nam) != ncol(dat)) {
#   stop("Number of column names does not match number of columns in dat!")
# }
# 
# # Assign column names
# colnames(dat) <- col.nam


# # extract colnames
# col.nam <- as.character(col.nam$V3[2:ncol(dat)])
# 
# # Assign the column names
# colnames(dat) <- col.nam

# run function to extract data from the csv and transform
dat <- datFUN(dat)


## WRITE FILES ####


# write.csv(gc.dat, file = "data/CO2N2OCH4/gc.data.all.days")


## PLOT CALIBRATION ####

# open png for file save and define size and resolution
png(paste("plots/calibration.test/", "CO2 calibration", ".png", sep=""), 
    width=1200, height=900, res=150)

ggplot(dat, aes(x = t, y = `Carbon Dioxide|Amount`, group = chamber)) +
  geom_line(aes(color = chamber)) +
  geom_point(aes(color = chamber)) + 
  ylim(575,675)+ 
  ggtitle(label = "Calibration test 06/03/2023 - Carbon Dioxide", subtitle = "No rubber seals")

# turn save off 
dev.off()


# open png for file save and define size and resolution
png(paste("plots/calibration.test/", "N2O calibration", ".png", sep=""), 
    width=1200, height=900, res=150)

ggplot(dat, aes(x = t, y = `Nitrous Oxide|Amount`, group = chamber)) +
  geom_line(aes(color = chamber)) +
  geom_point(aes(color = chamber))+ 
  ylim(0.285,0.33)+ 
  ggtitle(label = "Calibration test 06/03/2023 - Nitrous Oxide", subtitle = "No rubber seals")

# turn save off 
dev.off()

# open png for file save and define size and resolution
png(paste("plots/calibration.test/", "CH4 calibration", ".png", sep=""), 
    width=1200, height=900, res=150)

ggplot(dat, aes(x = t, y = `Methane|Amount`, group = chamber)) +
  geom_line(aes(color = chamber)) +
  geom_point(aes(color = chamber)) + 
  ylim(1.9,2.15) + 
  ggtitle(label = "Calibration test 06/03/2023 - Methane", subtitle = "No rubber seals")

# turn save off 
dev.off()
