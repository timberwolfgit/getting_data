# This is the markdown file for Getting and Cleaning Data course project
Course project instructions is found at: https://class.coursera.org/getdata-031/human_grading/view/courses/975115/assessments/3/submissions

## How to run the script
## Extracting the source data
* Download the Samsung source data from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
* Unzip the file in your working directory.  It will create a new directory called "UCI_HAR_Dataset" while keeping the directory structure.

## Run the script.
* Inside your R Studio, change to the directory containing the "run_analysis.R" script
* source("run_analysis.R")
* When this script is finished, the tidy data is stored in the data frame called "tidydata"
* Use "write.table(tidydata, file="tidyData.txt", row.name=FALSE) command (without the quotes) to write the tidy data into text file.

## Details of how the "run_analysis.R" script works
* The script first loads the required library "reshape2" and "plyr"
* Then it reads the training and test raw data measurements into training_X, test_X respectively.
The subject doing the experiment is read from "subject_train.txt" and "subject_test.txt" respectively.
The training_Y/test_Y contains the activity the experiment subjects were doing when obtaining the "X" measurements.

* Then the data are merged using rbind into a single data frame combining the training and test data.
The subject are also merged into a single data frame. (Step 1 of course project)

* Now, the activity are labeled by descriptive acitivty labels (Step 3 of course project)

* The column names and activity/subject columns are added for descriptive variable names (Step 4 of course project)

* Now the mean and stddev are extracted (Step 2 of course project) and new data frame "meanstd_data" is created.

* Finally, the meanstd_data are melted and cast again to generate tidyData, grouped by activity and subject.
The mean average is calculated for all the mean and standard deviation measurements each each acitvity/subject combination.

## Cookbook
Please refer to cookbook.txt