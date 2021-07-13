#install.packages("FactoMineR")

library(FactoMineR)
library(factoextra)
library(ggplot2)
library(corrplot)
library(rpart) 
library(rpart.plot) 
library(rattle)

### Ejercicio de Segmentación NoEstadística

EDS<-read.csv("SegmentaciónNoEstadística.csv",header=T, sep =";")
EDS1<-data.frame(EDS[3:5])

# Clusters aplicando la mejor técnica jerárquica

Clust_J <- HCPC(EDS1,nb.clust = -1,graph = T)
EDS$Clust_J<-Clust_J$data.clust$clust
table(EDS$Clust_J)
barplot(table(EDS$Clust_J),main="Clusters por el mejor Método Jerárquico",xlab="Cluster", ylab="# de Clientes",col = rainbow(6))

# Componentes Principales de los Datos de EDS

PCA_EDS<- PCA(EDS1, graph = F, ncp = 5)

# Compración de Biplots de Clusters y de Segmentos No Estadísiticos

fviz_pca_biplot(PCA_EDS,label="var",habillage=EDS$Clust_J,title="BIPLOT con Clusters") 
fviz_pca_biplot(PCA_EDS,label="var",habillage=EDS$Segmento,title="BIPLOT con SegmentosNoEstadísticos") 

