# Getting and Cleaning Data - Week 4 Assignment ---------------------------
# Author: Philip Wong
# Date: 12/24/2021

# Import Packages & Datasets ----------------------------------------------
library(tidyverse)

# Read train data
x_train_df <- read.table("UCI HAR Dataset/train/X_train.txt")
y_train_df <- read.table("UCI HAR Dataset/train/y_train.txt")
subject_train_df <- read.table("UCI HAR Dataset/train/subject_train.txt")

# Read test data 
x_test_df <- read.table("UCI HAR Dataset/test/X_test.txt")
y_test_df <- read.table("UCI HAR Dataset/test/y_test.txt") 
subject_test_df <- read.table("UCI HAR Dataset/test/subject_test.txt")

# Read features description 
features_df <- read.table("UCI HAR Dataset/features.txt") 

# Read activity labels 
activity_labels_df <- read.table("UCI HAR Dataset/activity_labels.txt") 

# 1. Merge the training and the test sets to create one data set ----------
x_total_df <- rbind(x_train_df, x_test_df)
y_total_df <- rbind(y_train_df, y_test_df)
subject_total_df <- rbind(subject_train_df, subject_test_df)

# 2. Extract only the measurements on the mean and std for each measurement --------
variable_extract_df <- features_df[str_detect(features_df[,2],"mean\\(\\)|std\\(\\)"),]
x_total_df <- x_total_df[,variable_extract_df[,1]]

# 3. Descriptive activity names to name the activities in the data --------
names(y_total_df) <- "Activity" # name the column header of dataframe
y_total_df$Activity_Label <- factor(y_total_df$Activity, labels = as.character(activity_labels_df[,2]))
Activity_Label <- y_total_df[,-1]

# 4. Label the data set with descriptive variable names -------------------
names(x_total_df) <- features_df[variable_extract_df[,1],2]

# 5. From the data set in step 4, create a second, independent tidy data set 
# with the average of each variable for each activity and each subject --------
names(subject_total_df) <- "Subject"
total_df <- cbind(x_total_df, Activity_Label, subject_total_df)
total_mean_df <- total_df %>% group_by(Activity_Label, Subject) %>% summarise_each(funs(mean))

# Export cleaned data set -------------------------------------------------
fn <- paste("UCI HAR Dataset/output/tidydata",".csv", sep = "")
if(file.exists(fn)){file.remove(fn)}
write_csv(as.data.frame(total_mean_df), fn)
rm(fn)
