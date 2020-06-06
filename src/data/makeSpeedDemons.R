# pdxbikes data analysis project R script for creating speed demon data
# Raymond A. Ford (raymond.anthony.ford@gmail.com)
# GitHub: https://github.com/raford/pdxbikes
#
# PURPOSE: This script will generate a data set containing the observations
# that were labelled as speed demons. We used a speed cut off of 2200 mph, as
# this is the publicly disclosed speed of the SR-71 listed on Wikipedia. There
# are of course many other observations that traveled way faster than what is
# humanly possible, but this is the cutoff that was chosen.
#
# A pdf version the notebook that looked at these observations can be found at: 
# https://github.com/raford/pdxbikes/blob/master/notebooks/notableMentions/notableMentions.pdf

setwd("~/GoogleDrive/pdxbikes/pdxbikes/data/raw/")
file.names <- list.files(pattern="*.csv")
make.df <- lapply(file.names, read.csv)
rm(file.names) # We do not need these anymore, so it's best to remove them.
dat.raw <- do.call(rbind.data.frame, make.df)
rm(make.df)

speed.demon <- dat.raw
rm(dat.raw) # We no longer need this.
speed.demon$Duration <- sapply(strsplit(as.character(speed.demon$Duration),":"),
                               function(x) {
                                 x <- as.numeric(x)
                                 x[1]*60+x[2]+x[3]/60
                               }
)
speed.demon <- speed.demon[!is.na(speed.demon$Duration), ]
speed.demon <- speed.demon[!is.na(speed.demon$Distance_Miles), ]
speed.demon$Mph <- (speed.demon$Distance_Miles / speed.demon$Duration) * 60

speed.demon <- subset(speed.demon, Mph > 2200)

write.csv(speed.demon, file="~/GoogleDrive/pdxbikes/pdxbikes/data/notableMentions/speeddemons.csv",
          row.names=FALSE)
