library(data.table)

numrecords <- 20

# -- Helper Functions --

getfilename <- function(datatype, dataset) {
    switch(datatype,
            activity=sprintf('UCI HAR Dataset/%s/y_%s.txt',dataset, dataset),
            subject=sprintf('UCI HAR Dataset/%s/subject_%s.txt', dataset, dataset),
            data=sprintf('UCI HAR Dataset/%s/X_%s.txt', dataset, dataset)
            )
}

read_data <- function(filename) {
    #return(read.fwf(filename, widths=rep(c(-1,15),561), header=FALSE, comment.char="", colClasses='numeric', nrows=numrecords)) 
    x <- fread(sprintf("sed -E 's/^ +//' %s | sed -E 's/ +/,/g'", filename))
    return(x)
    }

read_col <- function(filename ) {
    return(read.table(filename, nrows=numrecords)) }

# dataset: either 'train' or 'test'
get_dataframes <- function(dataset) {
        datatypes <- c('data', 'subject', 'activity')
        files <- mapply(getfilename, datatypes, rep(dataset,3), USE.NAMES=TRUE)
        read_functions <- c(read_data, read_col, read_col)
        names(read_functions) <- datatypes # this preserves the names when we return the data
        data <- mapply(do.call, read_functions, lapply(files, list))
        return(data)
}

# -- End Helper Functions --

# Read in the test and training sets, and their associated activity and subject columns, into datafames
test <- get_dataframes('test')
train <- get_dataframes('train')

# Read in the feature names to use as our initial column names
feature_names_file <- 'UCI HAR Dataset/features.txt'
feature_names <- read.table(feature_names_file, colClasses='character')[,2]

# 1. Merge the data into one dataframe
dataset = cbind(rbind(test$data, train$data), 
                 rbind(test$activity, train$activity),
                 rbind(test$subject, train$subject))


# Add initial column names to the data
names(dataset) <- c(feature_names, 'activity', 'subject')


# 2. Filter the dataframe to have only mean and standard deviation measurements
dataset_mean_std = dataset[,grep('mean|std|activity|subject', names(dataset))]


# 3. Replace the activity numbers with their more descriptive labels
activity_labels <- read.table('UCI HAR Dataset/activity_labels.txt')[,2]
dataset_mean_std$activity <- cut(dataset_mean_std$activity, breaks=6, labels=activity_labels)
