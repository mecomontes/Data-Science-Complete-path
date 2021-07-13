### C?digos para instalar librer?as

install.packages("readxl")
install.packages("foreign")
install.packages("Factoshiny")
install.packages("factoextra")
install.packages("corrplot")
install.packages("biplotbootGUI")
install.packages("dynBiplotGUI")
install.packages("psych")
install.packages("ggplot2")

# Siempre llamar las librer?as

library(readxl)
library(foreign)
library(Factoshiny)
library(factoextra)
library(corrplot)
library(biplotbootGUI)
library(dynBiplotGUI)
library(psych)
library(ggplot2)


getwd()
setwd("D:/UdeM/An?lisis Multivariante/Componentes Principales")

##### An?lisis de Componentes Principales

Dptos <- read.spss(file = "DeptosCol.sav",to.data.frame = T)
D<- Dptos[,-1]
dimnames(D)[[1]] <-Dptos[,1]


# Correlaciones entre variables

pairs.panels(D)
#pairs(D)
corPlot(D,cex=0.6)
correlaciones<-cor(D)
write.csv(correlaciones,file="correlaciones.csv")

corrplot.mixed(correlaciones)

# PCA con Shiny:
ACP_Deptos<-PCAshiny(D)

# PCA con Funciones de factoextra:

PCAD<- PCA(D, graph = F)
PCAD
PCAD$var$coord
PCAD$eig 
# Dos componentes son suficientes para graficar la informaci?n del PCA
fviz_screeplot(PCAD,ncp=8,addlabels =T,labelsize = 0.1)

### Correlaciones en relaci?n a las primeras componentes principales:
cat("Correlaciones al eje 1")
sort(PCAD$var$cor[,1])
cat("Correlaciones al eje 2")
sort(PCAD$var$cor[,2])
cat("Coordenadas de las variables")
corrplot(corr = t(PCAD$var$coord))

# Gr?ficos Bonitos :)

# Gr?fico de las variables cos2
fviz_pca_var(PCAD, col.var = "contrib", axes = c(1, 2)) +
  scale_color_gradient2(low = "white", mid = "blue", high = "red", midpoint = 0.20) 

# Gr?fico de los individuos cos2
fviz_pca_ind(PCAD, col.ind = "cos2", axes = c(1, 2)) +
  scale_color_gradient2(low = "white", mid = "blue", high = "red", midpoint = 0.30) 

# los dos gr?ficos juntos "BIPLOT"
fviz_pca_biplot(PCAD, geom = "text") 


##### Ejemplo con datos de Fuga de Ejecutivos Comerciales

E<-read.csv("Ejecutivos_Fuga_SI_NO.csv",header=T, sep =",")

# resumen de datos
summary(E)

E_Num<- data.frame(E[7:28])
E_Num<- na.omit(E_Num)
cor<-cor(E_Num)
corrplot(cor, tl.col = "gray2",tl.cex=0.7)

E1<- data.frame(E[3:4],E[7:28])
E1<- na.omit(E1)
PCAE<- PCA(E1, graph = T,quali.sup = 1:2)
fviz_screeplot(PCAE,ncp=10,addlabels =T,labelsize = 0.1)
corrplot(corr = t(PCAE$var$coord))

plot(PCAE,choix="ind",habillage=1,label=c("none"))
plot(PCAE,choix="ind",habillage=2,label=c("none"))

# "BIPLOT" en Plano 1-2

fviz_pca_biplot(PCAE, geom = c("point", "text"),label="var",col.ind="lightblue",col.var="blue") 
fviz_pca_biplot(PCAE, geom = c("point", "text"),label="var",col.ind="lightblue",col.var="darkblue",habillage=2,title="BIPLOT (Plano 1-2) seg?n Fuga") 
fviz_pca_biplot(PCAE, geom = c("point", "text"),label="var",col.ind="lightblue",col.var="darkblue",habillage=1,title="BIPLOT (Plano 1-2) seg?n Sexos") 
