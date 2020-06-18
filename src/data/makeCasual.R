# pdxbikes data analysis project R script for creating time traveler data
# Raymond A. Ford (raymond.anthony.ford@gmail.com)
# GitHub: https://github.com/raford/pdxbikes
#
# PURPOSE: This script will generate a data set containing the observations
# that were labelled as "Casual" users.
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

cas.dat <- subset(int.dat, PaymentPlan == "Casual")[, -1] # Payment plan in first column
rm(int.dat)

cas.dat$StartDate <- as.Date(cas.dat$StartDate)
Date <- seq.Date(from=min(cas.dat$StartDate), to=max(cas.dat$StartDate), "days")
cas.dat <- cas.dat[, -c(2, 3, 4, 7)]
cas.dat.agg <- read.zoo(cas.dat, header=TRUE, aggregate=totals)
cas.dat.agg <- cbind(Date, as.data.frame(cas.dat.agg))
write.csv(cas.dat.agg, file="~/GoogleDrive/pdxbikes/pdxbikes/data/aggregate/casual.csv",
          row.names=FALSE)
rm(cas.dat, cas.dat.agg)