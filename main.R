
data <- read.csv("./data/heart.csv",header=TRUE,sep=",",fill=TRUE,stringsAsFactors=TRUE)
head(data)

data$Sex <- as.factor(data$Sex)
data$ChestPainType <- as.factor(data$ChestPainType)
data$FastingBS <- as.factor(data$FastingBS)
data$RestingECG <- as.factor(data$RestingECG)
data$ExerciseAngina <- as.factor(data$ExerciseAngina)
data$ST_Slope <- as.factor(data$ST_Slope)
data$HeartDisease <- as.factor(data$HeartDisease) #target

summary(data)

#Splitting data into test and train
library(caret)

set.seed(467)
trainIndex <- createDataPartition(data$HeartDisease, p = 0.8, list = FALSE)

trainData <- data[trainIndex, ]
testData <- data[-trainIndex, ]

table(trainData$HeartDisease)
table(testData$HeartDisease)




