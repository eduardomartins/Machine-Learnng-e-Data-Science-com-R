# Eduardo Sant' Anna Martins

#install.packages("caTools")

library(caTools)

base.credit <- read.csv("credit-data.csv", header = T, sep = ",")

base.credit$clientid <- NULL

base.invalid <- base.credit[base.credit$age < 0 & !is.na(base.credit$age), ]

media <- mean(base.credit$age[base.credit$age > 0], na.rm = T)

#base.credit <- base.credit[base.credit$age > 0 & !is.na(base.credit$age), ]

base.credit$age <- ifelse(base.credit$age < 0 | is.na(base.credit$age), media, base.credit$age)

print(summary(base.credit))

base.credit[ ,1:3] <- scale(base.credit[ ,1:3])

# Encode da classe  

base.credit$default <- factor(base.credit$default, levels = c(0, 1))


set.seed(1)

divisao <- sample.split(base.credit$default, SplitRatio = 0.75)

base.credit.treinamento <- subset(base.credit, divisao == TRUE)
base.credit.teste <- subset(base.credit, divisao == F)

library(e1071)

classificador <- naiveBayes(x = base.credit.treinamento[-4], y = base.credit.treinamento$default)
print(classificador)

previsao <- predict(classificador, newdata = base.credit.teste)


matriz.confusao <- table(base.credit.teste[, 4], previsao) 

print(matriz.confusao)  

#install.packages("lattice")
#install.packages("ggplot2")
install.packages("caret")

library('caret')  

confusionMatrix(matriz.confusao)
