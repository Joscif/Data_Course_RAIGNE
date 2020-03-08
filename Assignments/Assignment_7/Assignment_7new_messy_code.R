# Assignment 6 messy code
# Change this to "tidy" format using dplyr verbs

# There's an intuitive dplyr version for everything you see here.

# Note: Do not erase the original code, just comment it out and put your own equivalent code below each section
# i.e., change each line of indicated code to a tidy version that does the same thing.


library(tidyverse)

##########################
#        Part 1          #
##########################

# load data (wide format)
utah = read.csv("../../Data/Utah_Religions_by_County.csv")
#UT <- read_csv("../../Data/Utah_Religions_by_County.csv")

str(UT)
# subset to only counties with buddhists observed
#buddhist = utah[utah$Buddhism.Mahayana > 0,]
BD <- filter(UT, Buddhism.Mahayana > 0)


# order rows by population (descending)
#buddhist = buddhist[order(buddhist$Pop_2010, decreasing = TRUE),]
BD <- arrange(BD, desc(Pop_2010))


# write this new dataframe to a file
#write.csv(buddhist, file = "./buddhist_counties.csv", row.names = FALSE, quote = FALSE)
write_csv(BD, path = "./BD_counties.csv")

## get group summaries of religiousity based on population ##

# divide each county into one of six groups based on populations
# note: keep these two lines the same in your updated code!
groups = kmeans(utah$Pop_2010,6) # clusters data into 6 groups based on proximity to mean of potential groups
utah$Pop.Group = groups$cluster # assigns a new variable to utah giving group for each county

# subset to each group and find summary stats on Religiosity for each
# group1 = mean(utah[utah$Pop.Group == 1,]$Religious)
# group2 = mean(utah[utah$Pop.Group == 2,]$Religious)
# group3 = mean(utah[utah$Pop.Group == 3,]$Religious)
# group4 = mean(utah[utah$Pop.Group == 4,]$Religious)
# group5 = mean(utah[utah$Pop.Group == 5,]$Religious)
# group6 = mean(utah[utah$Pop.Group == 6,]$Religious)
 
group<- utah %>% group_by(Pop.Group)%>% summarise(Mean = mean(Religious))

# same, but mean population
# group1.pop = mean(utah[utah$Pop.Group == 1,]$Pop_2010)
# group2.pop = mean(utah[utah$Pop.Group == 2,]$Pop_2010)
# group3.pop = mean(utah[utah$Pop.Group == 3,]$Pop_2010)
# group4.pop = mean(utah[utah$Pop.Group == 4,]$Pop_2010)
# group5.pop = mean(utah[utah$Pop.Group == 5,]$Pop_2010)
# group6.pop = mean(utah[utah$Pop.Group == 6,]$Pop_2010)

group.pop <- utah %>% group_by(Pop.Group)%>% summarise(Mean = mean(Pop_2010))

# make data frame of each group and mean religiosity
# #religiosity = data.frame(Pop.Group = c("group1","group2","group3","group4","group5","group6"),
#            Mean.Religiosity = c(group1,group2,group3,group4,group5,group6),
#            Mean.Pop = c(group1.pop,group2.pop,group3.pop,group4.pop,group5.pop,group6.pop))

RL<- tibble(Pop.Group = c("group1","group2","group3","group4","group5","group6"),
            Mean.Religiosity=group$Mean,Mean.Pop =group.pop$Mean)



religiosity # take quick look at resulting table

# order by decreasing population
#religiosity = religiosity[order(religiosity$Mean.Pop, decreasing = TRUE),]
 RL <- arrange(RL, desc(Mean.Pop))

religiosity # take quick look at resulting table


#####################################
#              Part 2               #
# Beginning to look at correlations #
# run this code without changing it #
#####################################

# Look for correlations between certain religious groups and non-religious people
religions = names(utah)[-c(1:4)]

for(i in religions){
  rsq = signif(summary(lm(utah[,i] ~ utah$Non.Religious))$r.squared, 4)
  plot(utah[,i] ~ utah$Non.Religious, main = paste(i,"RSq.Val=",rsq), xlab = "Non_Religious",ylab=i)
  abline(lm(utah[,i] ~ utah$Non.Religious), col="Red")
}

#The R-squared value R2 is always between 0 and 1 inclusive.
# Perfect positive linear association. The points are exactly on the trend line.
# Correlation r = 1; R-squared = 1.00
# Large positive linear association. The points are close to the linear trend line.
# Correlation r = 0.9; R=squared = 0.81.
# Small positive linear association. The points are far from the trend line.
# Correlation r = 0.45; R-squared = 0.2025.
# No association. There is no association between the variables.
# Correlation r = 0.0; R-squared = 0.0.
# Small negative association.
# Correlation r = -0.3. R-squared = 0.09.
# Large negative association.
# Correlation r = -0.95; R-squared = 0.9025
# Perfect negative association.
# Correlation r = -1. R-squared = 1.00.

# Browse through those plots and answer the following questions:
# 1.  Which religious group correlates most strongly in a given area with the proportion of non-religious people?
  #LDS has the strongest correlation.

# 2.  What is the direction of that correlation?
  #Negative. (as non religious increase lds decrease )

# 3.  Which religious group has the second stronglest correlation, as above?
  #Episcopal Church

# 4.  What is the direction of THAT correlation?
  #positive

# 5.  What can you say about these relationships?
  # LDS and non religious populatios have negative relationship that has a pretty high correlation value of 0.75.
  # Epiiscopal Church has a positive relationship with non religious populations with a lower correlation value of 0.35.

# UPLOAD YOUR ANSWERS TO CANVAS
# DON'T FORGET TO PUSH YOUR TIDY CODE TO GITHUB AS WELL!