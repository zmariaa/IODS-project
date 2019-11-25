# Step 2

hd <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human_development.csv", stringsAsFactors = F)
gi <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/gender_inequality.csv", stringsAsFactors = F, na.strings = "..")

###### Step 3 ######

dim(hd) 
dim(gi)

# HD has 195 observations of 8 variables. 
# GI has 195 observations of 10 variables.

str(hd) 
str(gi)

# It is clear that names of columns are long. 

summary(hd) 
summary(gi) 

# All of the variables have different scales. There are NAs or missing values in many variables in the datset.

###### Step 4 ######

colnames(hd)
colnames(hd) <- c("rank", "country", "HDI", "life_exp", "edu_eyears", "edu_myears", "GNI", "GNI_HDI")
colnames(hd)

colnames(gi)
colnames(gi) <- c("rank", "country", "GII", "mm_ratio", "ado_rate", "rep_par", "pop_sec_f", "pop_sec_m", "lab_part_f", "lab_part_m")
colnames(gi)

###### Step 5 ######

library(dplyr)
gi <- mutate(gi, pop_sec_fmratio = (pop_sec_f / pop_sec_m))
gi <- mutate(gi, lab_part_fmratio = (lab_part_f / lab_part_m))

###### Step 6 ######

human <- inner_join(hd, gi, by = "country", suffix = c(".hd",".gi"))
str(human) # To check

write.csv(human, file = "data/human.csv")


