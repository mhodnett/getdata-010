
#
# Course project for Getting and Cleaning Data course on coursera.ord
# Author: Mark Hodnett (https://github.com/mhodnett/)
# Date: 22/01/2015

# Instructions
#    Merges the training and the test sets to create one data set.
#    Extracts only the measurements on the mean and standard deviation for each measurement. 
#    Uses descriptive activity names to name the activities in the data set
#    Appropriately labels the data set with descriptive variable names. 
#    From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
#


setwd("C:\\mydata\\learning\\ds\\GettingandCleaningData\\proj")


# import data
dfIn_train<-read.table("UCI HAR Dataset\\train\\X_train.txt", header = FALSE)
dfIn_subtrain<-read.table("UCI HAR Dataset\\train\\subject_train.txt", header = FALSE)
dfIn_trainY<-read.table("UCI HAR Dataset\\train\\y_train.txt", header = FALSE)

dfIn_test<-read.table("UCI HAR Dataset\\test\\X_test.txt", header = FALSE)
dfIn_subtest<-read.table("UCI HAR Dataset\\test\\subject_test.txt", header = FALSE)
dfIn_testY<-read.table("UCI HAR Dataset\\test\\y_test.txt", header = FALSE)

dfIn_features<-read.table("UCI HAR Dataset\\features.txt", header = FALSE)
dfIn_labels<-read.table("UCI HAR Dataset\\activity_labels.txt", header = FALSE)

# rename column names
colnames(dfIn_labels)<-c("ActivityId","Activity")

# Features dataset has an extra column at the start, remove it
dfIn_features[,1]<-NULL
# fix Feature names data, remove / replace invalid characteres
# remove brackets and commas from column names
dfIn_features[,1]<-gsub("\\(","",dfIn_features[,1])
dfIn_features[,1]<-gsub("\\)","",dfIn_features[,1])
dfIn_features[,1]<-gsub(",","",dfIn_features[,1])
# replace - with _
dfIn_features[,1]<-gsub("-","_",dfIn_features[,1])

# set the column names of the train and test data
colnames(dfIn_train)<-as.vector(dfIn_features[,1])
colnames(dfIn_test)<-as.vector(dfIn_features[,1])
# set the column names of the subject and target data
colnames(dfIn_subtrain)<-"Subject"
colnames(dfIn_trainY)<-"ActivityId"
colnames(dfIn_subtest)<-"Subject"
colnames(dfIn_testY)<-"ActivityId"

# append subject and target data to test and train datasets
df_train<-cbind(dfIn_train,dfIn_subtrain,dfIn_trainY)
df_test<-cbind(dfIn_test,dfIn_subtest,dfIn_testY)

# create dataset by combining test and train datasets
df_ALL<-rbind(df_train,df_test)

rows<-grep("_std_|_mean_",colnames(df_ALL))
rows<-c(rows,grep("Subject|ActivityId",colnames(df_ALL)))
fin<-merge(df_ALL[,rows], dfIn_labels, by.x = "ActivityId", by.y = "ActivityId", sort = FALSE) 
head(fin)

head(df_ALL[,rows])

############################

dim(dfIn_features)
head(dfIn_features)

dim(df_train)
dim(df_test)
dim(df_ALL)
head(df_train)
head(df_test)



dim(df_train)
dim(dfIn_train)
dim(dfIn_subtrain)
dim(dfIn_trainY)

dim(dfIn_test)
dim(dfIn_subtest)
dim(dfIn_testY)

dim(dfIn_features)
head(dfIn_features)
