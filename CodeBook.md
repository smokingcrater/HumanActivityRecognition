CodeBook
========================================================

## Overview

This assignment involved downloading and manipulating a "Human Activity Recognition"
database containing sensor measurements compiled during an experiment involving 30
volunteers performing 6 activities while wearing a Samsung Galaxy smartphone (visit
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
for a more detailed overview of the original experiment).

## Input

A zip file retrieved via a URL provided by Professor Leek.

## Output

Two dataframes:

* har: an R dataframe comprised of 66 mean and standard deviation measurements from both
  the training and test data sets.
* har_reshaped: an R dataframe where each row includes the averages for each of the 66
  mean and standard deviation measurement for each unique user/activity combination.
  Since there were 30 participants performing 6 activities, there are 180 rows.

## Process

I've provided comments in the run_analysis.R script detailing the steps.  From a high-
level perspective, the script does the following:

* Downloads and unzips the original data set.
* Parses the features.txt file provided in the original data set to determine columns
  in the original data set containing either mean or standard deviation measurements.
* Parses the activity_labels.txt file to determine the descriptive names for the
  activities referenced by number in the original data set.
* Processes the TRAIN data set merging the participants ids, descriptive activity
  names, and sensor measurements (mean and standard deviation only) into a single R
  dataframe.
* Performs the preceding step on the TEST data set.
* Combines the merged TRAIN R dataframe with the merged TEST R dataframe to produce a
  master R dataframe.
* Reshapes the master R dataframe to produce a tidy dataframe which includes a row
  documenting averages of the mean and standard deviation measurements for each of the
  participant/activity combinations.

## Variables

The first two column names in both the har and har_reshaped dataframes are as follows:

> colnames(har_reshaped[,1:2])
[1] "subject_id"    "activity_name"

The subject_id includes values from 1 to 30 representing the IDs assigned to the 30
subjects in the original data set.

The activitiy_name is the descriptive name associated with the activity ID in the original
data set.

To avoid repeating the detailed variable naming conventions adopted by the individuals
conducting the original experiment, please reference the file called features_info.txt,
which was included in the original data zip file.

Given Professor Leek's instructions to produce a tidy data set from only mean and standard
deviation measurements, the script parses 66 of the original 561 variables.  These 66
variables retain their original data set names as follows:

> colnames(har_reshaped[,3:68])
 [1] "tBodyAcc-mean()-X"           "tBodyAcc-mean()-Y"           "tBodyAcc-mean()-Z"          
 [4] "tBodyAcc-std()-X"            "tBodyAcc-std()-Y"            "tBodyAcc-std()-Z"           
 [7] "tGravityAcc-mean()-X"        "tGravityAcc-mean()-Y"        "tGravityAcc-mean()-Z"       
[10] "tGravityAcc-std()-X"         "tGravityAcc-std()-Y"         "tGravityAcc-std()-Z"        
[13] "tBodyAccJerk-mean()-X"       "tBodyAccJerk-mean()-Y"       "tBodyAccJerk-mean()-Z"      
[16] "tBodyAccJerk-std()-X"        "tBodyAccJerk-std()-Y"        "tBodyAccJerk-std()-Z"       
[19] "tBodyGyro-mean()-X"          "tBodyGyro-mean()-Y"          "tBodyGyro-mean()-Z"         
[22] "tBodyGyro-std()-X"           "tBodyGyro-std()-Y"           "tBodyGyro-std()-Z"          
[25] "tBodyGyroJerk-mean()-X"      "tBodyGyroJerk-mean()-Y"      "tBodyGyroJerk-mean()-Z"     
[28] "tBodyGyroJerk-std()-X"       "tBodyGyroJerk-std()-Y"       "tBodyGyroJerk-std()-Z"      
[31] "tBodyAccMag-mean()"          "tBodyAccMag-std()"           "tGravityAccMag-mean()"      
[34] "tGravityAccMag-std()"        "tBodyAccJerkMag-mean()"      "tBodyAccJerkMag-std()"      
[37] "tBodyGyroMag-mean()"         "tBodyGyroMag-std()"          "tBodyGyroJerkMag-mean()"    
[40] "tBodyGyroJerkMag-std()"      "fBodyAcc-mean()-X"           "fBodyAcc-mean()-Y"          
[43] "fBodyAcc-mean()-Z"           "fBodyAcc-std()-X"            "fBodyAcc-std()-Y"           
[46] "fBodyAcc-std()-Z"            "fBodyAccJerk-mean()-X"       "fBodyAccJerk-mean()-Y"      
[49] "fBodyAccJerk-mean()-Z"       "fBodyAccJerk-std()-X"        "fBodyAccJerk-std()-Y"       
[52] "fBodyAccJerk-std()-Z"        "fBodyGyro-mean()-X"          "fBodyGyro-mean()-Y"         
[55] "fBodyGyro-mean()-Z"          "fBodyGyro-std()-X"           "fBodyGyro-std()-Y"          
[58] "fBodyGyro-std()-Z"           "fBodyAccMag-mean()"          "fBodyAccMag-std()"          
[61] "fBodyBodyAccJerkMag-mean()"  "fBodyBodyAccJerkMag-std()"   "fBodyBodyGyroMag-mean()"    
[64] "fBodyBodyGyroMag-std()"      "fBodyBodyGyroJerkMag-mean()" "fBodyBodyGyroJerkMag-std()" 

