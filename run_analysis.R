library(plyr)

# Download the dataset
if(!file.exists("./UCIHARDATASET")){dir.create("./UCIHARDATASET")}
fileurl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileurl, destfile = "./UCIHARDATASET/projectdataset.zip")

# Unzip the dataset
unzip(zipfile = "./UCIHARDATASET/projectdataset.zip", exdir = "./UCIHARDATASET")

# 1. Merge the training and test datasets #

      #Reading files: training datasets, test datasets, feature vectors and activity labels #
      
        x_train <- read.table("./UCIHARDATASET/UCI HAR Dataset/train/X_train.txt")
        y_train <- read.table("./UCIHARDATASET/UCI HAR Dataset/train/y_train.txt")
        subject_train <- read.table("./UCIHARDATASET/UCI HAR Dataset/train/subject_train.txt")
       
        x_test <- read.table("./UCIHARDATASET/UCI HAR Dataset/test/X_test.txt")
        y_test <- read.table("./UCIHARDATASET/UCI HAR Dataset/test/y_test.txt")
        subject_test <- read.table("./UCIHARDATASET/UCI HAR Dataset/test/subject_test.txt")
        
        features <- read.table("./UCIHARDATASET/UCI HAR Dataset/features.txt")
        
        activityLabels = read.table("./UCIHARDATASET/UCI HAR Dataset/activity_labels.txt")
        
      # Assigning variable names #
      
        colnames(x_train) <- features[,2]
        colnames(y_train) <- "activityID"
        colnames(subject_train) <- "subjectID"
        
        colnames(x_test) <- features[,2]
        colnames(y_test) <- "activityID"
        colnames(subject_test) <- "subjectID"
        
        colnames(activityLabels) <- c("activityID", "activityType")
        
      # Merging Datasets #
      
        alltrain <- cbind(y_train, subject_train, x_train)
        alltest <- cbind(y_test, subject_test, x_test)
        finaldataset <- rbind(alltrain, alltest)
        
# 2. Extracti
      
     #Reading columnnnames and creating new vector#
        colNames <- colnames(finaldataset)
        
        mean_and_std <- (grepl("activityID", colNames) |
                         grepl("subjectID", colNames) |
                         grepl("mean..", colNames) |
                         grepl("std...", colNames)
        )
        
      # Subsetting #
        setforMeanandStd <- finaldataset[ , mean_and_std == TRUE]
        
# 3. Using descriptive activity names #
        setWithActivityNames <- merge(setforMeanandStd, activityLabels,
                                      by = "activityID",
                                      all.x = TRUE)
        
# 4. Label the data set with descriptive variable names #
       
        alltrain <- cbind(y_train, subject_train, x_train)
        alltest <- cbind(y_test, subject_test, x_test)
        finaldataset <- rbind(alltrain, alltest)
         mean_and_std <- (grepl("activityID", colNames) |
                         grepl("subjectID", colNames) |
                         grepl("mean..", colNames) |
                         grepl("std...", colNames)
        )
        
      # Subsetting #
        setforMeanandStd <- finaldataset[ , mean_and_std == TRUE]
        
        
        
# 5. Creating independent tidy data set #
        
        # Making a second tidy data set#
        tidyset <- aggregate(. ~subjectID + activityID, setWithActivityNames, mean)
        tidyset <- tidyset[order(tidySet$subjectID, tidySet$activityID), ]
        
        # Writing second tidy data set into a txt file #
        write.table(tidyset, "tidyset.txt", row.names = FALSE)
        
        #Help for this assignment was taken from sources such as Github and RPub#
