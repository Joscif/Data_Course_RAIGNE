library(tidyverse)
library(modelr)
library(GGally)
library(lindia)
library(skimr)
library(patchwork)
library(caret)

# Now, use this workflow to model miles per gallon in the mtcars dataset!

# Things to consider:
# What variables are explanatory? 
# Explanatory variables: cyl, disp, hp, drat, wt, carb, and qsec

# What interaction terms are useful?
# I will use hp and wt

# What's the simplest model that has good explanatory power?

data("mtcars")
mtcars %>% ggpairs()

mtcars %>% ggpairs(mapping =c("mpg", "cyl"))

# lm() is linear model. There are LOTS of other model types
mod1 <- lm(data=mtcars, formula = mpg ~ hp)
mod2 <- lm(data=mtcars, formula = mpg ~ hp + wt)
mod3 <- lm(data=mtcars, formula = mpg ~ hp * wt)

summary(mod1)
summary(mod2)
summary(mod3)


mod1mse <- mean(residuals(mod1)^2)
mod2mse <- mean(residuals(mod2)^2)
mod3mse <- mean(residuals(mod3)^2)

df <- gather_predictions(mtcars, mod1,mod2,mod3) # add many models' predictions at once (tidy-style)
df
skim(df)
names(df)



p1 <- add_predictions(mtcars,mod2) %>%
  ggplot(aes(x=hp,color=(wt))) +
  geom_point(aes(y=mpg)) +
  geom_smooth(method = "lm",aes(y=pred)) +
  labs(title = "wt + cyl")

p2 <- add_predictions(mtcars,mod3) %>%
  ggplot(aes(x=hp,color=(wt))) +
  geom_point(aes(y=mpg)) +
  geom_smooth(method = "lm",aes(y=pred)) +
  labs(title = "wt * cyl")

p1 / p2

#mod 3 seems best


# Cross-validation ####

# if we train our model on the full data set, it can become "over-trained"
# In other words, we want to make sure our model works for the SYSTEM, not just the data set

set.seed(123) # set reproducible random number seed
set <- caret::createDataPartition(mtcars$mpg, p=.5) # pick random subset of data 
set <- set$Resample1 # convert to vector

train <- mtcars[set,] # subset mtcars using the random row numbers we made
test <- mtcars[-set,] # The other half of the mtcars

# build our best iris model (mod3, from above)
formula(mod3)
mod3_cv <- lm(data=train, formula = formula(mod3))


# Test trained model on unused other half of data set
cartest <- add_predictions(test,mod3_cv)

# plot it
ggplot(cartest,aes(x=hp,color=wt)) +
  geom_point(aes(y=mpg),alpha=.25) +
  geom_point(aes(y=pred),shape=5)


# compare MSE from our over-fitted model to the cross-validated one
testedresiduals <- (mtcars$pred - cartest$mpg)

mod3mse # our original MSE
mean(testedresiduals^2) # our cross-validated model

# Plot comparison of original and validated model 

# gather model predictions
df <- gather_predictions(mtcars, mod3,mod3_cv)

# plot - distinguish model predictions using "linetype"
ggplot(df, aes(x=hp,color=wt)) +
  geom_point(aes(y=mpg),alpha=.2) +
  geom_smooth(method = "lm",aes(linetype=model,y=pred)) + theme_bw()

