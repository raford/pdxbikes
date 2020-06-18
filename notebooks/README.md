This folder contains notebooks used throughout the analysis of this project.
Each folder contains the following: a R-markdown file (.Rmd) for the notebook,
a HTML version of the notebook (.nb.html), and a PDF version of the notebook to
make accessing the notebook easier through GitHub without having to download 
any files.


Below you will find a brief description of each of the folders, along with
their contents.


/dataAggregator/     := contains the code, and some brief commentary, used to
	create daily aggregate statistics for trip duration and trip distance.


/dataPreprocessing/  := contains the code, and commentary, that led to the
    creation of the interim data set that will later be refined for analysis.


/notableMentions/    := contains the code, and commentary, of some of the more
    interesting observations contained in the original data that were removed
    from the original data to create the interim data. In particular, we looked
    at individuals that had began/ended a trip outside of the time range of
    Biketown PDX's time in operation and speeds that defy reason.