# Load and merge two data (test and train data)
testdata <- read.table("C:/Users/kimmi/Desktop/UCI HAR Dataset/test/X_test.txt", header = F)
traindata <- read.table("C:/Users/kimmi/Desktop/UCI HAR Dataset/train/X_train.txt", header = F)
bigdata <- rbind(testdata, traindata)

# Add column's name, select columns have "mean" and "std"
feature <- read.table("C:/Users/kimmi/Desktop/UCI HAR Dataset/features.txt")
newfeature <- as.data.frame(t(feature))
names = newfeature[2,]
colnames(bigdata) = names
colmean <- grep("mean()", colnames(bigdata))
meandata <- bigdata[, c(colmean)]
colstd <- grep("std()", colnames(bigdata))
stddata <- bigdata[, c(colstd)]
mean_stddata1 <- cbind(meandata, stddata)

# Add subject column
sub_test <- read.table("C:/Users/kimmi/Desktop/UCI HAR Dataset/test/subject_test.txt")
sub_train <- read.table("C:/Users/kimmi/Desktop/UCI HAR Dataset/train/subject_train.txt")
subject <- rbind(sub_test, sub_train)
mean_stddata2 <- cbind(subject, mean_stddata1)

# Match activity labels
Y_test <- read.table("C:/Users/kimmi/Desktop/UCI HAR Dataset/test/y_test.txt")
data1 <- replace(Y_test, Y_test == 1, "WALKING")
data2 <- replace(data1, data1 == 2, "WALKING_UPSTAIRS")
data3 <- replace(data2, data2 == 3, "WALKING_DOWNSTAIRS")
data4 <- replace(data3, data3 == 4, "SITTING")
data5 <- replace(data4, data4 == 5, "STANDING")
Y_testactlabels <- replace(data5, data5 == 6, "LAYING")
Y_train <- read.table("C:/Users/kimmi/Desktop/UCI HAR Dataset/train/y_train.txt")
data6 <- replace(Y_train, Y_train == 1, "WALKING")
data7 <- replace(data6, data6 == 2, "WALKING_UPSTAIRS")
data8 <- replace(data7, data7 == 3, "WALKING_DOWNSTAIRS")
data9 <- replace(data8, data8 == 4, "SITTING")
data10 <- replace(data9, data9 == 5, "STANDING")
Y_trainactlabels <- replace(data10, data10 == 6, "LAYING")
actlabels <- rbind(Y_testactlabels, Y_trainactlabels)
mean_stddata3 <- cbind(actlabels, mean_stddata2)

# Rename column 1 and 2
mean_stddata3<-rename(mean_stddata3, c('activities' = 'V1', 'subject' = 'V1'))
mean_stddata3<-rename(mean_stddata3, c('activities' = 'subject'))
mean_stddata3<-rename(mean_stddata3, c('subject' = 'V1'))

# Return tidy data with the average of each variable for each activity and each subject
Finaldata <- mean_stddata3 %>% group_by(activities, subject) %>% summarise_all(mean)
write.table(Finaldata, "C:/Users/kimmi/Desktop/GGetting-and-cleaning-data/")


