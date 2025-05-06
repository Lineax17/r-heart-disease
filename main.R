# read data
data <- read.csv("./data/heart.csv",header=TRUE,sep=",",fill=TRUE,stringsAsFactors=TRUE)
head(data)

# set nominal columns as factor
data$Sex <- as.factor(data$Sex)
data$ChestPainType <- as.factor(data$ChestPainType)
data$FastingBS <- as.factor(data$FastingBS)
data$RestingECG <- as.factor(data$RestingECG)
data$ExerciseAngina <- as.factor(data$ExerciseAngina)
data$ST_Slope <- as.factor(data$ST_Slope)
data$HeartDisease <- as.factor(data$HeartDisease) #target
summary(data)
plot(data)

# visualize numeric data
par(mfrow=c(1,2))
boxplot(data$Age, main = "Age")
boxplot(data$RestingBP, main = "RestingBP")

par(mfrow=c(1,2))
boxplot(data$Cholesterol, main = "Cholesterol")
boxplot(data$MaxHR, main = "MaxHR")

par(mfrow=c(1,2))
boxplot(data$Age ~ data$HeartDisease, ylab = "Age", xlab = "Disease")
boxplot(data$RestingBP ~ data$HeartDisease, ylab = "RestingBP", xlab = "Disease")

par(mfrow=c(1,2))
boxplot(data$Cholesterol ~ data$HeartDisease, ylab = "Cholesterol", xlab = "Disease")
boxplot(data$MaxHR ~ data$HeartDisease, ylab = "MaxHR", xlab = "Disease")

# splitting data into test and train
library(caret)
set.seed(467)
trainIndex <- createDataPartition(data$HeartDisease, p = 0.8, list = FALSE)
trainData <- data[trainIndex, ]
testData <- data[-trainIndex, ]
table(trainData$HeartDisease)
table(testData$HeartDisease)

# train logistic regression
log_reg_model <- glm(HeartDisease ~ ., data = trainData, family = "binomial")
log_reg_prob <- predict(log_reg_model, newdata = testData, type="response")
log_reg_pred <- ifelse(log_reg_prob > 0.5, 1, 0)
# summary(log_reg_model)

actual <- as.numeric(as.character(testData$HeartDisease))
confusion <- table(Predicted = log_reg_pred, Actual = actual)
cat("Logistic Regression Confusion Matrix:\n")
print(confusion)

# train decision tree
library(rpart)
tree_model <- rpart(HeartDisease ~ ., data = trainData, method = "class")
tree_pred <- predict(tree_model, newdata = testData, type = "class")
tree_probs <- predict(tree_model, newdata = testData, type = "prob")[,2]
# summary(tree_model)

actual <- as.numeric(as.character(testData$HeartDisease))
cat("Decision Tree Confusion Matrix:\n")
print(table(Predicted = tree_pred, Actual = actual))
