Overview
--------

This project provides an R script `run_analysis.R` to process the data 
collected from the accelerometers of the the Samsung Galaxy S smartphone worn
by 30 volunteers performing activities of daily living
(http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

Given the data set, downloaded from
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip,
it produces a csv file `tidy_dataset.csv` which contains the processed data described
in `CodeBook.md`.


Setup
-----

    git clone https://github.com/reckbo/getting-and-cleaning-data-project
    cd getting-and-cleaning-data-project
    wget https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
    unzip "getdata-projectfiles-UCI HAR Dataset.zip"


How to Run
----------

In R:

    source('run_analysis.R')

From the command line:

    Rscript run_analysis.R

or

    R CMD BATCH run_analysis.R


