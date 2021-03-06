# Assignment Week 3


library(tidyverse)

# topics:   type conversions, factors, plot(), making a data frame from "scratch",
#           reordering, 


# vector operations!

vector1 = c(1,2,3,4,5,6,7,8,9,10)
vector2 = c(5,6,7,8,4,3,2,1,3,10)

vector1*vector2

list.files()

dat = read.csv("../../Data/thatch_ant.csv")


names(dat) 
class(dat$Size.class)

#why are these plots different???
plot(x=dat$Headwidth..mm., y=dat$Mass)
plot(x=dat$Size.class, y=dat$Mass)
class(dat$Size.class)
#Answer: the plot that contains variable Size.class is a box and wisker plot because it contains factor data and the other contains numeric data only.

#check the classes of these vectors
class(dat$Headwidth..mm.)
class(dat$Size.class)

# plot() function behaves differently depending on classes of objects given to it!

# Check all classes (for each column in dat)
str(dat)

# Two of them are "Factor" ....why is the column "Headwidth" a factor? It looks numeric!
#Answere: factor data is stored numerically in R but the value is catagorical data not numeric data.
#Answere: ants with headwiths of specific mm are catagorized catigorically with assigned numbers, ie 43.000. 
#Answere: this is all because there was a data point in headwidth that was entered in with"" thus R made whole column factor instead of numeric data.

# we can try to coerce one format into another with a family of functions
# as.factor, as.matrix, as.data.frame, as.numeric, as.character, as.POSIXct, etc.... 
# note-these as.funtions only show as new data class but does not change, so one must assigne output to new vector!!!

#make a numeric vector to play with:
nums = c(1,1,2,2,2,2,3,3,3,4,4,4,4,4,4,4,5,6,7,8,9)
class(nums) # make sure it's numeric




# convert to a factor
as.factor(nums) # show in console
nums_factor = as.factor(nums) #assign it to a new object as a factor
class(nums_factor) # check it

#check it out
plot(nums) 
plot(nums_factor)
# take note of how numeric vectors and factors behave differently in plot()

# Let's modify and save these plots. Why not!?
?plot()
plot(nums, main = "numeric data", xlab = "number position", ylab = "value of number")
plot(nums_factor, main = "numeric data and factor", xlab = "number", ylab = "qauntiity of number")

jpeg("factor_vs_numerical_data_plot1.jpeg")
plot(nums, main = "numeric data", xlab = "number position", ylab = "value of number")

dev.off()


jpeg("factor_vs_numerical_data_plot2.jpeg")
plot(nums_factor, main = "numeric data and factor", xlab = "number", ylab = "qauntiity of number")

dev.off()


# back to our ant data...
dat$Headwidth
levels(dat$Headwidth) # levels gives all the "options" of a factor you feed it

# I notice a couple weird ones in there: "" and "41mm"
# The "" means a missing value, basically. The "41mm" sure looks like a data entry error.
                                            # It should probably be "41.000"

# FIND WHICH ONES HAVE "41mm"
dat$Headwidth == "41mm"
bad41 <- which(dat$Headwidth == "41mm")



# CONVERT THOSE TO "41.000"

dat$Headwidth[bad41] = "41.000"

# DO THE SAME FOR "", BUT CONVERT THOSE TO "NA"

badvalues <- which(dat$Headwidth == "")
dat$Headwidth[badvalues] <- NA


# NOW, REMOVE ALL THE ROWS OF "dat" THAT HAVE AN "NA" VALUE
dat2<- na.omit(dat)


# NOW, CONVERT THAT PESKY "Headwidth" COLUMN INTO A NUMERIC VECTOR WITHIN "dat"
as.numeric(as.character(dat2$Headwidth)) #reads in outward
dat2$Headwidth <- dat2$Headwidth %>% as.character() %>% as.numeric()#same thing

str(dat2)

unique(dat2$Headwidth)

plot(dat2$Headwidth,dat2$Mass)

