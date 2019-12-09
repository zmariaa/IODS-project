####### Step 1 #######

# - Load data sets
data_BPRS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/BPRS.txt", sep  =" ", header = T)
data_RATS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/rats.txt", sep  ="\t", header = T)

# - Data exploration
dim(data_BPRS)
str(data_BPRS)
summary(data_BPRS)
# The BPRS data contains 40 observations of 11 variables. All the variables are of int type. 
# Categorical variables are treatment and subject.

dim(data_RATS)
str(data_RATS)
summary(data_RATS)
# The RATS data contains 16 observations of 13 variables. All the variables are of int type. 
# Categorical variables are ID and Group.

####### Step 2 - Convert the categorical variables to factors. #######

library(dplyr)
library(tidyr)

data_BPRS$treatment <- factor(data_BPRS$treatment)
data_BPRS$subject <- factor(data_BPRS$subject)
str(data_BPRS)

data_RATS$ID <- factor(data_RATS$ID)
data_RATS$Group <- factor(data_RATS$Group)
str(data_BPRS)

####### Step 3 #######

# - Convert the data sets to long form.
data_BPRS <-  data_BPRS %>% gather(key = weeks, value = bprs, -treatment, -subject)
data_RATS <-  data_RATS %>% gather(key = WD, value = weight, -ID, -Group)

# - Add a week variable to BPRS and a Time variable to RATS.
data_BPRS <-  data_BPRS %>% mutate(week = as.integer(substr(weeks,5,5)))
data_RATS <-  data_RATS %>% mutate(Time = as.integer(substr(WD,3,4))) 

str(data_BPRS)
str(data_RATS)

####### Step 4  #######
# There is same information in both versions, the only difference is in structure. 
# As a result of above cases dimensions for data_BPRS change from 40x11 to 360x5.
# For RATS it changes from 16x13 to 176x5. 
# The transformation to long format gives a sensible structure as all the weeks (for BPRS) and weights (for RATS) are not independent variables.
# This structure helps in analyzing and plotting data. 

####### Writing data  #######
write.csv(data_BPRS, file = "data/BPRS.csv", row.names = TRUE)
write.csv(data_RATS, file = "data/RATS.csv", row.names = TRUE)
