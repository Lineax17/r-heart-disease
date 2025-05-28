#######################################
# Read data & Set correct types
#######################################
set.seed(467)

data <- read.csv("./data/heart.csv", header = TRUE, sep = ",", fill = TRUE, stringsAsFactors = TRUE)
head(data)

# set nominal columns as factor
data$Sex <- as.factor(data$Sex)
data$ChestPainType <- as.factor(data$ChestPainType)
data$FastingBS <- as.factor(data$FastingBS)
data$RestingECG <- as.factor(data$RestingECG)
data$ExerciseAngina <- as.factor(data$ExerciseAngina)
data$ST_Slope <- as.factor(data$ST_Slope)
data$HeartDisease <- as.factor(data$HeartDisease) #target

# rename to valid variable names
data$HeartDisease <- factor(data$HeartDisease,
                            levels = c(0, 1),
                            labels = c("No", "Yes"))

# replace data$Cholesterol 0 with median
#cholesterol_median <- median(data$Cholesterol[data$Cholesterol > 0], na.rm = TRUE)
#data$Cholesterol[data$Cholesterol == 0] <- cholesterol_median

# remove data$Cholesterol completely
#data <- data[, !names(data) %in% "Cholesterol"]

# remove data$Cholesterol 0 rows
data <- data[data$Cholesterol > 0, ]

summary(data)

#######################################
# Visulization
#######################################

# visualize numeric data
par(mfrow = c(1, 2))
boxplot(data$Age, main = "Age")
boxplot(data$RestingBP, main = "RestingBP")

par(mfrow = c(1, 2))
boxplot(data$Cholesterol, main = "Cholesterol")
boxplot(data$MaxHR, main = "MaxHR")

boxplot(data$Age ~ data$HeartDisease, ylab = "Age", xlab = "Disease")
boxplot(data$RestingBP ~ data$HeartDisease, ylab = "RestingBP", xlab = "Disease")

boxplot(data$Cholesterol ~ data$HeartDisease, ylab = "Cholesterol", xlab = "Disease")
boxplot(data$MaxHR ~ data$HeartDisease, ylab = "MaxHR", xlab = "Disease")

boxplot(data$Oldpeak ~ data$HeartDisease, ylab = "Oldpeak", xlab = "Disease")

# visualize factorial data
tab <- table(data$Sex, data$HeartDisease)
prop <- prop.table(tab, margin = 1)
barplot(t(prop),
        beside = TRUE,
        legend.text = TRUE,
        args.legend = list(x = "topright"),
        main = "Disease by Gender",
        xlab = "Gender",
        ylab = "",
        ylim = c(0, 1),
        col = c("darkgreen", "red"))

tab <- table(data$ChestPainType, data$HeartDisease)
prop <- prop.table(tab, margin = 1)
barplot(t(prop),
        beside = TRUE,
        legend.text = TRUE,
        args.legend = list(x = "topright"),
        main = "Disease by ChestPainType",
        xlab = "ChestPainType",
        ylab = "",
        ylim = c(0, 1),
        col = c("darkgreen", "red"))

tab <- table(data$FastingBS, data$HeartDisease)
prop <- prop.table(tab, margin = 1)
barplot(t(prop),
        beside = TRUE,
        legend.text = TRUE,
        args.legend = list(x = "topright"),
        main = "Disease by FastingBS",
        xlab = "FastingBS",
        ylab = "",
        ylim = c(0, 1),
        col = c("darkgreen", "red"),
        names.arg = c("no", "yes"))

tab <- table(data$RestingECG, data$HeartDisease)
prop <- prop.table(tab, margin = 1)
barplot(t(prop),
        beside = TRUE,
        legend.text = TRUE,
        args.legend = list(x = "topright"),
        main = "Disease by RestingECG",
        xlab = "RestingECG",
        ylab = "",
        ylim = c(0, 1),
        col = c("darkgreen", "red"))

tab <- table(data$ExerciseAngina, data$HeartDisease)
prop <- prop.table(tab, margin = 1)
barplot(t(prop),
        beside = TRUE,
        legend.text = TRUE,
        args.legend = list(x = "topright"),
        main = "Disease by ExerciseAngina",
        xlab = "ExerciseAngina",
        ylab = "",
        ylim = c(0, 1),
        col = c("darkgreen", "red"))


tab <- table(data$ST_Slope, data$HeartDisease)
prop <- prop.table(tab, margin = 1)
barplot(t(prop),
        beside = TRUE,
        legend.text = TRUE,
        args.legend = list(x = "topright"),
        main = "Disease by ST_Slope",
        xlab = "ST_Slope",
        ylab = "",
        ylim = c(0, 1),
        col = c("darkgreen", "red"))

# remove data$Sex
data <- data[, !names(data) %in% "Sex"]
summary(data)

#######################################
# Split in training and test data
#######################################

library(caret)
set.seed(467)
trainIndex <- createDataPartition(data$HeartDisease, p = 0.7, list = FALSE)
trainData <- data[trainIndex,]
testData <- data[-trainIndex,]
table(trainData$HeartDisease)
table(testData$HeartDisease)

# Define cross-validation control
control <- trainControl(
  method = "cv",                # Cross-Validation
  number = 10,                  # 10 folds
  savePredictions = "all",
  classProbs = TRUE,            # Calculate class probabilities
  seeds = set.seed(467)
)

#######################################
# Logistic Regression
#######################################

log_reg_model <- train(
  HeartDisease ~ .,
  data = trainData,
  method = "glm",
  family = "binomial",
  trControl = control
)

# prediction and confusion matrix
log_reg_pred <- predict(log_reg_model, newdata = testData)
log_reg_cm <- confusionMatrix(log_reg_pred, testData$HeartDisease)
print(log_reg_cm)

#######################################
# Decision Tree
#######################################

library(rpart)
tree_model <- train(
  HeartDisease ~ .,
  data = trainData,
  method = "rpart",
  trControl = control
)

# prediction and confusion matrix
tree_pred <- predict(tree_model, newdata = testData)
tree_cm <- confusionMatrix(tree_pred, testData$HeartDisease)
print(tree_cm)

# visualization of decision tree
par(mfrow = c(1, 1))
library(rpart.plot)
rpart.plot(tree_model$finalModel, box.palette = "Blues", main = "Decision Tree for Heart Disease")

#######################################
# Random Forest
#######################################

library(randomForest)
rf_model <- train(
  HeartDisease ~ .,
  data = trainData,
  method = "rf",
  trControl = control,
  importance = TRUE
)

# prediction and confusion matrix
rf_pred <- predict(rf_model, newdata = testData)
rf_cm <- confusionMatrix(rf_pred, testData$HeartDisease)
print(rf_cm)

# variable importance visualization
varImpPlot(rf_model$finalModel,
           sort = TRUE,
           main = "Variable Importance RandomForest")