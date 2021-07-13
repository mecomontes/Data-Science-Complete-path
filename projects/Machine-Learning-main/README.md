# FINAL PROJECT: MACHINE LEARNING
=======================================

```
knitr::opts_chunk$set(echo = TRUE)
```

---
## LOADING LIBRARIES AND DATA

The necesary libraries are the next
```
library(lattice)
library(ggplot2)
library(caret)
library(gbm)
library(survival)
library(splines)
```

## 1) Download and read raw data

```
setwd("/home/andres/Desktop/CURSO DATA SCIENCE/MACHINE LEARNING")
url1 <- "http://d396qusza40orc.cloudfront.net/predmachlearn/pml-training.csv"
download.file(url1, destfile="pml-training.csv")
url2 <- "http://d396qusza40orc.cloudfront.net/predmachlearn/pml-testing.csv"
download.file(url2, destfile="pml-testing.csv")
Train <- read.csv("pml-training.csv", header=TRUE)
Test <- read.csv("pml-testing.csv", header=TRUE)
```

---
## DATA SUMMARY
## 2) Summary the dataset looking the possible distribution and more information about data

```
summary(Train$var_total_accel_belt)
```

We have a lot of NA's values and empty cells, let's fix it
```
Tidy <- Train[,-c(grep("^amplitude|^kurtosis|^skewness|^avg|^cvtd_timestamp|^max|^min|^new_window|^raw_timestamp|^stddev|^var|^user_name|X",names(Train)))]
```

Most of the variables are deleted

---
## DATA SPLITING
## 3) We are going to into 60% for training and the other 40% for testing the model

```
set.seed(39)
inTrain <- createDataPartition(y=Tidy$classe, p=0.6,list=FALSE)
TidyTrain <- Tidy[inTrain,]
TidyTest <- Tidy[-inTrain,]
```
---
## MODEL SELECTION
What is the better model for the prediction, let's see
```
set.seed(39)
fitControl <- trainControl(method = "cv", number = 10)
gbmFit <- train(classe~., data=TidyTrain, method="gbm", metric="Kappa", trControl=fitControl,verbose=FALSE)
```

```
rfFit <- train(classe~.,data=TidyTrain,method="rf", metric="Kappa", trControl=fitControl)
```
---
## MODEL SELECTION
Models are compared using resamples function from caret package. 
```
rValues <- resamples(list(rf=rfFit,gbm=gbmFit))
summary(rValues)
```
```
bwplot(rValues,metric="Kappa",main="RandomForest (rf) vs Gradient Boosting (gbm)")
```

As we see the random forest is the best model

---
## MODEL VALIDATION
```
rfFit
```
## MODEL TESTING
The predictions for the model are
```
predict(rfFit,newdata=Test)
```

---
## Author
====================
* [Robinson Montes](https:www.github.com/mecomontes) - Github
