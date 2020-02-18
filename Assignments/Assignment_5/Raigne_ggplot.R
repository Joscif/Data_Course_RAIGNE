library(tidyverse)
data("iris")


Plot_1<- ggplot(iris, aes(x=Sepal.Length, y=Petal.Length, color=Species))+
    geom_point()+ geom_smooth(method="lm") + labs(title= "Sepal length vs petal length",subtitle=("for three iris species"))+ 
  theme_minimal()

png(filename = "iris_fig1.png")
Plot_1
dev.off()

Plot_2 <- ggplot(iris, aes(x=Petal.Width, color=Species, fill=Species))+
  geom_density(colour="black", alpha=0.5)+labs(title= "Sepal length vs petal length",subtitle=("for three iris species"))+ 
  theme_minimal() #how to make a black ouline?



png(filename = "iris_fig2.png")
Plot_2
dev.off()

Ratio <- iris[,c(2,4:5)] 

Ratio$SEPWID <- Ratio$Petal.Width / Ratio$Sepal.Width

Plot_3 <- ggplot(Ratio, aes(x=Species, y=SEPWID, color=Species,fill=Species,))+ 
  geom_boxplot(outlier.colour= "black",colour = "black",fatten=4)+ 
  theme_minimal()+
  labs(title="Sepal to Pedal Width Ratio", subtitle = "for three iris species", y ="Ratio of Petal Width to Sepal Width")
  

png(filename = "iris_fig3.png")
Plot_3
dev.off()         

  
# Sepal length deviance from the mean of all observations


 iris$Sample.Number <- rownames(iris) 
 
 iris$Deviance <- round((iris$Sepal.Length -  mean(iris$Sepal.Length)),digits=2)
 
 iris$Sepal_type <- ifelse(iris$Ave2 < 0, "below","above")
 
 iris <- iris[order(iris$Deviance), ] 
 
 iris$Sample.Number <- factor(iris$Sample.Number, levels = iris$Sample.Number)
 
 Plot_4 <- ggplot(iris,aes(x=Sample.Number,y=Deviance, fill=Species,dpi=300)) +
   geom_bar(stat = "identity", width=.76) +
   labs(title = "Sepal length Deviance from the Mean of all Observations",
        caption = "Note: Deviance = Sepal.length - mean(Sepal.length)",
        y= "Deviance from the Mean",x="") +
        coord_flip() + theme_minimal() + theme(axis.title.y = element_blank(),
        axis.text.y = element_blank(),axis.ticks.y = element_blank())
Plot_4 

 png(filename = "iris_fig4.png")
 Plot_4
 dev.off()   
 
             
  
