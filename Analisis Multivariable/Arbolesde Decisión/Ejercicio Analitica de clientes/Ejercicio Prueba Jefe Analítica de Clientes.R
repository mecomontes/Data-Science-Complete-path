# Instalación de paquetes

install.packages("caret")
install.packages("ROSE")
install.packages("e1071")
install.packages("car")
install.packages("rpart")
install.packages("rpart.plot")

# Llamada de paquetes 

library(caret)
library(ROSE)
library(e1071)
library(car)
library(rpart)
library(rpart.plot)

##### Gráficos Descriptivos #######################

#### Árbol para Ejercicio Prueba Jefe Analítica de Clientes

b<-read.csv("bank-full.csv",header=T, sep =";",na.strings = c("NA"," ","","NULL","."))
summary(b)

b$marital<-as.factor(b$marital)
b$education<-as.factor(b$education)
b$default<-as.factor(b$default)
b$housing<-as.factor(b$housing)
b$loan <-as.factor(b$loan)
b$contact<-as.factor(b$contact)
b$month<-as.factor(b$month)
b$poutcome<-as.factor(b$poutcome)
b$job<-as.factor(b$job)
b$y<-as.factor(b$y)


### Códigos para Análisis Descriptivo

par(mfrow=c(1,1))
hist(b$duration[b$y=="no"],col = "blue",breaks = 25,xlim = c(0, 2000),labels = TRUE,
     main= "Histograma de Duración para y=NO",xlab="Duración en segundos",ylab="Frecuencia")
hist(b$duration[b$y=="yes"],col = "red",breaks = 25,xlim = c(0, 2000),labels = TRUE,
     main= "Histograma de Duración para y=SI",xlab="Duración en segundos",ylab="Frecuencia")

hist(b$age[b$y=="no"],col = "green3",labels = TRUE,
     main= "Histograma de Edades para y=NO",xlab="Edad",ylab="Frecuencia")
hist(b$age[b$y=="yes"],col = "orange3",labels = TRUE,
     main= "Histograma de Edades para y=SI",xlab="Edad",ylab="Frecuencia")

hist(b$age[b$y=="no"],col = "green3",labels = TRUE,
     main= "Histograma de Edades para y=NO",xlab="Edad",ylab="Frecuencia")
hist(b$age[b$y=="yes"],col = "orange3",labels = TRUE,
     main= "Histograma de Edades para y=SI",xlab="Edad",ylab="Frecuencia")

hist(b$pdays[b$y=="no"],col = "azure2",labels = TRUE,breaks = 25,
     main= "Dias desde Ãºltimo contacto para y=NO",xlab="Dias que han transcurrido",ylab="Frecuencia")
hist(b$pdays[b$y=="yes"],col = "mediumpurple",labels = TRUE, breaks = 25,
     main= "Dias desde Ãºltimo contacto para y=SI",xlab="Dias que han transcurrido",ylab="Frecuencia")

# Tree para todos los datos

par(mfrow=c(1,1))
treet<- rpart(y~ ., data = b,cp=0.005)
treet
rpart.plot(treet)


############### Modelación ###########################################################

# Lectura de Datos Estandarizados para Proceso de Modelación

b<-read.csv("Estandar1.csv",header=T, sep =";",na.strings = c("NA"," ","","NULL","."))
summary(b)

# Obtención de Muestras para entrenamiento y prueba

## 10% de los registros para prueba
smp_size <- floor(0.7 * nrow(b))

## semilla para hacer el muestreo reproducible
set.seed(123)
train_ind <- sample(seq_len(nrow(b)), size = smp_size)

train <- b[train_ind, ]
test <- b[-train_ind, ]

# Chequeo de proporciones de variable respesta en base de entrenamiento y prueba 
# Deben quedar similares proporciones de Si y No en ambas bases

table(train$y)
table(test$y)

# Convertir SI y NO en 0 y 1

test$y1<- ifelse(test$y=="no",0,1)

############ MODELADO

# Modelado con Regresión Logística:

modelt1 <- glm(y ~.,family=binomial(link='logit'),data=trainUO)
summary(modelt1)

# Predicción con Regresión Logística

# Se crea una nueva base de prueba que no incluya el valor real
ModeloRL<- data.frame(test[1:16])

# Se obtiene la predicción y se llama el valor real para comparar

