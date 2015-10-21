library(foreign)

in_data <- read.dta("data/cancer.dta")


library(haven)

in_data2 <- read_dta("data/cancer.dta")

## labels of columns
sapply(in_data2, attr, "label")

fit <- coxph(Surv(studytim, died) ~ age + drug, data = in_data2)

summary(fit)

library(broom)

tidy(fit, exp = TRUE)

plot(survfit(fit))
