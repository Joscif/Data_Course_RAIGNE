library(tidyverse)

df1 <- read.csv("./Data/FacultySalaries_1995.csv")

df2 <- read.csv("./Data/wide_income_rent.csv")

str(df1)
#one variable per column and one observation per row
# 5:7, c(5,6,7) or you cane use names of columns


long <- gather(df1, key= Rank, value=Salary, 5:7)

new_names <- str_remove(long$Rank,"Avg") %>% str_remove("Salary")

long$Rank <- new_names

ggplot(long, aes(x=Rank,y=Salary,fill=Rank))+geom_boxplot()+
  scale_fill_brewer(palette = 2)

#key=new name of variable (column name), value is new name for values for what was in those cells

comp <- gather(long, key=RankComp ,value =CompSalary, 6:8)
new_Comp <- str_remove(comp$RankComp,"Avg") %>% str_remove("Comp")
comp$RankComp <- new_Comp

ggplot(comp, aes(x=RankComp,y=CompSalary,fill=RankComp))+geom_boxplot()+
  scale_fill_brewer(palette = 4)

#now combine composation and salary ass plot together
library(patchwork)
p1+p2
#or

CVS <- gather(comp, key=RANK, value=Dollars, c(13,15))
names(comp)

#df2
names(df2)

df2.1 <- gather(df2, key = State, value= Amount,2:53)              
names(df2.1)[1] <- "Type"

ggplot(df2.1, aes(x=State,y=Amount))+geom_point()+facet_grid(~"Type")
?gather()