ModeloRL$Prediccion <- round(predict(modelt1,newdata=ModeloRL,type='response'),5)
summary(ModeloRL$Prediccion)
hist(ModeloRL$Prediccion,col="lightblue",main="Probabilidades de Compra con Regresión Logística",ylab="Frecuencia",xlab="Probabilidad de Compra")
ModeloRL$y<-test$y1

# Creación de Clase Predicha

ModeloRL$ClasePred <- ifelse(ModeloRL$Prediccion > 0.5,1,0)
summary(ModeloRL$ClasePred)
ModeloRL$ClasePred<-as.factor(ModeloRL$ClasePred)
table(ModeloRL$ClasePred)
ModeloRL$y<-as.factor(ModeloRL$y)
table(ModeloRL$y)

# Confiabilidad de las Predicciones

accuracy <- table(ModeloRL$ClasePred, ModeloRL$y)
sum(diag(accuracy))/sum(accuracy)

confusionMatrix(ModeloRL$ClasePred, ModeloRL$y)
roc.curve(ModeloRL$y,ModeloRL$ClasePred, 
          main="Curva ROC Regresión Logística")

### Tree - Modelación con Árboles de Desición/Regresión/Clasificación

tree<- rpart(y~ ., data = trainUO)
#rpart.plot(tree)

# Se crea una nueva base de prueba que no incluya el valor real
# Se obtiene la predicción y se llama el valor real para comparar

ModeloTree<- data.frame(test[1:16])
pred.tree <- predict(tree, newdata = ModeloTree)

# Traer a la base de ModeloTree la probabilidad predicha y el valor real
ModeloTree$pred<-pred.tree[,2]
ModeloTree$y<-test$y1

# Crear la categoría predicha

ModeloTree$ClasePred <- ifelse(ModeloTree$pred > 0.5,1,0)
summary(ModeloTree$ClasePred)
ModeloTree$ClasePred<-as.factor(ModeloTree$ClasePred)
table(ModeloTree$ClasePred)
table(ModeloTree$y)
ModeloTree$y<-as.factor(ModeloTree$y)

# Confiabilidad de las predicciones

accuracy <- table(ModeloTree$ClasePred, ModeloTree$y)
sum(diag(accuracy))/sum(accuracy)

confusionMatrix(ModeloTree$ClasePred,ModeloTree$y)
roc.curve(ModeloTree$y, ModeloTree$pred,main="Curva ROC Decision Tree")

write.csv(ModeloTree,file="predicciones.csv")

##########################################################

#Esenarios de análisis para balancear la muestra

# over
trainO <- ovun.sample(y~., data=train,
                      seed=1, method="over",N=71834)$data

# under
trainU <- ovun.sample(y~., data=train,
                      N=9544, 
                      seed=1, method="under")$data

# balanced data set with both over and under sampling
trainUO <- ovun.sample(y~., data=train,
                       N=nrow(train), p=0.5, 
                       seed=1, method="both")$data

##########################################################

##Árbol con datos balanceados

treet<- rpart(y~ ., data = trainUO,cp=0.008)
rpart.plot(treet,cex=0.6)

#############################################################

#install.packages("randomForest")
library(randomForest)

# Random Forest

# Para ejemplificar, se usa el balanceo trainRose1 donde se excluyen las variables
# default y loan

rf.model <- randomForest(y~ ., trainRose1,importance=TRUE)
print(rf.model)

plot(rf.model, main="Random Forest Model")
varImpPlot(rf.model, main="Variable Importance Plot")

# Predicción con Random Forest

ModeloRf<- data.frame(test[1:4],test[6:7],test[9:17])

rf.predict <- predict(rf.model, ModeloRf,"class")
ModeloRf$ClasePred<-rf.predict

ModeloRf$y<-test$y

confusionMatrix(rf.predict, ModeloRf$y)
roc.curve(ModeloRf$y,rf.predict,  
          main="Curva ROC RandomForest")

# Modelado con Support Vector Machine

svm_model <- svm(y ~ ., data=trainRose,kernel ="radial")
summary(svm_model)

ModeloSNV<- data.frame(test[1:16])

pred <- predict(svm_model, ModeloSNV)
ModeloSNV$y<-test$y
ModeloSNV$pred<-pred

confusionMatrix(ModeloSNV$pred,ModeloSNV$y)

roc.curve(ModeloSNV$y, ModeloSNV$pred,
          main="Curva ROC SVM")

#### El ejercicio concluye preguntando:
#### Es beneficioso balancear los datos antes de modelar?

