#Overview
This is a course project from Getting and Cleaning Data course in Coursera. This project is to create a tidy data set from messy data, that can be used later for analysis. This repo explains how all of the scripts work and how they are connected. A full description of how the project data source can be found here. The data used for the project is available here.

#Data Set Information
The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See 'features_info.txt' for more details. 

#Data Recorded
<ul>
<li>Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.</li>
<li>Triaxial Angular velocity from the gyroscope.</li>
<li>A 561-feature vector with time and frequency domain variables.</li>
<li>Its activity label. </li>
<li>An identifier of the subject who carried out the experiment.</li>
</ul>

#Tasks
The following tasks are expected to be carried out using R script called run_analysis.R that does the following.
<ol>
<li>Merges the training and the test sets to create one data set.</li>
<li>Extracts only the measurements on the mean and standard deviation for each measurement.</li>
<li>Uses descriptive activity names to name the activities in the data set.</li>
<li>Appropriately labels the data set with descriptive variable names.</li>
<li>From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.</li>

##Task 1
The following text files are read into the table format in R. The tables are appropriately labelled, a complete training and test data sets are formed respectively. The training and test data sets are combined using rbind and called finalData.

**Common Data**
<ul>
<li>features.txt (dimension of 561 rows and 2 columns - contains the row number and names of the features)</li>
<li>activity_labels.txt (dimension of 6 rows and 2 columns - contains the row number and names of the six types of activities recorded)</li>
</ul>

**Training Data**
<ul>
<li>X_train.txt (dimension of 7352 rows and 561 columns - contains the 7352 rows of readings (measurement) and feature columns)</li>
<li>y_train.txt (dimension of 7352 rows and 1 column - contains the activity ID (ranges from 1 to 6 belonging to an activity; the labels are in the activity_labels.txt)</li>
<li>subject_train.txt (dimension of 7352 rows and 1 column - contains the subject ID (ranges from 1 to 30 as there are 30 volunteers for the experiment) </li>
</ul>

**Test Data**
<ul>
<li>X_test.txt (dimension of 2947 rows and 561 columns - contains the 2947 rows of readings (measurement) and feature columns)</li>
<li>y_test.txt (dimension of 2947 rows and 1 column - contains the activity ID (ranges from 1 to 6 belonging to an activity; the labels are in the activity_labels.txt)</li>
<li>subject_test.txt (dimension of 2947 rows and 1 column - contains the subject ID (ranges from 1 to 30 as there are 30 volunteers for the experiment) </li>
</ul>

##Task 2
Only the mean and standard deviation (std) data was extracted using grep function on the column names of the complete dataset. This dataset is called "trimData".

##Task 3
The activity type is included to the "trimData" using merge function and it is called mergeData. 

##Task 4
gsub and for loop function is used to add descriptive names (provided in camelCase) on the columns of "mergeData"

##Task 5
This is accomplished using the aggregate function in the tidyr package. Write.table function is used to get the output of the tidy data. 

#Feature Names
The features selected for this database come from the accelerometer (Acc-XYZ) and gyroscope (Gyro-XYZ) 3-axial raw signals (measures in 3 directions X,Y and Z). The "t" denotes the time and "f" denotes the frequency that is in the feature names and the singals were captured at a constant rate of 50 Hz. The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.Features are normalized and bounded within [-1,1].

<ul>
<li>tBodyAcc-XYZ</li>
<li>tGravityAcc-XYZ</li>
<li>tBodyAccJerk-XYZ</li>
<li>tBodyGyro-XYZ</li>
<li>tBodyGyroJerk-XYZ</li>
<li>tBodyAccMag</li>
<li>tGravityAccMag</li>
<li>tBodyAccJerkMag</li>
<li>tBodyGyroMag</li>
<li>tBodyGyroJerkMag</li>
<li>fBodyAcc-XYZ</li>
<li>fBodyAccJerk-XYZ</li>
<li>fBodyGyro-XYZ</li>
<li>fBodyAccMag</li>
<li>fBodyAccJerkMag</li>
<li>fBodyGyroMag</li>
<li>fBodyGyroJerkMag</li>
</ul>

The set of variables that were estimated (and kept for this assignment) from these signals are:

<li>mean(): Mean value</li>
<li>std(): Standard deviation value</li>

Additional vectors obtained by averaging the signals in a signal window sample. 

<li>gravityMean</li>
<li>tBodyAccMean</li>
<li>tBodyAccJerkMean</li>
<li>tBodyGyroMean</li>
<li>tBodyGyroJerkMean</li>

Other estimates have been removed as part of the assignment tasks above.

