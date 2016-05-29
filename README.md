Getting and Cleaning Data Course Project
==========================================================================

# run_analysis.R script description
This is a project for the Getting and Cleaning Data Coursera course.
The R script, `run_analysis.R`, does the following steps:

1. Download the dataset if it does not already exist in the working directory 
2. Read features tables
3. Extracts only the measurements on the mean and standard deviation for each measurement.
4. Read training and test data
5. Read activity labels 
6. Labels the data set with descriptive activity names
7. Merges the training and the test sets to create one data set.
8. Labels the data set with descriptive variable names
9. Removes unnecessary data from the environment
10. Creates a second, independent tidy data set with the average of each variable for each activity and each subject

The outpu of the script is saved as a file`tidy_data.csv` within a working  directory.

## How to run the analysis?

In your R enviroment (in the same folder where the data files are), load the script:

```
source('run_analysis.R')
```