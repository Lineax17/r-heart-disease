#######################################
# Read data & Set correct types
#######################################

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

#######################################
# Visulization
#######################################

# visualize numeric data
par(mfrow=c(1,2))
boxplot(data$Age, main = "Age")
boxplot(data$RestingBP, main = "RestingBP")

par(mfrow=c(1,2))
boxplot(data$Cholesterol, main = "Cholesterol")
boxplot(data$MaxHR, main = "MaxHR")

boxplot(data$Age ~ data$HeartDisease, ylab = "Age", xlab = "Disease")
boxplot(data$RestingBP ~ data$HeartDisease, ylab = "RestingBP", xlab = "Disease")

boxplot(data$Cholesterol ~ data$HeartDisease, ylab = "Cholesterol", xlab = "Disease")
boxplot(data$MaxHR ~ data$HeartDisease, ylab = "MaxHR", xlab = "Disease")

boxplot(data$Oldpeak ~ data$HeartDisease, ylab="Oldpeak", xlab = "Disease")

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
        ylim = c(0,1),
        col  = c("darkgreen", "red"))

tab <- table(data$ChestPainType, data$HeartDisease)
prop <- prop.table(tab, margin = 1)
barplot(t(prop),
        beside = TRUE,
        legend.text = TRUE,
        args.legend = list(x = "topright"),
        main = "Disease by ChestPainType",
        xlab = "ChestPainType",
        ylab = "",
        ylim = c(0,1),
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
        ylim = c(0,1),
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
        ylim = c(0,1),
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
        ylim = c(0,1),
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
        ylim = c(0,1),
        col = c("darkgreen", "red"))

#######################################
# Split in training and test data
#######################################

library(caret)
set.seed(467)
trainIndex <- createDataPartition(data$HeartDisease, p = 0.8, list = FALSE)
trainData <- data[trainIndex, ]
testData <- data[-trainIndex, ]
table(trainData$HeartDisease)
table(testData$HeartDisease)

#######################################
# Logistic Regression
#######################################

log_reg_model <- glm(HeartDisease ~ ., data = trainData, family = "binomial")
log_reg_prob <- predict(log_reg_model, newdata = testData, type="response")
log_reg_pred <- ifelse(log_reg_prob > 0.5, 1, 0)
# summary(log_reg_model)

actual <- as.numeric(as.character(testData$HeartDisease))
confusion <- table(Predicted = log_reg_pred, Actual = actual)
cat("Logistic Regression Confusion Matrix:\n")
print(confusion)

#######################################
# Decision Tree
#######################################

library(rpart)
tree_model <- rpart(HeartDisease ~ ., data = trainData, method = "class")
tree_pred <- predict(tree_model, newdata = testData, type = "class")
tree_probs <- predict(tree_model, newdata = testData, type = "prob")[,2]
# summary(tree_model)

actual <- as.numeric(as.character(testData$HeartDisease))
cat("Decision Tree Confusion Matrix:\n")
print(table(Predicted = tree_pred, Actual = actual))

#######################################
# Random Forest
#######################################