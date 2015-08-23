library(reshape2)
library(plyr)
#Read the raw training and test data
training_X <- read.table("UCI_HAR_Dataset/train/X_train.txt", header=F, fill=T)
training_Y <- read.table("UCI_HAR_Dataset/train/y_train.txt", header=F, fill=T)
training_subject <- read.table("UCI_HAR_Dataset/train/subject_train.txt", header=F, fill=T)
test_X <- read.table("UCI_HAR_Dataset/test/X_test.txt", header=F, fill=T)
test_Y <- read.table("UCI_HAR_Dataset/test/y_test.txt", header=F, fill=T)
test_subject <- read.table("UCI_HAR_Dataset/test/subject_test.txt", header=F, fill=T)

#Step 1: combine the dataset into 1 big data frame
data <- rbind(training_X, test_X)
activity <- rbind(training_Y, test_Y)
colnames(activity) <- c("activity")
subject <- rbind(training_subject, test_subject)
colnames(subject) <- c("subject")

#Step 3: Read the acivity labels.  Each row corresponds to a feature name
activity_labels <-read.table("UCI_HAR_Dataset/activity_labels.txt")
#Use descriptive activity names (activity_labels col 2) to name the activity
activity[,1] <- mapvalues(activity[,1], from = 1:6, to = as.character(activity_labels[,2]))

#Read the features.  Each row corresponds to a feature name
features <-read.table("UCI_HAR_Dataset/features.txt")
#Label the data set with feature names for easier search of "mean" and "std" columns
colnames(data) <- features[,2]  #The name is in the second column

#The following is actually step 2 in the assignment:  Extract only the mean() and std() measurements
#Get the mean and standard deviation columns
meanstdCols <- grep("mean\\(\\)|std\\(\\)", names(data))
meanstdCols <- sort(meanstdCols)
#Generate a new data frame with only mean and standard deviation columns
meanstd_data <- data[, meanstdCols]
meanstd_data <- cbind(meanstd_data, subject, activity)

#Step 5: Generate tidy data by grouping according to activity and subject
meanstd_dataMelt <- melt(meanstd_data,id=c("subject", "activity"))
#Calculate the mean of each subject's activity for the chosen variables
tidyData <- dcast(meanstd_dataMelt, activity + subject ~ variable,mean)

#Step 4: Labels the data set with descriptive variable names
varNames <- sub("^t", "time", names(tidyData) )
varNames <- sub("^f", "freq", varNames )
varNames <- sub("Acc", "Accelerometer", varNames )
varNames <- sub("Gyro", "Gyroscope", varNames )
varNames <- sub("Mag", "Magnitude", varNames )
varNames <- sub("BodyBody", "Body", varNames )  #Fix a typo in the original feature names
varNames <- sub("-mean\\(\\)", "AverageMean", varNames )
varNames <- sub("-std\\(\\)", "AverageStdDeviation", varNames )
names(tidyData) <- varNames
