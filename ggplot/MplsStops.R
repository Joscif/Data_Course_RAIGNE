library(carData)
library(tidyverse)
library(plotly)
df <- MplsStops
df2 <- MplsDemo
library(skimr)
getwd()
setwd("../Data_Course_RAIGNE/")

df3 <- full_join(df,df2,by="neighborhood")


ggplot(df,aes(x=lat,y=long,color=black.size=college))+
  geom_point(alpha=.5)

options(scipen=999)
geom_hex()
geom_density()

ggplot(df3,aes(x=lat,y=long,color=race))+
  geom_density_2d(linemitre = 20)

ggplot(df3,aes(x=lat,y=long,fill=race))+
  geom_hex(alpha=.5)


ggplot(df2,aes(x=white,y=collegeGrad))+
  geom_point()+
  geom_smooth(method="lm") #dots are nieborhoods

ggplot(df2,aes(x=foreignBorn,y=collegeGrad))+
  geom_smooth(method="lm",se=F,color="black")+
  geom_point(aes(size=hhIncome),color="purple",alpha=(0.5))+
  labs(x= "% of Foreign Born in Neiborhood",y= "College Graduate %", 
  title="Foreign vs Graduation Rate", size="Household Income")+
  theme_light()

df4 <- carData::Friendly

?Friendly

ggplot(df4,aes(x=condition,y=correct,color=condition))+
  geom_boxplot(alpha=.25)+geom_point(alpha=.25)+ theme_bw()

ggplot(df4,aes(x=condition,y=correct,fill=condition))+
  geom_violin()+geom_jitter(height = 0)+geom_boxplot(alpha=.25)+theme_bw()


df5 <- carData::Chile
?Chile
skim(df5)

df5 %>% filter(vote %in% c("N","Y")) %>%
ggplot(aes(x=statusquo,y=age,color=vote))+
         geom_point(alpha=0.5)+
  facet_wrap(~region)  ##facet wrap!!

pcol<- c("#872a23","#5c86ab")

ggplot(df5,aes(x=statusquo,fill=sex))+
  geom_density()+ facet_wrap(~region) +theme_minimal()+
  labs(x="Status Quo",y="Density",fill="Sex")+ 
  scale_fill_manual(labels=c("Female","Male"),values=(Pcol2))
  

library(RColorBrewer)
Pcol2 <- RColorBrewer::brewer.pal(name="Spectral",n=10)

ggplot(df5,aes(x=income,fill=sex))+
  geom_density()+ facet_wrap(~region)

ggplot(df5, aes(x=income,y=statusquo))+
  geom_smooth(method="lm")+geom_point()
