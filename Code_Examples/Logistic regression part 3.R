library(carData)
library(tidyverse)
library(modelr)
#https://youtu.be/5_W-dH2d4EI

data("MplsDemo")
data("MplsStops")

MplsStops$vehicleSearch <- as.character(MplsStops$vehicleSearch)
MplsStops$vehicleSearch[MplsStops$vehicleSearch =="NO"] <- FALSE
MplsStops$vehicleSearch[MplsStops$vehicleSearch =="YES"] <- TRUE
table(MplsStops$vehicleSearch)

MplsStops$citationIssued <- as.character(MplsStops$citationIssued)
MplsStops$citationIssued[MplsStops$citationIssued =="NO"] <- FALSE
MplsStops$citationIssued[MplsStops$citationIssued =="YES"] <- TRUE
MplsStops$citationIssued[is.na(MplsStops$citationIssued)] <- FALSE
table(MplsStops$citationIssued)

names(MplsStops)

#remove rows with missing gender info.
MplsStops$gender <- as.character(MplsStops$gender)
MplsStops <- MplsStops[which(MplsStops$gender !="Unknown"),]

dat <- full_join(MplsStops,MplsDemo,by="neighborhood")

dat$vehicleSearch <- as.logical(dat$vehicleSearch)
dat$citationIssued <- as.logical(dat$citationIssued)

names(dat)
mod1 <- glm(data=dat,formula=vehicleSearch~ race+gender+hhIncome,family = "binomial")
mod2 <- glm(data=dat,formula=citationIssued~ race+gender+hhIncome,family = "binomial")
mod3 <- glm(data=dat,formula=vehicleSearch~ race+gender+hhIncome+ black, family = "binomial")

dat2 <- add_predictions(dat,mod1,type="response")
dat3 <- add_predictions(dat,mod2,type="response")
dat4 <- add_predictions(dat,mod3,type="response")

summary(mod1)

ggplot(dat2, aes(x=hhIncome,y=pred, color=race))+ geom_smooth(se=FALSE)+
  theme_minimal()+ labs(y="predicted probability of vehicle search")+facet_wrap(~gender,drop = T)+
  theme(axis.text.x= element_text(angle = 60))

summary(mod2)

ggplot(dat3, aes(x=hhIncome,y=pred, color=race))+ geom_smooth(se=F)+
  theme_minimal()+ labs(y="predicted probability of citation issuance")+facet_wrap(~gender,drop = T)+
  theme(axis.text.x= element_text(angle = 60))

summary(mod3)

ggplot(dat4, aes(x=black,y=pred, color=race))+ geom_smooth(se=FALSE)+
  theme_minimal()+ labs(y="predicted probability of vehicle search",
                        x="proportion of black residents in stop neighborhood")+facet_wrap(~gender,drop = TRUE)+
  theme(axis.text.x= element_text(angle = 60))


