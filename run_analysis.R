#---------ASSUMPTIONS-------------------------------------------------
#--1. The code assumes that data is presented in the same folder
#structure as extrated from "getdata-projectfiles-UCI HAR Dataset.zip"
#archive (folder "UCI HAR Dataset")
#--2. The data ("UCI HAR Dataset") is in your working directory
#--3. User has uploaded "dplyr" package

#call dplyr package
library(dplyr)

#-----read TEST data sets--------
#read X_test.txt file - the data
x_test<-read.table("UCI HAR Dataset/test/X_test.txt")

#read y_test.txt file - the activity codes and rename the column
#to "activity"
y_test<-read.table("UCI HAR Dataset/test/y_test.txt")
colnames(y_test)<-"activity"

#read subject_test.txt file - subject information and rename the
#column to "subject"
subject_test<-read.table("UCI HAR Dataset/test/subject_test.txt")
names(subject_test)<-"subject"

#bring 3 data sets above into 1 data set
testData<-cbind(y_test,subject_test,x_test)


#-----read TRAIN data sets-----
#read X_train.txt file - the data
x_train<-read.table("UCI HAR Dataset/train/X_train.txt")

#read y_train.txt file - the activity codes and rename the column
#to "activity"
y_train<-read.table("UCI HAR Dataset/train/y_train.txt")
colnames(y_train)<-"activity"

#read subject_train.txt file - subject information and rename the
#column to "subject"
subject_train<-read.table("UCI HAR Dataset/train/subject_train.txt")
colnames(subject_train)<-"subject"

#bring 3 data sets above into 1 data set
trainData<-cbind(y_train,subject_train,x_train)

#-----merge TEST and TRAIN data sets into one-----
completeData<-rbind(testData,trainData)

#-----replace activity codes with activity names
#read the activity_labels.txt file
actLabels<-read.table("UCI HAR Dataset/activity_labels.txt")
#a function to lookup values from a table
vLookup<-function(lookupValue,lookupArray,returnColumn){
      for(i in 1:nrow(lookupArray)){
            if(lookupValue==lookupArray[i,1]){
                  return(as.character(lookupArray[i,returnColumn]))
            }
      }
}
#replace activity code into activity labels using defined vlookup function
for(i in 1:nrow(completeData)) {
      completeData[i,1]<-vLookup(completeData[i,1],actLabels,2)
}

#-----add descriptive variable names------------
#read the list of features from file "features.txt"
features<-read.table("UCI HAR Dataset/features.txt")
#update variable column names in complete data with feature names
colnames(completeData)[3:563]<-as.character(features[,2])

#-----leave only columns that measure mean and standard deviation--------
#get logical and numerical vectors of columns that contain mean() or std()
containsMean<-grepl("mean()",colnames(completeData[3:363]))
containsStDev<-grepl("std()",colnames(completeData[3:363]))
#construct one logical vector of columns to keep
containsEither<-as.logical(containsMean+containsStDev)
#construct numerical vector with column numbers to leave
keepColumns<-c()
for(i in 1:361) {
      if(containsEither[i]) keepColumns<-(c(keepColumns,i))    
}
#offset keepColumns by 2 - we are keeping first 2 columns (activity &
#subject) as they are in the data
keepColumns<-keepColumns+2
#create a new data set that contains only "keepColumns" and excludes the rest
meanAndStdData<-completeData[,c(1:2,keepColumns)]

#-----creates an independent tidy data set with the average of each variable
#-----for each activity and each subject------------------------------------
#group data by activity and subject
groupedData<-group_by(meanAndStdData,activity,subject)
#calculate means for each measurement column for groups
finalData<-summarise_each(groupedData,funs(mean))
#output the final data into working directory
write.table(finalData,file="FinalData.txt",row.name=FALSE)


