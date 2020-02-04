?read.table() #This brings up the help file
df = read.csv("../../Data/landdata-states.csv") # why did I change to read.csv ???

class(df) # what type of object is df?

head(df) # shows the first 6 elements of an object (first 6 rows if you give it a data frame)
 getwd()
 
 class(df$State)
str(df) 

#Questions:
  #• 1. What other stuff does read.csv() do automatically?
    #strings as factors
  #• 2. How is it different from read.csv2()? - read.csv(sep = ",",dec = ".") for read.csv2(sep = ";",dec = ",")
  #• 3. Why does read.csv2() even exist?- to import data that was used in the UK and new Zealand or to import data that was just entered in with (;) and (,) istead of (,) and (.)

df = read.csv("../../Data/landdata-states.csv", stringsAsFactors = FALSE )
str(df)
