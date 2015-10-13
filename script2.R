library(stringr)
library(dplyr) 
x <- 1:10
x 
plot(x)

b <- readLines("http://capa.ddb.umu.se/cedaR/Data/BE0101D9.csv")

a <- read.table("http://capa.ddb.umu.se/cedaR/Data/BE0101D9.csv", skip = 2, header = TRUE, sep = ";", stringsAsFactors = FALSE, fileEncoding = "latin1")

a <- tbl_df(a)

a$region <- NULL

names(a) <- c("age", "sex", "deaths")

tail(a)



a = a %>% mutate(
  age = str_extract(age, "[0-9]{1,3}") %>% as.numeric(),
  sex = factor(sex, labels = c("women", "men"))
) 


ggplot(a, aes(age, deaths, color = sex))+ geom_step() + theme_bw() + labs(title = "Sweden 2014", x = "Age", y = "Deaths")

library(ggplot2)
library(broom)

X <- rnorm(10, mean = 5, sd = 10)
Y <- X + rnorm(10, mean = 6, sd = 0.2)
group = rep(c("a", "b"), each = 10, len = 20)

qplot(c(1:20), c(X,Y), color = group) + theme_bw()

t.test(X, Y)

# Para ihop datat

id = rep(c(1:10),2)

qplot(c(1:20), c(X,Y), group = id) + 
  geom_point(aes(color = group)) + 
  geom_line() + 
  geom_vline(aes(xintercept = 10.5)) + 
  theme_bw()

# i all par har grupp "b" högre värde -> alltås grupp tillhörighet har en signifikant påverkan på värdet

t.test(X, Y, paired = TRUE)

# Linear regression

dat <- data.frame(
  Y = c(X,Y),
  id = id,
  group = group
)

fit <- lm(Y ~ group, data = dat)
summary(fit)

library(lme4)


fit2 <- lmer(Y ~ group + iid + (1 | id), data = dat)

summary(fit2)

# Estimate R squared
r2.corr.mer <- function(m) {
  lmfit <-  lm(model.response(model.frame(m)) ~ fitted(m))
  summary(lmfit)$r.squared
}

r2.corr.mer(fit2)

# OR
1-var(residuals(fit2))/(var(model.response(model.frame(fit2))))

# a fixed ef model

fit3 <- lm(Y ~ group + factor(id), data =dat)

# likelihood ratio test between the zip and non-zero


# 
round(pf(q = 12293, df1 = 1, df2 = 15, lower.tail = FALSE), 3)

round(pf(q = 0.0001, df1 = 1, df2 = 15, lower.tail = FALSE), 3)


