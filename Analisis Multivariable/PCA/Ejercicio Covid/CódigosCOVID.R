# install.packages("psych")

library(factoextra)
library(corrplot)
library(FactoMineR)
library(ggplot2)
library(psych)

data <- read.csv("datos.csv", header=TRUE, sep =";")
summary(data)

dimnames(data)[[1]] <- data[,1]

data_filtered <- data.frame(data[4:13])
correlations <- cor(data_filtered)
corrplot.mixed(correlations, number.cex=0.8, tl.cex=0.8, cl.cex=0.8, tl.col="gray2")

data_scaled <- data.frame(scale(data[4:13]))
data_scaled_filtered <- data.frame(data_scaled[1:7])

pca <- PCA(data_scaled_filtered, graph=FALSE)
fviz_screeplot(pca, labelsize=0.1, addlabels=TRUE, barfill="deepskyblue4")
fviz_pca_biplot(pca, axes=c(1, 2), repel=TRUE, geom=c("point", "text"), label="var", habillage=data$GLO, col.var="black", title=" IDH PreCovid19 - Norte y Sur Global") 
fviz_pca_biplot(pca, axes=c(1, 2), repel=TRUE, geom=c("point", "text"), label="var", habillage=data$RA, col.var="black", title="IDH PreCovid19") 

data_last <- data.frame(scale(c[11:13]))
pca <- PCA(data_last, graph=FALSE)
fviz_screeplot(pca,labelsize=0.1, addlabels=TRUE, barfill="deepskyblue4")
fviz_pca_biplot(pca, axes=c(1, 2), repel=TRUE, geom=c("point", "text"), label="var", habillage=data$GLO, col.var="black", title=" 31Dic/2020 - Norte y Sur Global") 
fviz_pca_biplot(pca, axes=c(1, 2), repel=TRUE, geom=c("point", "text"), label="var", habillage=data$RA, col.var="black", title="31Dic/2020") 

### An?lisis descriptivo comparativo entre regiones
#Ruta para dejar los pdf, archivos y definici?n de variable region

output.folder <- "/home/meco/Downloads/EDA and PCA/Analisis Multivariable/PCA/Ejercicio Covid"

region <- data$RA

##### Gr?ficos de densidad y boxplots para variables num?ricas

density_graph <- function(y, folder){
  pdf(paste0(folder, "GraficosDescriptivos.pdf"), height=5)
  for(i in names(y)) {
    name=i
        x = ggplot(y) + geom_density(aes(x = y[,i], fill = region), alpha = 0.2)+
      xlab(name) + ylab("Densidad")
    print(x)
    bp <- ggplot(data, aes(x=region, y[,i], fill=region)) + geom_boxplot()+ xlab(name)+ ylab("")
    bp + scale_fill_brewer(palette="RdBu") + theme_minimal()
    print(bp)
  }
  dev.off()
}

density_graph(c1, output.folder)


##### An?lisis comparativo por regiones
LA <- data.frame(c[which(data$RA=='Latinoamerica'), ])
AF <- data.frame(c[which(data$RA=='Africa'), ])
AO <- data.frame(c[which(data$RA=='Asia y Oceania'), ])
NG <- data.frame(c[which(data$RA=='Norte Global'), ])

##### Latinoam?rica

pca <- PCA(LA[4:10], graph=FALSE)

fviz_screeplot(pca, labelsize=0.1, addlabels=TRUE, barfill="deepskyblue4")
fviz_pca_biplot(pca, axes=c(1, 2), repel=TRUE, labelsize=3, geom=c("point", "text"), label="all", col.ind="blue", col.var="black", title="Latinoamerica - PreCovid19") 

pca_la <- PCA(LA[11:13], graph=FALSE)
fviz_screeplot(pca_la, labelsize=0.1, addlabels=TRUE, barfill="deepskyblue4")
fviz_pca_biplot(pca_la, axes = c(1, 2),repel= T,labelsize = 3,geom = c("point", "text"),label="all",col.ind="blue",col.var="black",title="Latinoamerica - Dic31-2020") 


##### Norte Global

pca<- PCA(NG[4:10], graph=FALSE)
fviz_screeplot(pca, labelsize=0.1, addlabels=TRUE, barfill="deepskyblue4")
fviz_pca_biplot(pca, axes=c(1, 2),repel=TRUE, labelsize=3, geom=c("point", "text"), label="all", col.ind="blue", col.var="black", title="Norte Global - Precovid19") 

pca_ng <- PCA(NG[11:13], graph=FALSE)
fviz_screeplot(pca_ng, labelsize=0.1, addlabels=TRUE, barfill="deepskyblue4")
fviz_pca_biplot(pca_ng, axes=c(1, 2), repe=TRUE, labelsize=3, geom=c("point", "text"), label="all", col.ind="blue", col.var="black", title="Norte Global - Dic31-2020") 


#### Africa
pca <- PCA(AF[4:10], graph=FALSE)
fviz_screeplot(pca, labelsize=0.1, addlabels=TRUE, barfill="deepskyblue4")
fviz_pca_biplot(pca, axes=c(1, 2), repel=TRUE, labelsize=3, geom=c("point", "text"), label="all", col.ind="blue", col.var="black", title="Africa - Precovid19") 

pca_af <- PCA(AF[11:13],graph=FALSE)
fviz_screeplot(pca_af, labelsize=0.1, addlabels=TRUE, barfill="deepskyblue4")
fviz_pca_biplot(pca_af, axes=c(1, 2), repel=TRUE, labelsize=3, geom=c("point", "text"), label="all", col.ind="blue", col.var="black", title="Africa - Dic31-2020") 

#### Asia y Ocean?a
pca <- PCA(AO[4:10], graph=FALSE)
fviz_screeplot(pca,labelsize=0.1, addlabels=TRUE, barfill="deepskyblue4")
fviz_pca_biplot(pca, axes=c(1, 2), repel=TRUE, labelsize=3, geom=c("point", "text"), label="all", col.ind="blue", col.var="black", title="Asia y Oceania - Precovid19") 

pca_ao <- PCA(AO[11:13], graph=FALSE)
fviz_screeplot(pca_ao,labelsize=0.1, addlabels=TRUE, barfill="deepskyblue4")
fviz_pca_biplot(pca_ao, axes=c(1, 2), repel=TRUE, labelsize=3, geom=c("point", "text"), label="all", col.ind="blue", col.var="black", title="Asia y Oceania - Dic31-2020") 
