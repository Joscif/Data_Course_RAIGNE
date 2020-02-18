library(tidyverse)


#load data
data("iris")

data("mtcars")


#ggplot(data,aes,geom-stat position)
#first argument is a data frame
names(iris)

ggplot(iris,aes(x = Sepal.Length,y = Sepal.Width, fill = Species))+
  geom_bar(stat = "identity")

ggplot(iris,aes(x = Sepal.Length,y = Sepal.Width, color = Species))+
  geom_bar(stat = "identity")
 
#bar chart showing mean of each species sepal length
############# Important##########
iris %>% group_by(Species) %>% 
  summarize(Mean = mean(Sepal.Length)) 

ggplot(iris %>% group_by(Species) %>% 
         summarize(Mean = mean(Sepal.Length)),aes(x = Species,y = Mean, fill =Species))+
  geom_col() #or you can pipe to ggplot


#another scatterplot
# setosa and versicolor
# scatterplot: x=Sepal.Length y=Sepal.Width, color= species


iris %>% filter(Species %in% c("setosa","versicolor")) %>% 
  ggplot(aes(x = Sepal.Length,y = Sepal.Width, color =Species))+
  geom_point()

 # another option :
 spp <- c("setosa","versicolor")
 
 iris %>% filter(Species %in% spp) %>% 
   ggplot(aes(x = Sepal.Length,y = Sepal.Width, color =Species))+
   #geom_point() +
   geom_smooth(method = "lm")
 
 
 
 names(mtcars)
 

 ggplot(mtcars, aes(x = disp, y = mpg, color = factor(cyl))) + 
    geom_point() +
   geom_smooth(method="lm",aes(group=1),colour="black")
   
 pcol<- c("#872a23","#5c86ab","#70871c")
 
 ggplot(mtcars, aes(x = disp, y = mpg)) + 
   geom_point(aes(color = factor(cyl)),size=2) +
   geom_smooth(method="lm",color="black",size=0.5,linetype=2,se=F)+
   labs(x="Displacement", y="Miles per Gallon",title="MPG vs Dosp.", subtitle="stuff", 
        caption ="caption area",color= "Cylinders") +
   scale_color_manual(values=pcol)
 
 #google color picker copy color code
  