#my new file


data("Loblolly")
# load Loblolly
?Loblolly

Loblolly$Seed
class(Loblolly$Seed)
class(Loblolly$height)

str(Loblolly)
summary(Loblolly)
table(Loblolly$Seed)
levels(Loblolly$Seed)

as.numeric(Loblolly$Seed)
as.character(Loblolly$Seed)

nums1 <- as.character(Loblolly$Seed) %>%
  as.numeric()
library(tidyverse)
glimpse(Loblolly)
hist(Loblolly$age)
hist(Loblolly$height,breaks=84)

plot(y=Loblolly$height,x=Loblolly$age,col=Loblolly$Seed,
     pch=19,main = "Trees Grow, yo!",xlab = "Tree Age",
     ylab="Tree Haight")

plot(x=Loblolly$Seed,y=Loblolly$height)
table(Loblolly$Seed,Loblolly$age)
plot(x=Loblolly$Seed,y=Loblolly$age)
