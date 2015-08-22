# This is the markdown file for Getting and Cleaning Data course project
Course project instructions is found at: https://class.coursera.org/getdata-031/human_grading/view/courses/975115/assessments/3/submissions

## How to run the script
## Extracting the source data
1. Download the Samsung source data from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
2. Unzip the file in your working directory.  It will create a new directory called "UCI_HAR_Dataset" while the data inside sub-directories.

## Run the script.
1. Inside your R Studio, change to the directory containing the "run_analysis.R" script
2. source("run_analysis.R")
3. When this script is finished, the tidy data is stored in the data frame called "tidydata"
4. Use "write.table(tidydata, file="tidyData.txt", row.name=FALSE) command (without the quotes) to write the tidy data into text file.

## Details of how the "run_analysis.R" script works
1. The script first loads the required library "reshape2" and "plyr"
2. Then it reads the training and test raw data measurements into training_X, test_X respectively.
The subject doing the experiment is read from "subject_train.txt" and "subject_test.txt" respectively.
The training_Y/test_Y contains the activity the experiment subjects were doing when obtaining the "X" measurements.

3. Then the data are merged using rbind into a single data frame combining the training and test data.
The subject are also merged into a single data frame. (Step 1 of course project)

4. Now, the activity are labeled by descriptive acitivty labels. (Step 3 of course project)

5. The column names and activity/subject columns are added from the names in features.txt.

6. Now the mean and stddev are extracted (Step 2 of course project) and new data frame "meanstd_data" is created.

7. The meanstd_data are melted and cast again to generate tidyData, grouped by activity and subject.
The mean average is calculated for all the mean and standard deviation measurements each each acitvity/subject combination.

8. The variables in tidyData are labelled with descriptive variable names. (Step 4 of course project)

## Cookbook
Please refer to Cookbook.md