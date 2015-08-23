install.packages("dplyr")
library("dplyr")
install.packages("reshape2")
library("reshape2")
install.packages("tidyr")
library("tidyr")


## Part 1: Merge training and test sets to create one data set

## setwd("C:/Users/jcosta/Documents/Data Science//getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset")


##TrainingDataFileName <- "C:/Users/jcosta/Documents/Data Science//getdata-projectfiles-UCI HAR Dataset/UCI HAR ##Dataset//train/X_train.txt"
TrainingDataFileName <- "./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset//train/X_train.txt"
TrainingDataFile <- read.table(TrainingDataFileName)


##TestDataFileName <- "C:/Users/jcosta/Documents/Data Science//getdata-projectfiles-UCI HAR Dataset/UCI HAR TestDataFileName <- "./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset//test/X_test.txt"
TestDataFile <- read.table(TestDataFileName)


FullData <- rbind(TrainingDataFile, TestDataFile)  # Combine Training Data and Test Data into one data frame #


## Part 4: Label the data set with descriptive variable names
##columnNamesFile <- "C:/Users/jcosta/Documents/Data Science//getdata-projectfiles-UCI HAR Dataset/UCI HAR ##Dataset/features.txt"
columnNamesFile <- "C:/Users/jcosta/Documents/Data Science//getdata-projectfiles-UCI HAR Dataset/UCI HAR columnNames <- read.table(columnNamesFile)
columnNames <- columnNames[,2]
colnames(FullData) <- columnNames 


## Part 2: Extract only the measurements on the mean and standard deviation for each measurement

MeanDataSubset <- FullData[,grep("mean", colnames(FullData))]  # Subset for columns with "mean" in column name #

StdDataSubset <- FullData[,grep("std", colnames(FullData))]  # Subset for columns with "std" in column name #

MeanAndStdData <- cbind(MeanDataSubset, StdDataSubset)

# Add in subject and activity variables


# Add Activity variable first and append as left-most column
#Name of file containing vector of activities corresponding to each row #
##TrainingActivityFileName <- "C:/Users/jcosta/Documents/Data Science//getdata-projectfiles-UCI HAR Dataset/UCI HAR ##Dataset//train/y_train.txt"
TrainingActivityFileName <- "./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset//train/y_train.txt"
# Get vector of activities corresponding to each row #
TrainingActivityData <- read.table(TrainingActivityFileName) 
#Name of file containing vector of activities corresponding to each row #
##TestActivityFileName <- "C:/Users/jcosta/Documents/Data Science//getdata-projectfiles-UCI HAR Dataset/UCI HAR ##Dataset//test/y_test.txt"
# Get vector of activities corresponding to each row #
TestActivityFileName <- "./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset//test/y_test.txt"	
TestActivityData <- read.table(TestActivityFileName) 

#  Combine train and test Activity data into one vector
ActivityData <- rbind(TrainingActivityData, TestActivityData)
names(ActivityData) <- "Activity"
MeanAndStdData <- cbind(ActivityData, MeanAndStdData) 	#Add Activity column to left of data set


# Add Subject variable and append as left-most column

#Name of file containing vector of subjects corresponding to each row #
##TrainingSubjectFileName <- "C:/Users/jcosta/Documents/Data Science//getdata-projectfiles-UCI HAR Dataset/UCI HAR ##Dataset//train/subject_train.txt"
TrainingSubjectFileName <- "./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset//train/subject_train.txt"

# Get vector of activities corresponding to each row #	
TrainingSubjectData <- read.table(TrainingSubjectFileName) 

#Name of file containing vector of activities corresponding to each row #
##TestSubjectFileName <- "C:/Users/jcosta/Documents/Data Science//getdata-projectfiles-UCI HAR Dataset/UCI HAR ##Dataset//test/subject_test.txt"
TestSubjectFileName <- "./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset//test/subject_test.txt"
# Get vector of activities corresponding to each row
TestSubjectData <- read.table(TestSubjectFileName)  

#  Combine train and test Subject data into one vector
SubjectData <- rbind(TrainingSubjectData, TestSubjectData)
names(SubjectData) <- "Subject"
MeanAndStdData <- cbind(SubjectData, MeanAndStdData) 	#Add Subject column to left of data set


#  Part 3  Use descriptive activity names to name the activities in the data set
# Convert numeric activity label values to factor values #

#Name of file containing vector of activities corresponding to each row #
##TrainingActivityLabelsFileName <- "C:/Users/jcosta/Documents/Data Science//getdata-projectfiles-UCI HAR Dataset/UCI ##HAR Dataset/activity_labels.txt"
# Get vector of activities corresponding to each row #
TrainingActivityLabelsFileName <- "./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/activity_labels.txt"
TrainingActivityLabelsFile <- read.table(TrainingActivityLabelsFileName) 

activity_labels <- TrainingActivityLabelsFile$V2
MeanAndStdData <- within(MeanAndStdData, Activity <- factor(Activity, labels = activity_labels))




# Part 5 Create a tidy data set with the average of each variable for each activity and each subset


TidyDataSet <- melt(MeanAndStdData, id=c("Activity", "Subject"))
SortedTidyDataSet <- arrange(TidyDataSet, Activity, Subject)
castTidyDataSet <- group_by(SortedTidyDataSet, Activity, Subject, variable)
SummarizedTidyDataSet <- summarise_each(castTidyDataSet, funs(mean))
names(SummarizedTidyDataSet) <- c("Activity", "Subject", "Variable Name", "Mean by Activity and Subject")
write.table(SummarizedTidyDataSet, file = "SummarizedTidyDataSet.txt", row.name=FALSE)