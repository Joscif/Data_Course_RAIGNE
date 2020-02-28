df1<- read.csv("./landdata-states.csv",stringsAsFactors = F)
dfDC<- read.csv("./landdata-states.csv",stringsAsFactors = F)
library(tidyverse)
options(scipen = 10000000)

#I. 
p1 <- ggplot(df1,aes(x=Year,y=Land.Value, color=region))+
  geom_smooth(size=1.25)+
  scale_color_discrete("Region")+
  theme_minimal()+
  labs(y="Land Value (USD)")

ggsave("./RAIGNE_Fig_1.jpg", device="png", dpi=300, height = 6, width = 7)
str(df1)

#II.

df1[df=='NA'] <- NA
df2 <- subset(df1, is.na(df1$region))
df2[,1:2]
#or
#Changed NA to Mid-Atlantic, this is the region that google said DC is in.
dfDC[is.na(dfDC)]="Mid-Atlantic"

newDC<- filter(dfDC, region=="Mid-Atlantic")
newDC[,1:2]

# III.    The rest of the test uses another data set. The unicef-u5mr.csv data. 
# It's not exactly tidy. You had better tidy it!

uni<- read.csv("./unicef-u5mr.csv")

uni1 <- uni %>% pivot_longer(c(contains("U5MR")), names_to = "Year", values_to = "MortalityRate")

tidyuni <- na.omit(uni1)

new_uni <- str_remove(tidyuni$Year,"U5MR.")
tidyuni$Year <- new_uni

tidyuni$Year <- as.numeric(tidyuni$Year)
p2<- ggplot(tidyuni, aes(x = (Year), y = MortalityRate, color=Continent))+
  geom_point(size=2.5, shape=16)+theme_minimal()+
  labs(x="Year")
p2 + scale_x_continuous(breaks=seq(1960, 2000, 20))

# IV.     Re-create the graph shown in fig2.png
#         Export it to your Exam_2 folder as LASTNAME_Fig_2.jpg 

ggsave("./RAIGNE_Fig_2.jpg", device="png", dpi=300,width = 7, height = 6)

       

# IV.     Re-create the graph shown in fig3.png
# Note: This is a line graph of average mortality rate over time for each continent 
# (i.e., all countries in each continent, yearly average), this is NOT a geom_smooth() 
# Export it to your Exam_2 folder as LASTNAME_Fig_3.jpg (note, that's a jpg, not a png)

ggplot(tidyuni, aes(x= Year,y=MortalityRate, color=Continent))+
  stat_summary(fun.y="mean",geom = "line", size=2.5)+
  theme_minimal()+ labs(y= "Mean Mortality Rate(deaths per 1000 live births)")

ggsave("./RAIGNE_Fig_3.jpg", device = "png", dpi = 300, height = 6, width = 7)

# V.      Re-create the graph shown in fig4.png
#         This is a scatterplot, faceted by region
#         Export it to your Exam_2 folder as LASTNAME_Fig_3.jpg 
library(scales)

p4 <- ggplot(tidyuni, aes(x= Year,y=(MortalityRate/1000)))+
  geom_point(size=0.4, color="#0000FF", shape=16)+
    theme_minimal()+ labs(y= "Mortality Rate")+
  theme(strip.background = element_rect(size = 0.5))

p4 + facet_wrap(~ Region,ncol = 5, nrow = 5,)

ggsave("./RAIGNE_Fig_4.jpg", device = "jpg", height = 7, width = 7, dpi = 300)

# VI.		Commit and push all your code and files to GitHub. 





