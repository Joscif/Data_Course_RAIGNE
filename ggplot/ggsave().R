data("mtcars")
library(tidyverse)
library(patchwork)


  
p1 <- ggplot(mtcars, aes(x=disp, y=mpg, color=factor(cyl)))+
  geom_point()+geom_smooth()

p1




ggsave("./test1.png", plot=p1, device="png")

p2 <- ggplot(mtcars,aes(x=disp, y=mpg))+geom_smooth()

p3 <- ggplot(mtcars,aes(x=hp, y=mpg))+geom_smooth()

p1+p2+p3

ggsave("multiplot.png",dpi=300)

p1+theme_bw()
p1+scale_x_reverse()

pcol<- c("#872a23","#5c86ab","#70871c")

p1+labs(title="mpg vs dsip",
        x="disp",
        y="mpg",
        color="number of\ncylindrs",
        subtitle="sure why not",
        caption="mtcars")+
  scale_color_manual(pcol) # \n= new row

pcol<- c("#872a23","#5c86ab","#70871c")

mod <- lm(data=mtcars,formula=mpg~disp) # gives line equation
summary(mod)
mtcars$resids <- residuals(mod)
mtcars <- mutate(mtcars,DIFF=mpg-resids)

ggplot(mtcars, aes(x=disp,y=mpg))+
  geom_point()+geom_smooth(method="lm",se=FALSE)+
  geom_segment(aes(yend=DIFF,xend=disp))
  
  
  arrange()
group_by()
select()
mutate(mtcars,DIFF=mpg-resids)

df <- read.csv("../Data/mushroom_growth.csv")

glimpse(df)


ggplot(df, aes(x=Nitrogen,y=GrowthRate, color=Light))+
  geom_point()+geom_smooth(method="lm",formula=y~poly(x,2))+facet_wrap(~Species)+
  scale_color_gradient(low="Blue",high="Red")+
theme(strip.text = element_text(face="italic"))

mod2 <- lm(data=df, GrowthRate~poly(Nitrogen,2))
summary(mod2)

mtcars$fn <- "../Assignments/Assignment_5/iris_fig2.png"
library(ggimage)

ggplot(mtcars, aes(x=disp,y=mpg))+
  geom_image(aes(image=fn)+geom_smooth(method="lm",se=FALSE))+
  theme_minimal()

ggplot(mtcars, aes(x=disp,y=mpg))+
  geom_pokemon(image="zapdos")+geom_smooth(method="lm",se=FALSE)+
  theme_minimal()

list.pokemon()

             