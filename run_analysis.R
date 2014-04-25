# Load library for data shaping.
library(reshape2)

# Use "constants" for referring to raw data.
zip_src <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
zip_dest <- "sensordata.zip"

file_features <- "/features.txt"
file_activities <- "/activity_labels.txt"

file_subject_train <- "/subject_train.txt"
file_x_train <- "/X_train.txt"
file_y_train <- "/y_train.txt"

file_subject_test <- "/subject_test.txt"
file_x_test <- "/X_test.txt"
file_y_test <- "/y_test.txt"

# Download and unzip the raw data.
download.file(zip_src, zip_dest, method="curl")
sensordata_dir <- unzip(zip_dest)

# Revise "constants" to reflect local directory structure.
file_features <- sensordata_dir[grep(file_features, sensordata_dir)]
file_activities <- sensordata_dir[grep(file_activities, sensordata_dir)]

file_subject_train <- sensordata_dir[grep(file_subject_train, sensordata_dir)]
file_x_train <- sensordata_dir[grep(file_x_train, sensordata_dir)]
file_y_train <- sensordata_dir[grep(file_y_train, sensordata_dir)]

file_subject_test <- sensordata_dir[grep(file_subject_test, sensordata_dir)]
file_x_test <- sensordata_dir[grep(file_x_test, sensordata_dir)]
file_y_test <- sensordata_dir[grep(file_y_test, sensordata_dir)]

# Read in features.txt while 1) ignoring the first column and 2) converting the result into a vector instead of a data frame.
features <- as.vector(read.table(file_features, colClasses=c("NULL", NA))[,1])

# Generate a filter specifying only the columns pertaining to mean and standard deviation.
means <- grep("mean\\(\\)", features)
stds <- grep("std\\(\\)", features)
means_and_stds <- sort(c(means, stds))
col_filter <- features[means_and_stds]
col_classes <- rep("NULL", length(features))
for (mean_or_std in means_and_stds) {
	col_classes[mean_or_std] <- "numeric"
}

# Determine the set of activities.
activity_names <- as.vector(read.table(file_activities)[,2])

# Read the training data sets and create a single dataframe merging the subject, activity, and measurements.
xtrain <- read.table(file_x_train, colClasses=col_classes)
subject_train_id <- read.table(file_subject_train)
activity_train_id <- read.table(file_y_train)
activity_train_name <- factor(activity_train_id[,1], labels=activity_names)
xtrain <- data.frame(subject_train_id, activity_train_name, xtrain)
colnames(xtrain) <- c("subject_id", "activity_name", col_filter)

# Read the testing data sets and create a single dataframe merging the subject, activity, and measurements.
xtest <- read.table(file_x_test, colClasses=col_classes)
subject_test_id <- read.table(file_subject_test)
activity_test_id <- read.table(file_y_test)
activity_test_name <- factor(activity_test_id[,1], labels=activity_names)
xtest <- data.frame(subject_test_id, activity_test_name, xtest)
colnames(xtest) <- c("subject_id", "activity_name", col_filter)

# Produce a master dataframe comprised of both the training and testing data.
# This first dataframe (har) satisfies assignment objective 1 (merged data set).
har <- rbind(xtrain, xtest)

# Reshape the data to produce a tidy data set reflecting the average of each variable for each subject/activity pair.
# This second dataframe (har_reshaped) satisfies assignment objective 5 (tidy data set).
har_melted <- melt(har, id.vars=c("subject_id","activity_name"))
har_reshaped <- dcast(har_melted, formula= subject_id + activity_name ~ variable, mean)

# Uncomment the following to write and/or read the tidy data set to/from disk.
# write.table(har_reshaped, "har_tidy.txt", row.names=FALSE)
# har_tidy <- read.table("har_tidy.txt", header=TRUE, check.names=FALSE)
# or
# write.csv(har_reshaped, "har_tidy.csv", row.names=FALSE)
# har_tidy <- read.csv("har_tidy.csv", header=TRUE, check.names=FALSE)