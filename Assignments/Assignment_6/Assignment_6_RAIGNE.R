data("mtcars")
str(mtcars)
?mtcars
library(tidyverse)
AT <- mtcars %>% filter(am %in% "0")

write.csv(AT, file="./automatic_mtcars.csv")

HP<- ggplot(AT, aes(x=hp,y=mpg))+geom_point(size=2)+geom_smooth(method="lm",linetype=1,size=0.5,color="red")+
  labs(title = "Effect of horsepower on miles-per-gallon")+ theme_minimal()

HP
png("mpg_vs_hp_auto.png")
HP
dev.off()

WT<- ggplot(AT, aes(x=wt,y=mpg))+geom_point(size=2)+
  geom_smooth(method="lm",linetype=1,size=0.5,color="red")+
  labs(title = "Effect of weight on miles-per-gallon")+ theme_minimal()

WT
ggsave("mpg_vs_wt_auto.tiff",dpi=400,width = 6,height = 6)


disp<- subset(mtcars, disp<201)

write.csv(disp, file="./mtcars_max200_displ.csv")

orig.max <- max(mtcars$hp)
auto.max <- max(AT$hp)
disp.max <- max(disp$hp)


sink("./hp_maximums.txt")
print("original max hp")
orig.max
print("auto.tran max hp")
auto.max
print("disp max hp")
disp.max
sink(NULL)
