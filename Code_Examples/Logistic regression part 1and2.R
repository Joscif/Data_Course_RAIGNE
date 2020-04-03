# logistic regresssion (familiy=binomial)

library(tidyverse)
library(modelr)
library(GGally)

dat <- read.csv("./Data/GradSchool_Admissions.csv", stringsAsFactors = F)

ggpairs(dat)

names(dat)
dat$admit <- as.logical(dat$admit)
dat$rank <- as.factor(dat$rank)

mod1 <- glm(formula = admit ~ gre + gpa + rank, data = dat, family ="binomial")

summary(mod1)

# For logistical regression analysis; when yourj dependant variable is
# TRUE/FALSE, you need to use glm and family= "binomial". 
# Finally when adding predictions type="response"

dat2 <- add_predictions(dat,mod1,type = "response")

ggplot(dat2, aes(x=gpa, y=pred, color=rank))+ 
  geom_point()

ggplot(dat2, aes(x=gre, y=pred, color=rank))+ 
  geom_point()

ggplot(dat2, aes(x=gpa, y=pred, color=rank))+ 
  geom_smooth(method = "lm")

#Part 2:

ggplot(dat, aes(x=gpa,y=admit))+
  geom_point()

ggplot(dat, aes(x=gre,y=admit))+
  geom_point()

newdat <- data.frame(gre=c(400,500,600,700,800),
                     gpa=c(3.5,2.5,4,3.75,4),
                     rank=c("4","4","4","4","1"))

add_predictions(newdat,mod1,type="response")
