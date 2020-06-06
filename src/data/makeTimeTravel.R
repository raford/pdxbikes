# pdxbikes data analysis project R script for creating time traveler data
# Raymond A. Ford (raymond.anthony.ford@gmail.com)
# GitHub: https://github.com/raford/pdxbikes
#
# PURPOSE: This script will generate a data set containing the observations
# that were labelled as time travelers (i.e their trip's start or end date is
# outside of the timeframe for which Biketown PDX was/currently is operational).
#
# A pdf version the notebook that looked at these observations can be found at: 
# https://github.com/raford/pdxbikes/blob/master/notebooks/notableMentions/notableMentions.pdf

setwd("~/GoogleDrive/pdxbikes/pdxbikes/data/raw/")
file.names <- list.files(pattern="*.csv")
make.df <- lapply(file.names, read.csv)
rm(file.names) # We do not need these anymore, so it's best to remove them.
dat.raw <- do.call(rbind.data.frame, make.df)
rm(make.df)

dat.raw$StartDate <- as.Date(dat.raw$StartDate, format="%m/%d/%Y")
dat.raw$EndDate <- as.Date(dat.raw$EndDate, format="%m/%d/%Y")

known.dates <- as.factor(seq(as.Date("2016-07-19"), as.Date("2020-03-31"), "days"))
in.known.range <- which(as.factor(dat.raw$EndDate) %in% known.dates)
time.travel <- dat.raw[-in.known.range, ]
rm(in.known.range, known.dates, dat.raw)

time.travel <- time.travel[!is.na(time.travel$EndDate), ]

write.csv(time.travel, file="~/GoogleDrive/pdxbikes/pdxbikes/data/notableMentions/timetravel.csv",
          row.names=FALSE)