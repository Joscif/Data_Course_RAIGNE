#MP= read.csv("../../Data/ITS_mapping.csv", sep=" ", na= "   ")???


?read.csv
#fill is key in missing data
#skip=1, nrows= 1, colnames(dataset) <- dataset[1,]


MP1 <- read.delim("../../Data/ITS_mapping.csv")
         

library(tidyverse)
 
str(MP1)

 summary(MP1)  
 table(MP1$Ecosystem)
 
plot(x=MP1$Ecosystem, y=MP1$Lat)
getwd()
png(filename = "silly_boxplot.png")
plot(x=MP1$Ecosystem, y=MP1$Lat)
dev.off()