# LET'S LEARN HOW TO MAKE A DATA FRAME FROM SCRATCH... WE JUST FEED IT VECTORS WITH NAMES!

# make some vectors *of equal length* (or you can pull these from existing vectors)
col1 = c("hat", "tie", "shoes", "bandana")
col2 = c(1,2,3,4)
col3 = factor(c(1,2,3,4)) # see how we can designate something as a factor             

# here's the data frame command:
data.frame(Clothes = col1, Numbers = col2, Factor_numbers = col3) # colname = vector, colname = vector....
df1 = data.frame(Clothes = col1, Numbers = col2, Factor_numbers = col3) # assign to df1
df1 # look at it...note column names are what we gave it.



# Make a data frame from the first 20 rows of the ant data that only has "Colony" and "Mass"
# save it into an object called "dat3"

dat3 <- dat2[1:20, c("Colony", "Mass")] 



###### WRITING OUT FILES FROM R #######
?write.csv()


# Write your new object "dat3" to a file named "LASTNAME_first_file.csv" in your PERSONAL git repository
# Export the data. The write.csv() function requires a minimum of two
# arguments, the data to be saved and the name of the output file.

write.csv(dat3, file = "RAIGNE_first_file.csv")

#get mean

under_30mass <- dat2 %>% filter (Size.class == "<30") %>%
  select(Mass) 

mean(under_30mass$Mass)

### for loops in R ###

#simplest example:
for(i in 1:10){
  print(i)
}

#another easy one

for(i in levels(dat$Size.class)){
  print(i)
}
levels(dat$Size.class)

# can calculate something for each value of i ...can use to subset to groups of interest
for(i in levels(dat2$Size.class)){
  print(mean(dat2[dat2$Size.class == i,"Mass"]))
}

# more complex:
# define a new vector or data frame outside the for loop first
new_vector = c() # it's empty
# also define a counter
x = 1

for(i in levels(dat2$Size.class)){
  new_vector[x] = mean(dat2[dat2$Size.class == i,"Mass"])
  x = x+1 # add 1 to the counter (this will change the element of new_vector we access each loop)
}

str(dat2)  
#check it
new_vector



# PUT THIS TOGETHER WITH THE LEVELS OF OUR FACTOR SO WE HAVE A NEW DATA FRAME:
# FIRST COLUMN WILL BE THE FACTOR LEVELS....
# SECOND COLUMN WILL BE NAMED "MEAN" AND WILL BE VALUES FROM  new_vector

#fill it in
size_class_mean_mass = data.frame(Size_Class =levels(dat2$Size.class),
                                  MEAN = new_vector)

size_class_mean_mass
# IMMPORTANT
dat2summary <- dat2 %>% group_by(Size.class) %>%  
  summarise(MEAN =mean(Mass), Second = mean(Headwidth), medianheadwidth = median(Headwidth))

############ YOUR HOMEWORK ASSIGNMENT ##############

# 1.  Make a scatterplot of headwidth vs mass. See if you can get the points to be colored by "Colony"
plot(y=dat2$Headwidth, x=dat2$Mass, col=dat2$Colony, 
     pch=19, main = "assignment 3 plot", xlab = "ant mass", ylab = "ant head width")


# 2.  Write the code to save it (with meaningful labels) as a jpeg file
jpeg("Assignment_3_plot.jpeg")
plot(y=dat2$Headwidth, x=dat2$Mass, col=dat2$Colony, 
     pch=19, main = "assignment 3 plot", xlab = "ant mass", ylab = "ant head width")
dev.off()


# 3.  Subset the thatch ant data set to only include ants from colony 1 and colony 2


dat12 <- dat2 %>% filter(Colony %in% c(1,2))



# 4.  Write code to save this new subset as a .csv file
write.csv(dat12, file = "./ant_colony12.csv")


# 5.  Upload this R script (with all answers filled in and tasks completed) to canvas
      # I should be able to run your R script and get all the plots created and saved, etc.
