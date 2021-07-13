install.packages("rpart")
install.packages("rpart.plot")
install.packages("rattle")

library(rattle)
library(rpart)
library(rpart.plot)

getwd()
setwd("D:/UdeM/Análisis Multivariante/Árboles")


# Ejemplos con Datos de Redes Sociales

T2016<-read.csv("Tree2016.csv",header=T, sep =";",na.strings = c("NA"," ","","NULL","."))

summary(T2016)
names(T2016)

T2015<-read.csv("Tree2015.csv",header=T, sep =";",na.strings = c("NA"," ","","NULL","."))

summary(T2015)
names(T2015)


### Tree 2016

ModeloTree<- data.frame(T2016)

tree<- rpart(Brand_Asset_R ~ ., data = ModeloTree, minbucket=4)
rpart.plot(tree)

### Tree 2015

ModeloTree<- data.frame(T2015)

tree<- rpart(Brand_Asset_R ~ ., data = ModeloTree, minbucket=3)
rpart.plot(tree)

