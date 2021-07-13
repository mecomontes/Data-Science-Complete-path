#install.packages("FactoClass")
#install.packages("gridExtra")
#install.packages("ggplot2")
#install.packages("rlang")

library(FactoMineR)
library(factoextra)
library(foreign)
library(ggplot2)
library(FactoClass)
library(gridExtra)
library(corrplot)


### Ejemplo con Datos de Marcas

M<-read.csv("EjmMarcas.csv",header=T, sep =";")
row.names(M)<-M$X
M1<-data.frame(M[2:9])

ACM_M<- CA(X = M1,graph = T)
summary(ACM_M)

cor<-corrplot(ACM_M$row$contrib,is.corr = F)

fviz_screeplot(ACM_M, addlabels = TRUE)
fviz_ca(ACM_M,repel = TRUE)


### Ejercicio de Análisis de Correspondencias Múltiples
# con Datos de Percepción Autos:

#	La base de datos  Autos.sav muestra los resultados de la percepción de 24 dueños
# de automóviles de algunas marcas de interés. Se evaluaron 9 atributos y se desea
# saber cuál es la marca que se asocia al mejor desempeño.  

Autos <- read.spss(file = "Autos_2.sav",to.data.frame = T)
names(Autos) <- tolower(names(Autos))
rownames(Autos) <- Autos$modelo
Autos$modelo <- NULL

ACM_Autos <- MCA(X = Autos,graph = T)

# Incercia en los primeros 10 factores

Tab4 <- data.frame(Inercia = ACM_Autos$eig[1:10], Factores = factor(1:10))
ggplot(Tab4, aes(x = Factores, y = Inercia)) + 
  geom_bar(stat = "identity", color = "black") +
  geom_text(aes(label=round(Inercia,2)), position=position_dodge(width=0.9), vjust=-0.25) + theme_bw()

# Coseno cuadrado de las categorías
corrplot(corr = t(ACM_Autos$var$cos2),is.corr = F)

# Plano Factorial

fviz_mca_biplot(X = ACM_Autos, repel= T,title = "Plano de Ejes 1-2") + 
  theme(plot.title = element_text(hjust = 0.2))

fviz_mca_biplot(X = ACM_Autos, repel= T,title = "Plano de Ejes 2-3",axes = c(2,3)) + 
  theme(plot.title = element_text(hjust = 0.4))

fviz_mca_biplot(X = ACM_Autos, label="var",repel= T,title = "Plano de Ejes 3-4",axes = c(3,4)) + 
  theme(plot.title = element_text(hjust = 0.4))

### Se observan las asociaciones de forma clara? 
# Qué hacer para mejorar la visualización?




