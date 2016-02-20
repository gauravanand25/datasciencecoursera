## X train and test data
x.train <- read.table("UCI HAR Dataset/train/X_train.txt")
x.test <- read.table("UCI HAR Dataset/test/X_test.txt")

## y train and test data
y.train <- read.table("UCI HAR Dataset/train/y_train.txt")
y.test <- read.table("UCI HAR Dataset/test/y_test.txt")

## subject train and test data
subject.train <- read.table("UCI HAR Dataset/train/subject_train.txt")
subject.test <- read.table("UCI HAR Dataset/test/subject_test.txt")

##
features <- read.table("UCI HAR Dataset/features.txt")$V2

## merging test and train data
x <- rbind(x.train, x.test)
y <- rbind(y.train, y.test)
subject <- rbind(subject.train, subject.test)


## settings column names
colnames(x) <- features 
colnames(y) <- "ActivityID"
colnames(subject) <- "Subject"

## subsetting data based on column names
x.subset <- x[, colnames(x) %in% features[grep("mean|std", features)] ]

## replacing activity ID with activity names
activity.labels <- read.table("UCI HAR Dataset/activity_labels.txt")$V2
y <- sapply(y, function(x) { activity.labels[x] })

## improving column names
colnames(x.subset) <- gsub("\\(\\)", "", colnames(x.subset))
colnames(x.subset) <- gsub("-", "", colnames(x.subset))

## merging x, y, subject
data <- cbind(x.subset, y, subject)

## tidy dataset
melt.data <- melt(data, id=c("ActivityID", "Subject"), measure.var=colnames(x.subset))
tidy.data <- dcast(melt.data, Subject+ActivityID ~ variable, mean)
write.table(tidy.data, "tidy_data.txt", row.names=F)
