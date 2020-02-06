MP1 <- read.delim("../../Data/ITS_mapping.csv")
library(tidyverse)

glimpse(MP1)

table(MP1$Ecosys_Type)

#subset df to just Aerial and MArine     Ecosystem_TYpe2 <- 

df<- MP1 %>% filter(Ecosys_Type %in% c("Aerial","Marine"))

MP1[MP1$Ecosys_Type %in% c("Aerial", "Marine"),]

summary(MP1$Lat)[c(3,5)]

df$Ecosystem <- as.character((df$Ecosystem))
class(df$Ecosystem)
df$Ecosystem <- as.factor((df$Ecosystem)) #change back

#subset of Marine vs Subset of Terrestrial (Ecoys_Type)
# number of samples in each, and mean LAt of each
 mean(MP1$Lat)
 MP1[is.na(MP1$Lat),] <- 0 #or use filter to remove NA, see below

 # tidyvers below 
MP1 %>% filter(Lat != "NA") %>% group_by(Ecosys_Type) %>%
  summarize(NumberofSamples =n(),
  Mean_Lat = mean(Lat)) %>%
  filter(Ecosys_Type %in% c("Marine", "Terrestrial"))

#harder way:

marine <-  MP1 %>% filter(Ecosys_Type == "Marine")
terrestrial <- MP1 %>% filter(Ecosys_Type == "Terrestrial")

mean(marine$Lat)
length(marine$Lat)

mean(terrestrial$Lat)
length(terrestrial$Lat)
