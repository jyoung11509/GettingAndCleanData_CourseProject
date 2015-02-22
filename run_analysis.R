install.packages("dplyr")
library(dplyr)
activity_labels <- read.table("activity_labels.txt"); feature_labels <- read.table("features.txt")

##MAKE THE TEST DATA FRAME

setwd("test")
subjects_test <- read.table("subject_test.txt"); activity_test <-  read.table("y_test.txt"); feature_test <- read.table("X_test.txt")


colnames(feature_test) <- gsub("[(),-]","",feature_labels$V2)

subjects_test <- rename(subjects_test, Subject=V1); activity_test <- rename(activity_test, Activity=V1)

test_data <- cbind(subjects_test,activity_test,feature_test)

##MAKE THE TRAINING DATA FRAME

setwd("../train")

subjects_train <- read.table("subject_train.txt"); activity_train <- activity <- read.table("y_train.txt"); feature_train <- read.table("X_train.txt")

colnames(feature_train) <- gsub("[(),-]","",feature_labels$V2)

subjects_train <- rename(subjects_train, Subject=V1); activity_train <- rename(activity_train, Activity=V1)

training_data <- cbind(subjects_train,activity_train,feature_train)

merged_data <- rbind(test_data,training_data)

merged_data$Activity[merged_data$Activity == 1] <- "WALKING"; merged_data$Activity[merged_data$Activity == 2] <- "WALKING_UPSTAIRS"; merged_data$Activity[merged_data$Activity == 3] <- "WALKING_DOWNSTAIRS"; merged_data$Activity[merged_data$Activity == 4] <- "SITTING"; merged_data$Activity[merged_data$Activity == 5] <- "STANDING"; merged_data$Activity[merged_data$Activity == 6] <- "LAYING"

Subject <- merged_data[,grep('Subject',names(merged_data))]; Activity <- merged_data[,grep('Activity',names(merged_data))]; meandata <- merged_data[,grep('mean',names(merged_data))]; sddata <- merged_data[,grep('std',names(merged_data))]
merged_data <- cbind(Subject,Activity,meandata,sddata)

setwd("..")
write.table(merged_data,"merged_data.txt",row.names=F)
