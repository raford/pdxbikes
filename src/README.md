This directory contains the R scripts used throughout this project. Where it
differs from the other directories is that this directory only contains the R
scripts (i.e. no notebooks and no commentary).


Below you will find a brief description of these scripts along with what they
do.


makeInterimData.R  := this script will take all of the raw data obtained from
    from Nike's Biketown PDX website and create an interim data set to be used
    throughout the rest of this project.


makeTimeTravel.R   := this script will create a data set containing interesting
    observations for which either the starting/ending date of the trip is
    outside of the range of the dates that Nike's Biketown PDX has been in
    operation.


makeSpeedDemons.R  := this script will create a data set containing interesting
    observations for which the individual exceeded 2200mph (the top speed of
    the SR-71A), as it is physically impossible for a human to attain this
    speed on any bicycle. It should be noted that the raw data also contains
    other speeds impossible for humans to achieve but this cut off was chosen
    somewhat arbitrarily after watching a documentary about Lockheed's SR-71
    during the COVID lockdown, and it's a pretty insane number.