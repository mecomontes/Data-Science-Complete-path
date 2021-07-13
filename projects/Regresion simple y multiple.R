setwd('/home/andres/Downloads')  # Definir donde trabajar
publicidad <- read.csv('ventas.csv')  # Leer datos

# INTERVALOS DE CONFIANZA E HIPOTESIS
install.packages('BSDA')
library('BSDA')
media <- mean(publicidad$sales)
desviacion <- sd(publicidad$sales)
z <- qnorm(1-0.05/2)
n <- length(publicidad$sales)

li <- media - z*desviacion/sqrt(n)
ls <- media + z*desviacion/sqrt(n)

zsum.test(mean.x = media, sigma.x = desviacion, n.x = n, alternative = 'greater', mu = 43)

# GRAFICO DE DISPERSION Y CORRELACION
plot(y=publicidad$sales, x=publicidad$youtube)
cor(y=publicidad$sales, x=publicidad$youtube)

plot(y=publicidad$sales, x=publicidad$facebook)
cor(y=publicidad$sales, x=publicidad$facebook)

plot(y=publicidad$sales, x=publicidad$newspaper)
cor(y=publicidad$sales, x=publicidad$newspaper)

# MODELO DE REGRESION LINEAL
# Sales : Dependiente, Facebook : Independiente

# lm(dependiente ~ independiente, datos)
regresion <- lm(sales ~ youtube, publicidad)

# El summary me entrega el resumen de la regresion sin ANOVA
summary(regresion)

# GRAFICO SUPUESTOS DE REGRESION
plot(regresion,1)
plot(regresion,3)
plot(regresion,2)

# PREDICCION INTERVALO PARA EL VALOR ESPERADO
nuevo = data.frame(youtube=170)
predict(regresion, newdata = nuevo, interval = 'confidence')

# PREDICCION INTERVALO PARA EL VALOR PUNTUAL
predict(regresion, newdata = nuevo, interval = 'predict')

# REGRESION MULTIPLE TODAS LAS VARIABLES DEL MODELO
regresion_multiple <- lm(sales ~ ., publicidad)
summary(regresion_multiple)

# REGRESION MULTIPLE CON VARIABLES DESEADAS
regresion_multiple9 <- lm(sales ~ facebook+youtube, publicidad)
summary(regresion_multiple9)

# PREDICCION INTERVALO PARA EL VALOR ESPERADO
nuevo1 = data.frame(youtube=170, facebook=30)
predict(regresion_multiple9, newdata = nuevo1, interval = 'confidence')

# PREDICCION INTERVALO PARA EL VALOR PUNTUAL
predict(regresion_multiple9, newdata = nuevo1, interval = 'predict')
