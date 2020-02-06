df <- read.csv("./DNA_Conc_by_Extraction_Date.csv")
summary(df)
hist(df$DNA_Concentration_Katy,
     main= "Katy DNA Conc.",
     xlab="DNA Concentration")
hist(df$DNA_Concentration_Ben,
     main= "Ben DNA Conc.",
     xlab="DNA Concentration")
library(tidyverse)
glimpse(df)
df$Year_Collected <- as.factor(df$Year_Collected)
class(df$DNA_Concentration_Ben)
class(df$Year_Collected)
plot(x=df$Year_Collected, y=df$DNA_Concentration_Katy,main= "Katy's Extractions",
     xlab="YEAR", ylab= "DNA Concentration")
plot(x=df$Year_Collected, y=df$DNA_Concentration_Ben,main= "Ben's Extractions",
     xlab="YEAR", ylab= "DNA Concentration")
