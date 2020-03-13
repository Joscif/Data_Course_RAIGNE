library(tidyverse)
library(modelr)
library(GGally)
library(lindia)
library(skimr)
library(patchwork)
library(caret)

df <- read.csv("../../Data/mushroom_growth.csv", stringsAsFactors = F)

df %>% ggpairs()
df %>% ggpairs(mapping= c("GrowthRate", "Humidity"))
str(df)


# • Which variable is your response?
#  • Which variables are explanatory?
# • Are the explanatory variables continuous, categorical, or both?
#   1. All continuous: Regression
#   2. All categorial: ANOVA
#   3. Mix: ANCoVA

# Is the response variable continuous, a count, a proportion, a category????
# • Continuous: Regression, ANOVA, ANCoVA
# • Catergorical: ANOVA
# • Proportion: Logistic regression
# • Count: Log-Linear model
# • Binary: Binary logistic

mod1 <- ulm(data = df, formula = GrowthRate ~(Nitrogen*Light)+Temperature)

summary(mod1)
plot()

mod2 <- aov(data = df, formula = GrowthRate ~ Light* Temperature)

df$Light <- as.numeric(as.character(df$Light))
# 4. calculates the mean sq. error of each model
mod1mse <- mean(residuals(mod1)^2)
mod2mse <- mean(residuals(mod2)^2)

# 5. selects the best model you tried
#mod2

# 6. adds predictions based on new values for the independent variables used in your model
pred2 = add_predictions(df, mod2)
pred1=add_predictions(df, mod1)

# 7. plot these predictions alongside the real data
p1 <- ggplot(pred1,aes(x=Light,color=Temperature)) +
  geom_point(aes(y=GrowthRate),alpha=.5,size=2) +
  geom_smooth(method = "lm",aes(y=pred),color="Black") + theme_bw()

p1

P1 <- add_predictions(df, mod1) %>% 
  
  ggplot(aes(x= Light))+
  geom_point(aes(y= GrowthRate))+
  geom_point((aes(y=pred, color="Red")))+
           labs (title = "TEMP VS LIGHT")
P1

set.seed(123) # set reproducible random number seed
set <- caret::createDataPartition(df$GrowthRate, p=.5) # pick random subset of data 
set <- set$Resample1 # convert to vector

train <- df[set,] # subset mtcars using the random row numbers we made
test <- df[-set,] # The other half of the mtcars

# build our best iris model (mod3, from above)
formula(mod1)
mod1_cv <- lm(data=train, formula = formula(mod1))
test <- add_predictions(test,mod1_cv)

ggplot(test,aes(x=Nitrogen,color=Light)) +
  geom_point(aes(y=GrowthRate),alpha=.25) +
  geom_point(aes(y=pred),shape=5)




# • Upload responses to the following as a numbered plaintext document to Canvas:
#   1. Are any of your predicted response values from your best model scientifically meaningless? Explain.
# 2. In your plots, did you find any non-linear relationships? If so, do a bit of research online and give
# a link to at least one resource explaining how to deal with this in R