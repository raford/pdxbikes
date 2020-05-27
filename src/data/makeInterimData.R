# pdxbikes data analysis project R script for preprocessing the data
# Raymond A. Ford (raymond.anthony.ford@gmail.com)
# GitHub: https://github.com/raford/pdxbikes
#
# PURPOSE: This is an R script that can be used to generate the interim data set
# from the raw data found in /data/raw/ While the script can be created from the
# R notebooks, this script has been provided to make things easier for someone
# attempting to perform the same workflow. As such, all commentary found in the
# notebooks has been ommitted and only the necessary operations are located in
# this script.
#
# A pdf version the notebook containing the commentary/output from this script
# can be found at:
# https://github.com/raford/pdxbikes/blob/master/notebooks/dataPreprocessing/dataPreprocess.pdf

setwd("~/GoogleDrive/pdxbikes/pdxbikes/data/raw/")
file.names <- list.files(pattern="*.csv")
make.df <- lapply(file.names, read.csv)
rm(file.names) # We do not need these anymore, so it's best to remove them.
dat.raw <- do.call(rbind.data.frame, make.df)
rm(make.df)
dat.raw <- dat.raw[, -c(3, 8, 13:15)]
dat.raw <- dat.raw[-which(dat.raw$Duration==""), ]
large.start.longitude <- which(dat.raw$StartLongitude >= -122)
dat.raw <- dat.raw[-large.start.longitude, ]
rm(large.start.longitude) # We do not need this anymore.
dat.raw$Duration <- sapply(strsplit(as.character(dat.raw$Duration),":"),
                           function(x) {
                             x <- as.numeric(x)
                             x[1]*60+x[2]+x[3]/60
                           }
)
dat.raw$StartDate <- as.Date(dat.raw$StartDate, format="%m/%d/%Y")
dat.raw$EndDate <- as.Date(dat.raw$EndDate, format="%m/%d/%Y")
known.dates <- as.factor(seq(as.Date("2016-07-19"), as.Date("2020-03-31"), "days"))
in.known.range <- which(as.factor(dat.raw$EndDate) %in% known.dates)
dat.raw <- dat.raw[in.known.range, ]
rm(known.dates, in.known.range) # We do not need these anymore.
ex.out <- 3 * IQR(dat.raw$Duration)
dur.out.in <- which(dat.raw$Duration >= ex.out)
dat.raw <- dat.raw[-dur.out.in, ]
rm(dur.out.in, ex.out) # We no longer need these values
ex.out <- 3 * IQR(dat.raw$Distance_Miles)
dur.out.in <- which(dat.raw$Distance_Miles >= ex.out) 
dat.raw <- dat.raw[-dur.out.in, ]
rm(dur.out.in, ex.out) # We no longer need these values
dat.raw <- dat.raw[, -1]
dat.raw <- dat.raw[, -c(2, 3, 6, 7, 13)]

# Uncomment the below operation to write the data set to file.
#write.csv(dat.raw, file="~/GoogleDrive/pdxbikes/pdxbikes/data/interim/interim.csv",
#          row.names=FALSE)