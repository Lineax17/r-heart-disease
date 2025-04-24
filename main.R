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

# visualize data
plot()

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
summary(log_reg_model)

# accuracy and error rate for logistic regression
actual <- as.numeric(as.character(testData$HeartDisease))
accuracy <- mean(log_reg_pred == actual)
cat("Accuracy:", round(accuracy, 4), "\n")

confusion <- table(Predicted = log_reg_pred, Actual = actual)
print(confusion)

mae <- mean(abs(log_reg_prob - actual))
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