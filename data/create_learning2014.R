# This file was created by Maria Zubair on 08-11-2019.
# In this file, there is practice code for data wrangling in R.


######################## Step 2 #########################

# Reading data
data <- read.table(
  "http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt ",
  sep="\t", header=TRUE)

# Dimensions 
dim(data)
# The output shows that there are 60 columns and 183 rowss.

# Structure
str(data)
# The output shows information about all the columns including the 
# name, type, number of observations and some sample data of each variable. 

######################## Step 3 #########################

# Adding attitude variable
data$attitude = data$Attitude/10

# Scaling combination variables - deep, surf and stra
library(dplyr)
deep_questions <- c("D03", "D11", "D19", "D27", "D07", "D14", "D22", "D30","D06",  "D15", "D23", "D31")
surface_questions <- c("SU02","SU10","SU18","SU26", "SU05","SU13","SU21","SU29","SU08","SU16","SU24","SU32")
strategic_questions <- c("ST01","ST09","ST17","ST25","ST04","ST12","ST20","ST28")

deep_columns <- select(data, one_of(deep_questions))
data$deep <- rowMeans(deep_columns)

surface_columns <- select(data, one_of(surface_questions))
data$surf <- rowMeans(surface_columns)

strategic_columns <- select(data, one_of(strategic_questions))
data$stra = rowMeans(strategic_columns)

# Creating analysis dataset using filters
keep_columns <- c("gender","Age","attitude", "deep", "stra", "surf", "Points")
learning2014 <- select(data, one_of(keep_columns))

# Updating column names as per given in the description of the question.
# To check: colnames(learning2014)
colnames(learning2014)[2] <- "age"
colnames(learning2014)[7] <- "points"
# To check: colnames(learning2014)

# Exclude observations where the exam points variable is zero. 
learning2014 <- filter(learning2014, points > 0) 
str(learning2014)

######################## Step 4 #########################
# To set working directory
# dir <- "/Users/zmaria/IODS-project"
# setwd(dir)

# To get help
# ?write.csv

# To write csv
write.csv(learning2014, file = "data/learning2014.csv")

datafromfile <- read.csv(file = "data/learning2014.csv", row.names = 1)
head(datafromfile)


