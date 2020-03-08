
?rnorm
?rbinom
?runif
set.seed(123)
a <- rnorm(1000,mean=0, sd=1)

b <- rnorm(1000,mean = 5,sd=1)

hist(a)
hist(b)

df <- data.frame(a=a,b=b) %>% gather(key=object,value=value,1:2)
    ggplot(df,aes(x=value, fill=object))+ geom_histogram(alpha=0.5)
#area under cure show the probablity of getting a random sample at chosen point (above or below)
    pnorm(7,mean=5,sd=1,lower.tail=F)
#0.022 chance of a getting a 7 or greater in the normal distribution. 
    
#ttest
    t.test(a,b)
    