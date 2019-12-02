## This file was created by Maria Zubair on 01-12-2019.
## In this file,there is data wrangling code which uses human.csv created last week using create_human.R..

library(dplyr)

human <- read.table("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human1.txt", header = TRUE, sep = ",")

dim(human)

# This data has 195 observations and 19 variables. 

str(human)

# Each row represents data of one country given in the Country variable. 
# All other variables represent indicators related to health, education and employement. 
# Contries are ranked based on these indicators. 

########## 1. Mutate the data ##########

str(human$GNI)
human <- mutate(human, GNI = str_replace(human$GNI, pattern=",", replace ="") %>% as.numeric)
str(human$GNI)

########## 2. Excluded unneeded variables ##########
cols <- c("Country", "Edu2.FM", "Labo.FM", "Edu.Exp", "Life.Exp", "GNI", "Mat.Mor", "Ado.Birth", "Parli.F")
human <- select(human, one_of(cols))
str(human)

########## 3. Remove all rows with missing values ##########
human <- na.omit(human)
str(human)

########## 4. Remove the observations which relate to regions instead of countries.  ##########

last <- nrow(human) - 7
human <- human[1:last, ]

########## 5. Define the row names of the data by the country names. ##########
rownames(human) <- human$Country
human <- select(human, -Country)

dim(human)
# write to file
write.csv(human, file = "data/human.csv", row.names = TRUE)

