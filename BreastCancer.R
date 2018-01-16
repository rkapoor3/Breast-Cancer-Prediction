# Variable :: Class: 2 for benign, 4 for malignant # To be predicted

# libraries
install.packages("pastecs")
install.packages("ggplot2")
install.packages("mice")
install.packages("vcd")

library(pastecs)
library(ggplot2)
library(mice)
library(vcd)

# Data Import
data <- read.csv("breast-cancer-wisconsin.csv", header = FALSE)

# Renaming the columns
colnames(data) <- c("Sample_code_number", "Clump_Thickness", "Uniformity_of_Cell_Size", 
                    "Uniformity_of_Cell_Shape", "Marginal_Adhesion", "Single_Epithelial_Cell_Size", 
                    "Bare_Nuclei", "Bland_Chromatin", "Normal_Nucleoli", "Mitoses", "Class")


names(data)

# Creating the Train and Test Dataset
train <- data[0:550,]
test  <- data[550:699,]

# First record of Train and Test Dataset
head(train, 1)
head(test, 1)

# Removing the Class column from Test
test <- test[,-11]

# Data Description
str(data)
describe(data)
stat.desc(data)

data$Class <- as.factor(data$Class)
levels(data$Class) <- c("Benign", "Malignant")

# Conversion from Factor to Numeric
data[7] <- as.numeric(unlist(data[7]))

cor(data[,2:6], method="spearman")

# Exploring the data using ggplot (find the relations between variables)

#Clump Thickness
ggplot(data, aes(x = data$Class, y = data[2], col = data$Class)) + 
  geom_jitter()

# Uniformity of Cell Size
ggplot(data, aes(x = data$Class, y = data[3], col = data$Class)) + 
  geom_smooth(se = FALSE) + geom_jitter()

# Cell Shape
ggplot(data, aes(x = data$Class, y = data[4], col = data$Class)) + 
  geom_jitter()

# Marginal Adhesion
ggplot(data, aes(x = data$Class, y = data[5], col = data$Class)) +
  geom_jitter(alpha = 0.7) + facet_grid(. ~ data$Class)

# Epithelial Cell Size
ggplot(data, aes(x = data$Class, y = data[6], col = data$Class)) +
  geom_smooth(se= FALSE, method = "lm") + geom_jitter()

ggplot(data, aes(x = data[3], y = data[4], col = data$Class)) +
  geom_jitter() + geom_smooth(method = "lm", se = FALSE) +
  geom_smooth(aes(group = 1), method = "lm", se = FALSE, linetype = 2)

# Bare Nuclei
ggplot(data, aes(x = data$Class, y = data[7], col = data$Class)) +
  geom_smooth(se= FALSE, method = "lm") + geom_jitter()

# Histogram for Bare Nuclei
ggplot(data, aes(x = data[7])) +
  geom_histogram(binwidth = 0.5)

#Bland Chromatin
ggplot(data, aes(x = data[8], y = data$Class, col= data$Class)) +
  geom_jitter(shape = 17, alpha = 0.8, size = 2)


# Normal Nucleoli
ggplot(data, aes(y = data[9], x = data$Class, col= data$Class)) +
  geom_jitter(shape = 17, alpha = 0.7, size = 2)

# Mitoses
ggplot(data, aes(y = data[10], x = data$Class, col= data$Class)) +
  geom_jitter(shape = 3, alpha = 0.7)

# Bare Nuclei and Normal Nucleoli
ggplot(data, aes(y = data[7], x = data[9], col= data$Class)) +
  geom_jitter(shape = 4, alpha = 0.6) + facet_grid(. ~ data$Class)


# Missing Values
sum(is.na(data)) # No missing values

# Packages for the prediction model
install.packages("mlbench")
install.packages("caret")
install.packages('e1071', dependencies=TRUE)
install.packages("heuristica")

library(mlbench)
library(caret)
library(e1071)
library(heuristica)

# Ensure results are repeatable
set.seed(7)

# Prepare training scheme
control <- trainControl(method = "repeatedcv", number = 10, repeats = 3)

# Train the model using Linear Vector Quantization Model
model <- train(Class ~ . , data = data, method = "lvq", preProcess = "scale", trControl = control)

# Estimate variable importance
importance <- varImp(model, scale = FALSE)

print(importance)
plot(importance)

# Total 2 and 4:
# Benign - 458 and Malignant - 241
mytable <- xtabs(~ Class, data = data)
mytable

# What is Random Forest (RF) and why use it ?
# RF is a learning based classification and regression technique. Most common
# predictive modelling and ML technique.
# 1. Reduces chances of overfitting
# 2. Higher model performance or accuracy

install.packages("randomForest")
library(randomForest)

set.seed(1)

# Creating a formula and removing data$Class
varnames <- names(data)
varnames <- varnames[!varnames %in% c("Class")]

# Adding a plus sign with exploratory variables
varnames <- paste(varnames, collapse = "+")

rf.form <- as.formula(paste("Class", varnames1, sep = " ~ " ))

# Building the Model
rf.model <- randomForest(rf.form, train, ntree = 200, importance = T, method = "class")

plot(rf.model)

# Variable Importance Plot
varImpPlot(rf.model, sort = T, main = "Var Importance", n.var = 5)

# Predicting the Var
test$predicted <- predict(rf.model, test, type = "Class")

# Confusion Matrix
# Method 1:
conf <- table(test$predicted, test$Class)
#acc <- sum(diag(conf)/sum(conf))

statsFromConfusionMatrix(conf)

# Method 2:
# Predicted Values
confusionMatrix(data = test$predicted, 
                reference = test$Class)

# Correct Values
mytable <- xtabs(~ test$Class, data = test)


