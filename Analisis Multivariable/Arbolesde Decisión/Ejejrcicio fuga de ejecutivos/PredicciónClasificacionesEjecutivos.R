# Identificación de la ruta de trabajo

getwd()
setwd("D:/UdeM/Análisis Multivariante/Árboles")

###  Ejemplo con datos de Ejecutivos Comerciales

E<-read.csv("Ejecutivos_Fuga_SI_NO.csv",header=T, sep =",")

# resumen de datos
summary(E)

###### Ejemplos de Gráficos Descriptivos

# GrÁfico de Proporciones por Fuga

#cuenta de fugados y no fugados

t<-table(E$Fuga)
t

pct <- round(t/sum(t)*100)		# calculate percentages
lbls <- paste(names(t), pct, "%")	# add percents to labels
prop.table(t)
pie(table(E$Fuga), col = c("tomato1","steelblue"),labels=lbls, 
    main="Proporción de Ejecutivos según Fuga")


# Gráfico de barras según Sexo

ts<-table(E$Sexo)
barplot(ts, main="Ejecutivos según Sexo",
        xlab="Sexo", col=c("tomato1","steelblue","lightgreen"))

ts

EP <- round(prop.table(table((E$Sexo)))*100,1)
pct <- round(EP/sum(EP)*100)		# calculate percentages
lbls <- paste(names(EP), pct, "%")	# add percents to labels
graf <- barplot(EP, ylab="Frecuencia relativa %",col=rainbow(20), ylim=c(0,46), main= "Proporción de Ejecutivos según Sexo")
text(graf, EP-2,format(EP), cex=0.9)

# explorar colores
colors()

# Gráficos de Cumplimientos Promedio (para los dos negocios)

hist(E$CumpliProm, col = "royalblue3",
     main = "Cumplimientos Promedio",
     xlab="Cumplimiento",ylab="Frecuencia")


# Gráficos de Cumplimientos Promedio (por cada negocio)

# instrucción para sacar 2 grÁficos en la misma ventana
par(mfrow=c(1,2))

# Histogramas de Cumplimientos

hist(E$CumpliProm[E$Fuga=='NO'],main = "NO FUGA", 
     xlab = "Cumplimiento", 
     ylab = "Frecuencia", col = "lightskyblue4")

hist(E$CumpliProm[E$Fuga=='SI'],main = "SI FUGA",
     xlab = "Cumplimiento", ylab = "Frecuencia",
     col = "tomato1")

# Boxplot de Cumplimientos

boxplot(E$CumpliProm[E$Fuga=='NO'],main = "NO FUGA",
     xlab = "Cumplimiento", ylab = "Frecuencia",
     col = "lightskyblue4",ylim = c(0, 3.5))

boxplot(E$CumpliProm[E$Fuga=='SI'],main = "SI FUGA",
     xlab = "Cumplimiento", ylab = "Frecuencia",
     col = "tomato1",ylim = c(0, 3.5))


par(mfrow=c(1,1))

hist(E$Edad, col = "royalblue3",
     main = "Edad",
     xlab="Edad",ylab="Frecuencia")

#Gráficos por Edad

par(mfrow=c(1,2))

hist(E$Edad[E$Fuga=='NO'],main = "NO FUGA", 
     xlab = "Edad", 
     ylab = "Frecuencia", col = "lightskyblue4")

hist(E$Edad[E$Fuga=='SI'],main = "SI FUGA",
     xlab = "Edad", ylab = "Frecuencia",
     col = "tomato1")



# Ejercicio1: Graficar las Edades de los Ejecutivos
# Ejercicio2: Graficar los salarios totales promedio por negocios
# Ejercicio3: Graficar las proporciones de salarios fijos
# Ejercicio4: Graficar las proporciones de ejecutivos fugados del jefe
# Ejercicio5: Graficar las proporciones de meses que no se cumplen las metas comerciales
# Ejercicio6: Graficar las proporciones de meses por debajo del propio cumplimiento promedio


##############   Árbol de Desición General ##################

# Instalación de Librerías

#install.packages("rpart")
#install.packages("rpart.plot")
#install.packages("rattle")

# Llamar las librerías (siempre que se usen las funciones)

library(rpart) # Librería para obtener Árboles de decisión
library(rpart.plot) # Librería para graficar Árboles de decisión
library(rattle) # Librería para graficar Árboles de decisión


# Subconjunto de Datos para Modelar
#Nunca se modela con los ID de las personas!

ModeloTree<- data.frame(E[3:28])
summary(ModeloTree)


#instrucción para obtener el árbol:
tree<- rpart(Fuga ~ ., data = ModeloTree)

# volver a un gráfico en toda la ventana
par(mfrow=c(1,1))

# GrÁficos del Árbol

rpart.plot(tree)
fancyRpartPlot(tree)

# Árbol sin Sexo ni Edad

ModeloTreeSE<- data.frame(E[4:5],E[7:28])
tree<- rpart(Fuga ~ ., data = ModeloTreeSE)

fancyRpartPlot(tree,cex=0.7)

########## Predicción de fuga sobre los Ejecutivos Activos   ##########

A <- E[ which(E$Fuga=='NO' ), ]

ModeloTreeA<- data.frame(A[5],A[7:28])

pred.tree <- predict(tree, newdata = ModeloTreeA)

A$Prediccion<-pred.tree[,2]

hist(A$Prediccion, col = "red2",
     main = "Predicciones de Fuga entre Ejecutivos Activos",
     xlab="Probabilidad",ylab="Frecuencia")


########### Ejercicio 2 #####

### Escoger una de las siguientes Bases para Analizar:

# 1. La fuga voluntaria e Involuntaria 
# 2. La fuga Temprana y la Tardía


# resumen de datos

library(factoextra)
library(FactoMineR)


E_Num<- data.frame(E[7:28])
E_Num<- na.omit(E_Num)
cor<-cor(E_Num)
corrplot(cor, tl.col = "gray2",tl.cex=0.7)

E1<- data.frame(E[3:4],E[7:28])
E1<- na.omit(E1)
PCAE<- PCA(E1, graph = T,quali.sup = 1:2)
fviz_screeplot(PCAE,ncp=10)
corrplot(corr = t(PCAE$var$coord))

plot(PCAE,choix="ind",habillage=1,label=c("none"))
plot(PCAE,choix="ind",habillage=2,label=c("none"))

# "BIPLOT" en Plano 1-2

fviz_pca_biplot(PCAE, geom = c("point", "text"),label="var",col.ind="lightblue",col.var="blue") 
fviz_pca_biplot(PCAE, geom = c("point", "text"),label="var",col.ind="lightblue",col.var="darkblue",habillage=2,title="BIPLOT (Plano 1-2) según Fuga") 
fviz_pca_biplot(PCAE, geom = c("point", "text"),label="var",col.ind="lightblue",col.var="darkblue",habillage=1,title="BIPLOT (Plano 1-2) según Sexos") 


