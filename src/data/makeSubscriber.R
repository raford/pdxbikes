# pdxbikes data analysis project R script for creating time traveler data
# Raymond A. Ford (raymond.anthony.ford@gmail.com)
# GitHub: https://github.com/raford/pdxbikes
#
# PURPOSE: This script will generate a data set containing the observations
# that were labelled as "Subscriber" users.
#
# A pdf version the notebook that looked at these observations can be found at: 
# https://github.com/raford/pdxbikes/tree/master/notebooks/dataAggregator

require(zoo)
totals <- function(x){
  # This function will take a numerical vector x and output the sum of x and
  # the mean of x.
  # ----------
  # INPUT
  # x := a numerical vector.
  # ----------
  # OUTPUT
  # A data object with columns containing the sum and mean of x.
  c(sum=sum(x), mean=mean(x))
}

int.dat <- read.csv("https://raw.githubusercontent.com/raford/pdxbikes/master/data/interim/interim.csv",
                    header=TRUE, sep=",")

sub.dat <- subset(int.dat, PaymentPlan == "Subscriber")[, -1] # Payment plan in first column
rm(int.dat)

sub.dat$StartDate <- as.Date(sub.dat$StartDate)
Date <- seq.Date(from=min(sub.dat$StartDate), to=max(sub.dat$StartDate), "days")
sub.dat <- sub.dat[, -c(2, 3, 4, 7)]
sub.dat.agg <- read.zoo(sub.dat, header=TRUE, aggregate=totals)
sub.dat.agg <- cbind(Date, as.data.frame(sub.dat.agg))
write.csv(sub.dat.agg, file="~/GoogleDrive/pdxbikes/pdxbikes/data/aggregate/subscriber.csv",
          row.names=FALSE)
rm(sub.dat, sub.dat.agg)
