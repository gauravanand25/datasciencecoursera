## X train and test data
x.train <- read.table("train/X_train.txt")
x.test <- read.table("test/X_test.txt")

## y train and test data
y.train <- read.table("train/y_train.txt")
y.test <- read.table("test/y_test.txt")

## subject train and test data
subject.train <- read.table("train/subject_train.txt")
subject.test <- read.table("test/subject_test.txt")
 
## merging test and train data
x <- rbind(x.train, x.test)
y <- rbind(y.train, y.test)
subject <- rbind(subject.train, subject.test)

## settings column names
colnames(x) <- read.table("features.txt")$V2
colnames(y) <- "ActivityID"
colnames(subject) <- "Subject"

## subsetting data based on column names
x.subset <- x[, colnames(data) %in% features[grep("mean|std", features)] ]

## replacing activity ID with activity names
activity.labels <- read.table("activity_labels.txt")$V2
y <- sapply(y, function(x) { activity.labels[x] })

## merging x, y, subject
data <- cbind(x.subset, y, subject)
