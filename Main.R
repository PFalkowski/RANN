source("Helper.R")
SetupEnvironment(requiredPackages = c("caret", "reshape", "data.table"))

# read single file

data <- read.csv("../../../Downloads/mstcgl/MBANK.mst", header=TRUE)

# get data bulk
# http://stackoverflow.com/a/11433532/3922292
# temp = list.files(path = "../../../Downloads/test", pattern="*.mst", full.names	= TRUE)

# rename column names
names(data) <- gsub("X.", "", names(data))
names(data) <- gsub("\\.", "", names(data))

# add columns

data = as.data.table(data)

data[ , Change := OPEN / shift(OPEN, 1L, type="lag")]

rm(list = ls())