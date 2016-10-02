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
names(data) <- sapply(names(data), ToCamelCase)
# add columns

data = as.data.table(data)

data[ , OpenChange := OPEN / shift(OPEN, 1L, type="lag")]
data[ , HighChange := OPEN / shift(OPEN, 1L, type="lag")]
data[ , LowChange := OPEN / shift(OPEN, 1L, type="lag")]
data[ , CloseChange := OPEN / shift(OPEN, 1L, type="lag")]
data[ , VolumeChange := OPEN / shift(OPEN, 1L, type="lag")]

rm(list = ls())

# Split into training and validation

validation_index <- createDataPartition(dataset$Species, p=0.80, list=FALSE)

validation <- dataset[-validation_index,]

dataset <- dataset[validation_index,]