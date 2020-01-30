library(tidyverse)

#load some data
data("iris")

#subset
iris <- iris %>% filter(Species == "virginica")

glimpse(iris)
#plot x = petal length, y= iris
#pch- changes point character, col-changes color of circles, x.ylab- labels x and y axis
plot(x=iris$Petal.Length,y=iris$Sepal.Length,col=iris$Species, pch=19, main= "WOW!",
     ylab="Sepal Length",xlab="Petal Length")

summary(iris)

plot(x=iris$Species,y=iris$Sepal.Length,col=iris$Species, pch=19, main= "WOW!",
     ylab="Sepal Length",xlab="Species")

#breaks- changes the qauntity included in a 
hist(iris$Sepal.Length,breaks =20)

plot(density(iris$Sepal.Length))
#how to save a plot
jpeg("densityplot.jpeg")
plot(density(iris$Sepal.Length))
dev.off()

