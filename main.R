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

# splitting data into test and train
library(caret)
set.seed(467)
trainIndex <- createDataPartition(data$HeartDisease, p = 0.8, list = FALSE)
trainData <- data[trainIndex, ]
testData <- data[-trainIndex, ]
table(trainData$HeartDisease)
table(testData$HeartDisease)

# train logistic regression
logistic_regression_model <- glm(HeartDisease ~ ., data = trainData, family = "binomial")
logistic_regression_probabilities <- predict(logistic_regression_model, newdata = testData, type="response")
logistic_regression_prediction <- ifelse(logistic_regression_probabilities > 0.5, 1, 0)
summary(logistic_regression_model)

# accuracy and error rate for logistic regression
actual <- as.numeric(as.character(testData$HeartDisease))
accuracy <- mean(logistic_regression_prediction == actual)

cat("Accuracy:", round(accuracy, 4), "\n")
confusion <- table(Predicted = logistic_regression_prediction, Actual = actual)
print(confusion)

mae <- mean(abs(logistic_regression_probabilities - actual))
cat("Mean Absolute Error (MAE):", round(mae, 4), "\n")

# train decision tree
library(rpart)
tree_model <- rpart(HeartDisease ~ ., data = trainData, method = "class")
tree_pred <- predict(tree_model, newdata = testData, type = "class")
tree_probs <- predict(tree_model, newdata = testData, type = "prob")[,2]
summary(tree_model)

# accuracy and error rate of decision tree
actual <- as.numeric(as.character(testData$HeartDisease))

tree_acc <- mean(tree_pred == actual)
cat("Decision Tree Accuracy:", round(tree_acc, 4), "\n")

cat("Decision Tree Confusion Matrix:\n")
print(table(Predicted = tree_pred, Actual = actual))

tree_mae <- mean(abs(tree_probs - actual))
cat("Decision Tree MAE:", round(tree_mae, 4), "\n")