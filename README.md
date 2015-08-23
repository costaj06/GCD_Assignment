Run_Analysis.R -   READ.ME



In the submission box, as well as the link, put some accompanying text on another line something like "tidy data as per the ReadMe that can be read into R with read.table(header=TRUE) {listing any settings you have changed from the default}" This is just to make it really easy for your reviewer.
In the readMe in explaining what the script does put "and then generates a tidy data text file that meets the principles of a Tidy Data Set"
the truly cunning may want to put in a citation to this discussion and/or Hadley's paper
The codebook still has the specific description of the tidy data file contents (and you mention that it exists and it's role in the ReadMe)

It also means that (I think) people should be reasonably generous in marking the tidy data aspects. Many forms are tidy, you have to do something like wind up with subject and activity in the same column to be untidy (which can happen with some methods), or a series of tables, or extra unlabelled columns (which can also happen with some ways of generating summaries if you do not then remove them afterwards). My own checklist is:

Does it have headings so I know which columns are which.
Are the variables in different columns (depending on the wide/long form)
Are there no duplicate columns
There is really not much more to tidy data

==================================================================
Run_analysis.R script for summarizing the "Human Activity Recognition Using Smartphones Dataset Version 1.0" dataset
==================================================================
SEE HEADINGS below to learn about the INPUT FILES, OUTPUT FILE, SCRIPT OPERATION, and CODEBOOK
==================================================================

INPUT FILES:
The Run_analysis.R script reads in the "Human Activity Recognition Using Smartphones Dataset Version 1.0" dataset compiled by Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto, which is available from the UCI Machine Learning Repository at http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones.


The Human Activity Recognition Using Smartphones Dataset Version 1.0 which is the basis of the input data for the Run_analysis.R script contains data from experiments that have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. 

For each record the "Human Activity Recognition Using Smartphones Dataset Version 1.0" dataset provided:
======================================

- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.

The "Human Activity Recognition Using Smartphones Dataset Version 1.0" dataset used as input to the Run_analysis.R script includes the following files:
=========================================

- 'README.txt'

- 'features_info.txt': Shows information about the variables used on the feature vector.

- 'features.txt': List of all features.

- 'activity_labels.txt': Links the class labels with their activity name.

- 'train/X_train.txt': Training set.

- 'train/y_train.txt': Training labels.

- 'test/X_test.txt': Test set.

- 'test/y_test.txt': Test labels.

The following files are available for the train and test data. Their descriptions are equivalent. 

- 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 

- 'train/Inertial Signals/total_acc_x_train.txt': The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. Every row shows a 128 element vector. The same description applies for the 'total_acc_x_train.txt' and 'total_acc_z_train.txt' files for the Y and Z axis. 

- 'train/Inertial Signals/body_acc_x_train.txt': The body acceleration signal obtained by subtracting the gravity from the total acceleration. 

- 'train/Inertial Signals/body_gyro_x_train.txt': The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second. 

Notes: 
======
- Features are normalized and bounded within [-1,1].
- Each feature vector is a row on the text file.

For more information about this dataset contact: activityrecognition@smartlab.ws


MORE ABOUT THE Run_Analysis.R Script:

The Run_Analysis.R Script performs the following tasks:
	(1) Reads in and merges the training and test data sets to create one data set.  (See Part #1 in the comments fo the Script).
	(2) Extracts only the measurements on the mean and standard deviation for each measurement (Part #2 in the comments in the Script)
	(3) Uses descriptive activity names to name the activities in the data set
	(4) Labels the data set with descriptive variable names keyed by the names indicated in the Codebook.
	(5) Creates a file ("SummarizedTidyDataSet.txt") containing a second, independent tidy data set with the average of each varable for each activity and each subject.

OUTPUT FILE:

The tidy data set results in an output file called "SummarizedTidyDataSet.txt".  

SummarizedTidyDataSet.txt contains four columns (variable names) labeled: "Activity" "Subject" "Variable Name" "Mean by Activity and Subject".  
	"Activity" identifies which of 6 activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) a subject was performing for the measurements identified under the column "Variable Name".
	"Subject" identifies the particular subject who performed the activities for the measurements identified under the column "Variable Name".
	"Variable Name" identifies the particular variable for which measurements were taken.  The variable names are described in the CodeBook.
	"Mean by Activity and Subject" takes the mean for each variable by subject and activity.

SCRIPT OPERATION:

To generate "SummarizedTidyDataSet.txt", Run_Analysis.R uses (installs and runs) the "dplyr", "reshape" and "tidyr" packages in R.  First, it reads in each of the train and test data sets and then rbinds them together into a single dataframe.  It then adheres the columnnames from the features.txt file to appropriately label each column.  Following this, it parses the column names and extracts columns containing the string "mean" and "std" and cbinds them back into a new dataframe.  Next, it reads in and merges the train and test Activity data from independent files into a vector and labels the vector with the name "Activity".  It does the same for the train and test Subject files, and then cbinds the "Activity" and "Subject" vectors to the left of the mean and std dataframe.  The script then proceeds to convert the Activity levels (1, 2, 3, 4, 5, 6) into readable values (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) as identified from the Activity Labels file.  

At this point, the dataset is ready to turn into a tidy data set.  For this project, the dataset is melted into a tall data set by "Activity" and "Subject" columns.  The tall data set is then grouped by Activity, Subject and variable name, and then the "summarise_each" function is applied to the grouped data set, applying the mean function to generate the mean of each variable on an Activity by Subject basis.  The table is then written to "SummarizedTidyDataSet.txt".

CODEBOOK:

SummarizedTidyDataSet.txt contains four columns (variable names) labeled: "Activity" "Subject" "Variable Name" "Mean by Activity and Subject".  
	"Activity" identifies which of 6 activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) a subject was performing for the measurements identified under the column "Variable Name".
	"Subject" identifies the particular subject who performed the activities for the measurements identified under the column "Variable Name".
	"Variable Name" identifies the particular variable for which measurements were taken.  The variable names are described in the CodeBook.
	"Mean by Activity and Subject" takes the mean for each variable by subject and activity.

The "Variable Name" may take on the following values, differentiated by the X, Y, and Z dimensions:
	tBodyAcc-XYZ
	tGravityAcc-XYZ
	tBodyAccJerk-XYZ
	tBodyGyro-XYZ
	tBodyGyroJerk-XYZ
	tBodyAccMag
	tGravityAccMag
	tBodyAccJerkMag
	tBodyGyroMag
	tBodyGyroJerkMag
	fBodyAcc-XYZ
	fBodyAccJerk-XYZ
	fBodyGyro-XYZ
	fBodyAccMag
	fBodyAccJerkMag
	fBodyGyroMag
	fBodyGyroJerkMag


The features for the Variable Name come from the accelerometer ('Acc') and gyroscope ('Gyro') 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.


	
License:
========
Use of the "Human Activity Recognition Using Smartphones Dataset Version 1.0" dataset in publications must be acknowledged by referencing the following publication [1] 

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

This dataset is distributed AS-IS and no responsibility implied or explicit can be addressed to the authors or their institutions for its use or misuse. Any commercial use is prohibited.

Jorge L. Reyes-Ortiz, Alessandro Ghio, Luca Oneto, Davide Anguita. November 2012.
