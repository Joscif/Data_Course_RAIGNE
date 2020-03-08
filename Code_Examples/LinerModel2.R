library(MASS)
library(tidyverse)
library(modelr)

data("mtcars")
names(mtcars)

fullmodel <- lm(data=mtcars, mpg~ factor(cyl)+disp+hp+drat+wt+qsec+
                  factor(vs)+factor(am)+factor(gear)+factor(carb))

#dont run all variables just was that matter if * used R cant handle it.
step <- stepAIC(fullmodel)
step$call

step$call
# model-lm(formula = mpg ~ factor(cyl) + hp + wt + factor(am), data = mtcars)
goodmodel <- lm(formula = mpg ~ factor(cyl) + hp + wt + factor(am), data = mtcars)

mtcars %>% add_predictions(goodmodel)
set.seed(123)
set <- caret::createDataPartition((mtcars$mpg))
set <- set$Resample1######


train <- mtcars[set,]
test <- mtcars[-set,]

trainmodel <- lm(data = train, formula = formula(goodmodel))

add_predictions(test,trainmodel) %>%
  ggplot(aes(x=hp,color=factor(cyl)))+
  geom_point(aes(y=mpg))+geom_smooth(method="lm", aes(y=pred))
