# Eduardo Sant' Anna Martins

base.credit <- read.csv("credit-data.csv", header = T, sep = ",")

base.credit$clientid <- NULL

base.invalid <- base.credit[base.credit$age < 0 & !is.na(base.credit$age), ]

media <- mean(base.credit$age[base.credit$age > 0], na.rm = T)

base.credit <- base.credit[base.credit$age > 0 & !is.na(base.credit$age), ]

base.credit$age <- ifelse(base.credit$age < 0, media, base.credit$age)

print(summary(base.credit))



