#clean up workspace
rm(list =ls())

#Note that the downloaded zip file is unzipped in 'data' folder, which is in my working directory. Reading the required text files into R. This contains the training data elements. 
features = read.table("/Users/shalini/data/features.txt")
alabel = read.table("/Users/shalini/data/activity_labels.txt")
Xtrain = read.table("/Users/shalini/data/train/X_train.txt")
Ytrain = read.table("/Users/shalini/data/train/y_train.txt")
subjecttrain = read.table("/Users/shalini/data/train/subject_train.txt")

#giving column names to all these text files using appropriate labels 
colnames(alabel) <- c("activityID","activityType")
colnames(subjecttrain) <- ("subjectID")
colnames(Ytrain) <- ("activityID")
colnames(Xtrain) <- features[,2]

#combining the training data set
trainingData = cbind(Ytrain, subjecttrain, Xtrain)

#reading the required text files into R. This contains the test data elements. Already read features.txt and alabel.txt and this is common to both train and test data.
Xtest = read.table("/Users/shalini/data/test/X_test.txt")
Ytest = read.table("/Users/shalini/data/test/y_test.txt")
subjecttest = read.table("/Users/shalini/data/test/subject_test.txt")

#giving column names to all these text files using appropriate labels 
colnames(subjecttest) <- ("subjectID")
colnames(Ytest) <- ("activityID")
colnames(Xtest) <- features[,2]

#combining the test data set
testData = cbind(Ytest, subjecttest, Xtest)

#step 1 completed. Merged training and test data sets.
finalData <- rbind(trainingData, testData)

#Extracting the column indices of the column names containing mean or std (StdDev)
colmean <- grep("mean",names(finalData))
colstd <- grep("std",names(finalData))
#We need the first two columns having the activity and subject ID
colneed <- c(1,2,colmean,colstd)

#step 2 completed. trimmed data with only the columns we want. The column indices are above.
trimData <- finalData[, colneed] 

#step 3 completed. mereged the acitivity Type with the trimData.
mergeData <- merge(trimData,alabel, by.x="activityID", by.y="activityID")

#Changing the column names with descriptive variable names as appropriate using for loop.
colNames = colnames(mergeData)

for (i in 1:length(colNames))
{
  colNames[i] = gsub("\\()","",colNames[i])
  colNames[i] = gsub("-","",colNames[i])
  colNames[i]= gsub("^t","time",colNames[i])
  colNames[i]= gsub("^f","freq",colNames[i])
  colNames[i] = gsub("mean","Mean",colNames[i])
  colNames[i] = gsub("std","StdDev",colNames[i])
  colNames[i] = gsub("JerkMag","JerkMagnitude",colNames[i])
  colNames[i] = gsub("AccMag","AccMagnitude",colNames[i])
  colNames[i] = gsub("GyroMag","GyroMagnitude",colNames[i])
}

colnames(mergeData) = colNames

#step 4 completed above. Creating a second data set i.e. tidy data set with the average of each variable by actvity and by subject. Requires tidyr package.
tidyData = aggregate(mergeData,by=list(activity = mergeData$activityID, subject = mergeData$subjectID), mean)

#step 5 completed. removing the activitytype column as these become NA when doing the above step as it is a character class.
tidyData[,84] =NULL

#getting output of tidyData to upload
write.table(tidyData,"tidyData.txt", row.name = FALSE, sep="\t")

#to convert wide data to long data
#featureNames <- names(tidayData[5:83])
#tidyDataLong <- gather(tidyData, featureNames, mean, timeBodyAccMeanX:freqBodyBodyGyroJerkMagnitudeStdDev)
#tidyDataLong <- tidyDataLong[3:6]