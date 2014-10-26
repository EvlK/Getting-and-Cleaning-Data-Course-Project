The data used for this exercise is “Human Activity Recognition Using Smartphones Dataset
Version 1.0” [1] and it was obtained from http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

Data set information:
The experiments have been carried out with a group of 30 volunteers within an age bracket
of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS,  WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The dataset includes the following files that were used in the Course Project:
- 'README.txt'
- 'features_info.txt': Shows information about the variables used on the feature vector.
- 'features.txt': List of all features.
- 'activity_labels.txt': Links the class labels with their activity name.
- 'train/X_train.txt': Training set.
- 'train/y_train.txt': Training labels.
- 'test/X_test.txt': Test set.
- 'test/y_test.txt': Test labels.

The following files are available for the train and test data. Their descriptions are equivalent. 
- 'train/subject_train.txt': Each row identifies the subject who performed the activity for each
window sample. Its range is from 1 to 30. 

The following steps were taken to derive the final data set:
1.	The training and the test were added activity code and subject.
2.	The training and test data sets were merged into one
3.	Activity codes were replaced by activity labels
4.	Feature columns were renamed to contain measurement names
5.	Only columns that contain measurements of mean and standard deviation left in the data set
6.	Data was grouped by activity and subject and final independent tidy data set created providing with the average of each variable for each activity and each subject.

The code to transform the data is provided in file run_analysis.R




========
[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity 
Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International
Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

This dataset is distributed AS-IS and no responsibility implied or explicit can be addressed to the
authors or their institutions for its use or misuse. Any commercial use is prohibited.

Jorge L. Reyes-Ortiz, Alessandro Ghio, Luca Oneto, Davide Anguita. November 2012.
