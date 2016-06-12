#The function:
#1.Merges the training and the test sets to create one data set.
#2.Extracts only the measurements on the mean and standard
#deviation for each measurement.
#3.Uses descriptive activity names to name the activities in the data set
#4.Appropriately labels the data set with descriptive variable names.
#5.From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.rary(dplyr)

#---1---
#read test, activity and subject datasets
#and combine data into 1 data set
x_test<-tbl_df(read.table("test/X_test.txt"))
y_test<-tbl_df(read.table("test/y_test.txt"))
subject_test<-tbl_df(read.table("test/subject_test.txt"))
testData<-bind_cols(subject_test,y_test,x_test)

#read train, activity and subject datasets
#and combine data into 1 data set
x_train<-tbl_df(read.table("train/X_train.txt"))
y_train<-tbl_df(read.table("train/y_train.txt"))
subject_train<-tbl_df(read.table("train/subject_train.txt"))
trainData<-bind_cols(subject_train,y_train,x_train)

#merge test and train datasets into one
completeData<-rbind(testData,trainData)

#---2---
#leave only those variables
#that measure mean and std
features<-read.table("features.txt")
col_names<-as.character(features[,2])
col_names<-c("subject","activity_code",col_names)
leaveColumns<-grepl("subject|activity_code|mean()|std()",col_names)
meanAndStd<-completeData[,leaveColumns]

#---3&4---
#replace activity codes with activity names and
#add descriptive variable names
col_names<-col_names[leaveColumns]
colnames(meanAndStd)<-col_names
activities<-read.table("activity_labels.txt")
colnames(activities)<-c("code","activity")
meanAndStd_wAct<-left_join(meanAndStd,activities,by=c("activity_code"="code"))
meanAndStd_wAct<-meanAndStd_wAct[,c(1,82,3:81)]
##write.csv(meanAndStd_wAct,file="meanAndStd_wAct.csv")

#---5---
#Ouput grouped data with calculated average for each variable for each
#activity and each subject
groupedData<-group_by(meanAndStd_wAct,activity,subject)
groupedData<-summarise_each(groupedData,funs(mean))
groupedData<-arrange(groupedData,activity,subject)
##write.csv(groupedData,file="groupedData.csv")
write.table(groupedData,file="groupedData.txt",row.name=FALSE)
