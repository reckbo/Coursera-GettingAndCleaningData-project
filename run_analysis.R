library(data.table)

# -- Helper Functions --

# Input
#   datatype: 'activity' or 'subject' or 'data'
#   dataset:  'test' or 'train'
# Returns
#   a file path to the data file
getfilename <- function(datatype, dataset) {
    switch(datatype,
            activity=sprintf('UCI HAR Dataset/%s/y_%s.txt',dataset, dataset),
            subject=sprintf('UCI HAR Dataset/%s/subject_%s.txt', dataset, dataset),
            data=sprintf('UCI HAR Dataset/%s/X_%s.txt', dataset, dataset)
            )
}

# Uses fread for fast reading.  Calls sed to replace white space with comma
# separators so that fread works correctly.
#
# Input
#   filename: test_X.txt or test_Y.txt
# Returns
#   data.table
read_data <- function(filename) {
    x <- fread(sprintf("sed -E 's/^ +//' \"%s\" | sed -E 's/ +/,/g'", filename))
    return(x)
    }

# Input
#   dataset: either 'train' or 'test'
# Returns
#   A vector of data table/frames (data=data.table, subject=data.frame, activity=data.frame)
get_tables <- function(dataset) {
        datatypes <- c('data', 'subject', 'activity')
        files <- mapply(getfilename, datatypes, rep(dataset,3), USE.NAMES=TRUE)
        read_functions <- c(read_data, read.table, read.table)
        names(read_functions) <- datatypes # this preserves the names when we return the data
        data <- mapply(do.call, read_functions, lapply(files, list))
        return(data)
}

# -- End Helper Functions --


# Read in the test and training sets, and their associated activity and subject columns, into datafames
test <- get_tables('test')
train <- get_tables('train')

# Read in the feature names to use as our initial column names
feature_names_file <- 'UCI HAR Dataset/features.txt'
feature_names <- read.table(feature_names_file, colClasses='character')[,2]

# 1. Merge the data into one data set
dataset = cbind(rbind(test$data, train$data), 
                 rbind(test$activity, train$activity),
                 rbind(test$subject, train$subject))


# Create initial column names to the data
setnames(dataset, c(feature_names, 'activity', 'subject'))


# 2. Extract only the measurements on the mean and standard deviation for each measurement. 
dataset_mean_std = dataset[,grep('mean|std|activity|subject', names(dataset)), with=FALSE]


# 3. Replace the activity numbers with their more descriptive labels
activity_labels <- read.table('UCI HAR Dataset/activity_labels.txt')[,2]
dataset_mean_std[,activity:=factor(dataset$activity, labels=activity_labels)]


# 4. Tidy the variable names (Fix redundant 'BodyBody', remove '()' and '-', and set to lower case)
tidy_names <- gsub('BodyBody', 'Body', names(dataset_mean_std), fixed=TRUE)
tidy_names <- gsub('()', '', tidy_names, fixed=TRUE)
tidy_names <- gsub('-', '', tidy_names, fixed=TRUE)
setnames(dataset_mean_std, tolower(tidy_names))

# 5. Create a second, independent tidy data set with the average of each variable
# for each activity and each subject. 
tidy_dataset  <- dataset_mean_std[, lapply(.SD, mean), by="subject,activity"]
write.csv(tidy_dataset, file="tidy_dataset.csv", row.names=FALSE)



