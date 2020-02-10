df <- read.csv("./DNA_Conc_by_Extraction_Date.csv",stringsAsFactors = T) ##factors?
?read.csv()
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

jpeg("RAIGNE_Plot1.jpeg")
plot(x=df$Year_Collected, y=df$DNA_Concentration_Katy,main= "Katy's Extractions",
     xlab="YEAR", ylab= "DNA Concentration")
dev.off()

jpeg("Raigne_plot2.jpeg")
plot(x=df$Year_Collected, y=df$DNA_Concentration_Ben,main= "Ben's Extractions",
     xlab="YEAR", ylab= "DNA Concentration")
dev.off()

Ben.summary <- summary(df$DNA_Concentration_Ben)
Katy.summary <- summary(df$DNA_Concentration_Katy)
cbind(Ben.summary,Katy.summary)


ben_vs_katy <-  df$DNA_Concentration_Ben- df$DNA_Concentration_Katy
min(ben_vs_katy)

Bens_worst <- which(ben_vs_katy == min(ben_vs_katy))

df[Bens_worst,"Year_Collected"]

# downstairs only:
Down_lab <- df %>% filter(Lab=="Downstairs")

Down_lab$Date_Collected <- as.Date.POSIXct(Down_lab$Date_Collected)

jpeg("Ben_DNA_over_time.jpg")
plot(x=Down_lab$Date_Collected, y=Down_lab$DNA_Concentration_Ben,main= "Bens DNA over time",
     xlab="Time", ylab= "DNA Concentration")
dev.off()

avg_Ben <- df %>% group_by(Year_Collected)%>% summarize(Average_Ben_Concentration = mean(DNA_Concentration_Ben),
                        Average_Katy_Concentration = mean(DNA_Concentration_Katy)) %>% mutate(Difference= Average_Ben_Concentration-Average_Katy_Concentration)

write.csv(avg_Ben,"Ben_Average_Conc.csv")
