#install.packages("FactoMineR")
#install.packages("ggplot2")

library(FactoMineR)
library(ggplot2)
library(factoextra)

### Ejercicio con datos de Segmentos México
setwd('/home/meco/Desktop/Analisis Multivariable/Cluster/Clientes Mexico')
cm<-read.csv("DatosMexico.csv",header=T, sep =",")
cm1<-data.frame(cm[2:10])

# Clusters por distintas t?cnicas jer?rquicas y no jer?rquicas

#Vecino Cercano

Cluster_Cer <- HCPC(cm1,nb.clust = -1,method = "single",graph = F)
plot.HCPC(x = Cluster_Cer,choice = "tree",main="Vecino Cercano")
cm$Clust_Cer<-Cluster_Cer$data.clust$clust
table(cm$Clust_Cer)
barplot(table(cm$Clust_Cer),main="Clusters por Vecino Cercano",xlab="Cluster", ylab="# de Clientes",col = rainbow(6))

#Vecino Lejano
Cluster_Lej <- HCPC(cm1,nb.clust = -1,method = "complete",graph = F)
plot.HCPC(x = Cluster_Lej,choice = "tree",main="Vecino Lejano")
cm$Clust_Lej<-Cluster_Lej$data.clust$clust
table(cm$Clust_Lej)
barplot(table(cm$Clust_Lej),main="Cluster por Vecino Lejano",xlab="Cluster", ylab="# de Clientes",col = rainbow(6))

#Cluster media de grupos
Cluster_Med <- HCPC(cm1,nb.clust = -1,method = "average",graph = F)
plot.HCPC(x = Cluster_Med,choice = "tree",main="Cluster Media de Grupos")
cm$Clust_Med<-Cluster_Med$data.clust$clust
table(cm$Clust_Med)
barplot(table(cm$Clust_Med),main="Cluster por Media de Grupos",xlab="Cluster", ylab="# de Clientes",col = rainbow(6))

#M?todo de Ward: Numérico
Cluster_Ward <- HCPC(cm1,nb.clust = -1,method = "ward",graph = F)
plot.HCPC(x = Cluster_Ward,choice = "tree",main="Método de Ward")
cm$Clust_Ward<-Cluster_Ward$data.clust$clust
table(cm$Clust_Ward)
barplot(table(cm$Clust_Ward),main="Cluster por Método de Ward",xlab="Cluster", ylab="# de Clientes",col = rainbow(6))

#Pidiendo 5 grupos con métodos jerárquicos
Cluster_5 <- HCPC(cm1,nb.clust = -1,min = 5,graph = T)
cm$Cluster_5<-Cluster_5$data.clust$clust
table(cm$Cluster_5)
barplot(table(cm$Cluster_5),main="5 grupos con el mejor m?todo jer?rquico",xlab="Cluster", ylab="# de Clientes",col = rainbow(6))


# k-means con 5 grupos
Clust_KMeans <- kmeans(cm1, centers = 5)
cm$Clust_KMeans<-Clust_KMeans$cluster
cm$Clust_KMeans<-as.factor(cm$Clust_KMeans)
table(cm$Clust_KMeans)
barplot(table(cm$Clust_KMeans),main="5 Clusters por k-means",xlab="Cluster", ylab="# de Clientes",col = rainbow(6))

### Exportar los datos para trabajarlos en Excel
write.csv(cm, file="clusters.csv")

#### ACP con los clusters

cm_pca<-data.frame(cm[11:16],cm[2:10])
summary(cm_pca)

PCACM<- PCA(cm_pca, graph = F, quali.sup = 1:6)

fviz_pca_biplot(PCACM,label="var",habillage=1,repel=T,col.var="gray2",title="BIPLOT con Clusters de Vecino Cercano") 
fviz_pca_biplot(PCACM,label="var",habillage=2,repel=T,col.var="gray2",title="BIPLOT con Clusters de Vecino Lejano") 
fviz_pca_biplot(PCACM,label="var",habillage=3,repel=T,col.var="gray2",title="BIPLOT con Clusters de Media de Grupos") 
fviz_pca_biplot(PCACM,label="var",habillage=4,repel=T,col.var="gray2",title="BIPLOT con Clusters con M?todo de Ward") 
fviz_pca_biplot(PCACM,label="var",habillage=5,repel=T,col.var="gray2",title="BIPLOT con Clusters Jer?rquicos 5 grupos") 
fviz_pca_biplot(PCACM,label="var",habillage=6,repel=T,col.var="gray2",title="BIPLOT con Clusters con K-means 5 grupos") 


#### ?rboles con los clusters

library(rpart)
library(rpart.plot)

#Arbol de Cluster cercano

tcm<-data.frame(cm[2:10],cm[11])
tree<- rpart(Clust_Cer~ ., data = tcm)
rpart.plot(tree,main="Arbol de Clust_Cer",cex=0.5)
