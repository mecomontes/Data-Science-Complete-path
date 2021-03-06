# Basic Inference
===================

```
knitr::opts_chunk$set(echo = TRUE)
```

---
## PART 2: BASIC INFERENTIAL DATA ANALYSIS

In this second part, we will analyze the ToothGrowth data. This data set has 60 observations on 3 variables; the first column is tooth length, the second is a factor (VC: ascorbic acid, a form of vitamin C and OJ: orange juice) and the last one is dose, that is the dose in milligrams/day received for each pig. The first step is to load the data and do some basic summary analysis

```
data_pig <- ToothGrowth
summary(data_pig)
```

Next, filter the data set by supp variable and them do the summary analysis for each factor

```
pigs_VC <- filter(data_pig, data_pig$supp == 'VC')
pigs_OJ <- filter(data_pig, data_pig$supp == 'OJ')
summary(pigs_VC)
```

```
summary(pigs_OJ)
```
It's look like the pigs with the orange juice (OJ) treatment has highest length in his toot, let's prove calculating an interval for each mean with a confidence of 90%

```
LS <- mean(pigs_VC[,1])-qt(0.025, length(pigs_VC[,1])-1)*sd(pigs_VC[,1])/(length(pigs_VC[,1])^0.5)
LI <- mean(pigs_VC[,1])+qt(0.025, length(pigs_VC[,1])-1)*sd(pigs_VC[,1])/(length(pigs_VC[,1])^0.5)
paste('(', round(LI, 4), ',', round(LS, 4), ')')
```
With a 95% of confidence, the conclusion is that the average length of the pigs' tooth is between 13.88 and 20.05.

```
LS <- mean(pigs_OJ[,1])-qt(0.025, length(pigs_OJ[,1])-1)*sd(pigs_OJ[,1])/(length(pigs_OJ[,1])^0.5)
LI <- mean(pigs_OJ[,1])+qt(0.025, length(pigs_OJ[,1])-1)*sd(pigs_OJ[,1])/(length(pigs_OJ[,1])^0.5)
paste('(', round(LI, 4), ',', round(LS, 4), ')')
```
With a 95% of confidence, the conclusion is that the average length of the pigs' tooth is between 18.20 and 20.13.

For the interval of difference of means, first let's calculate the standard deviation of the two samples (OJ, VC), to know if the samples have the sample variance

```
sd_VC <- sd(pigs_VC[,1])
sd_OJ <- sd(pigs_OJ[,1])
paste('Sd VC = ', sd(pigs_VC[,1]), ', ', 'Sd OJ = ', sd(pigs_OJ[,1]))
```
Both samples looks like have different standard deviation, we have to compute the freedom degrees with the next formula:

```
sd_VC <- sd(pigs_VC[,1])
sd_OJ <- sd(pigs_OJ[,1])
n_VC <- length(pigs_VC[,1])
n_OJ <- length(pigs_OJ[,1])
v <- (sd_VC/n_VC+sd_OJ/n_OJ)^2/((sd_VC/n_VC)^2/(n_VC-1)+(sd_OJ/n_OJ)^2/(n_OJ-1))
round(v, 0)

```
Continue with the confidence interval of the difference of means

```
LS <- mean(pigs_OJ[,1])-mean(pigs_VC[,1])-qt(0.025,v)*(sd_OJ/n_OJ+sd_VC/n_VC)^0.5
LI <- mean(pigs_OJ[,1])-mean(pigs_VC[,1])+qt(0.025,v)*(sd_OJ/n_OJ+sd_VC/n_VC)^0.5
paste('(', round(LI, 4), ',', round(LS, 4), ')')
```

As we see the values of the interval has the same sings, now we can conclude, with a confidence of 95% that there is difference in the length of pigs' tooth mean.

---

## Author
====================
* [Robinson Montes](https:www.github.com/mecomontes) - Github
