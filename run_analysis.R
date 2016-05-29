###INSTRUCTIONS###
#You should create one R script called run_analysis.R that does the following.
# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names.
# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.


# Download and unzip data
if (!file.exists("UCI HAR Dataset")){
  fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip "
  download.file(fileURL, "data.zip", method="curl")
  unzip("data.zip") 
}

# Read features tables
features <- read.table("UCI HAR Dataset/features.txt", stringsAsFactors = FALSE)

# Training and test data
# Extracts only the measurements on the mean and standard deviation for each measurement.
meanandstd <- grep(".*mean.*|.*std.*", features[,2])

# Read training data
train_data <- read.table("UCI HAR Dataset/train/X_train.txt")
train_data<-train_data[,meanandstd]
train_data_y <- read.table("UCI HAR Dataset/train/y_train.txt")
train_data_sub <- read.table("UCI HAR Dataset/train/subject_train.txt")

# Read test data
test_data <- read.table("UCI HAR Dataset/test/X_test.txt")
test_data <-test_data [,meanandstd]
test_data_y <- read.table("UCI HAR Dataset/test/y_test.txt")
test_data_sub <- read.table("UCI HAR Dataset/test/subject_test.txt")

# Read activity labels 
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt", stringsAsFactors = FALSE)

# Labeling the data set with descriptive activity names
test_data_y[, 1] = activity_labels[test_data_y[, 1], 2]
train_data_y[, 1] = activity_labels[train_data_y[, 1], 2]

# Merging the training and the test sets to create one data set.
train <- cbind(train_data_sub, train_data_y, train_data)
test <- cbind(test_data_sub, test_data_y, test_data)
train_test <- rbind(train, test)

# Labeling the data set with descriptive variable names
meanandstd_names <- features[meanandstd,2]
meanandstd_names <- gsub('[-()]', '', meanandstd_names)
meanandstd_names <- gsub('mean', '-mean', meanandstd_names)
meanandstd_names <- gsub('std', '-std', meanandstd_names)

colnames(train_test) <- c("Subject", "Activity", meanandstd_names)

# Removing unnecessary data from the environment
rm (test_data, test_data_y, test_data_sub, train_data, train_data_y, train_data_sub)

# Creating a second, independent tidy data set with the average of each variable for each activity and each subject
calculations <- train_test[, 3:dim(train_test)[2]]
tidy_data <- aggregate(calculations, list(train_test$Subject, train_test$Activity), mean)
names(tidy_data)[1:2] <- c('subject', 'activity')
write.csv(tidy_data, "tidy_data.csv")
