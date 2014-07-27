Data Description
================

Processing
----------

Below is a complete list of the variables computed by the run_analysis.R script
and saved in `tidy_dataset.csv`.  They are derived from the feature variables
provided by the `UCI HAR Dataset`, listed in `UCI HAR Dataset/features.txt`,
which describe the accelerometer and gyroscope measurements in the training and
test data sets, saved in the `X_train.txt` and `X_test.txt` files.  The files
used by `run_analysis`.R are:

Test data set
* UCI HAR Dataset/train/X_train.txt - gyroscope and accelerometer data
* UCI HAR Dataset/train/y_train.txt - subject's activity (1-6)
* UCI HAR Dataset/train/subject_train.txt - subject id (1-30)

Training data set
* UCI HAR Dataset/test/X_test.txt - gyroscope and accelerometer data
* UCI HAR Dataset/test/y_test.txt - subject's activity (1-6)
* UCI HAR Dataset/test/subject_test.txt - subject id (1-30)

Auxillary data
* UCI HAR Dataset/activity_labels.txt - maps 1-6 to activity labels
* UCI HAR Dataset/features.txt - the feature variable names

The run_analysis.R script and computes the new variables as follows:

1. adds `subject` and `activity` variables, from `activity_labels.txt` and `y_<test|train>.txt`
2. Changes variable name formatting - replaces redundant 'BodyBody' with
'Body', removes '()' and '-', and sets to lower case)
3. Computes the mean of each variable by subject and by activity


Variables
---------

Variables beginning with 'f' denote frequency domain measurements, and those
beginning with 't' denote time domain measurements.

subject
activity
tbodyaccmeanx
tbodyaccmeany
tbodyaccmeanz
tbodyaccstdx
tbodyaccstdy
tbodyaccstdz
tgravityaccmeanx
tgravityaccmeany
tgravityaccmeanz
tgravityaccstdx
tgravityaccstdy
tgravityaccstdz
tbodyaccjerkmeanx
tbodyaccjerkmeany
tbodyaccjerkmeanz
tbodyaccjerkstdx
tbodyaccjerkstdy
tbodyaccjerkstdz
tbodygyromeanx
tbodygyromeany
tbodygyromeanz
tbodygyrostdx
tbodygyrostdy
tbodygyrostdz
tbodygyrojerkmeanx
tbodygyrojerkmeany
tbodygyrojerkmeanz
tbodygyrojerkstdx
tbodygyrojerkstdy
tbodygyrojerkstdz
tbodyaccmagmean
tbodyaccmagstd
tgravityaccmagmean
tgravityaccmagstd
tbodyaccjerkmagmean
tbodyaccjerkmagstd
tbodygyromagmean
tbodygyromagstd
tbodygyrojerkmagmean
tbodygyrojerkmagstd
fbodyaccmeanx
fbodyaccmeany
fbodyaccmeanz
fbodyaccstdx
fbodyaccstdy
fbodyaccstdz
fbodyaccmeanfreqx
fbodyaccmeanfreqy
fbodyaccmeanfreqz
fbodyaccjerkmeanx
fbodyaccjerkmeany
fbodyaccjerkmeanz
fbodyaccjerkstdx
fbodyaccjerkstdy
fbodyaccjerkstdz
fbodyaccjerkmeanfreqx
fbodyaccjerkmeanfreqy
fbodyaccjerkmeanfreqz
fbodygyromeanx
fbodygyromeany
fbodygyromeanz
fbodygyrostdx
fbodygyrostdy
fbodygyrostdz
fbodygyromeanfreqx
fbodygyromeanfreqy
fbodygyromeanfreqz
fbodyaccmagmean
fbodyaccmagstd
fbodyaccmagmeanfreq
fbodyaccjerkmagmean
fbodyaccjerkmagstd
fbodyaccjerkmagmeanfreq
fbodygyromagmean
fbodygyromagstd
fbodygyromagmeanfreq
fbodygyrojerkmagmean
fbodygyrojerkmagstd
fbodygyrojerkmagmeanfreq
