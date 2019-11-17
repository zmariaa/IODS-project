# This file was created by Maria Zubair on 17-11-2019.
# In this file, there is practice code for data wrangling in R.

###### Data Wrangling - Part 3 ######
data_mat = read.csv("data/student-mat.csv", sep = ";", header = TRUE )

dim(data_mat)
str(data_mat)

# data_mat has 396 observations of 33 variables

data_por = read.csv("data/student-por.csv", sep = ";", header = TRUE )

dim(data_por)
str(data_por)

# data_mat has 649 observations of 33 variables

identical(colnames(data_mat), colnames(data_por))

# identical column shows that colnames are same in data_mat and data_por

###### Data Wrangling - Part 4 ######

library(dplyr)
join_by <- c("school","sex","age","address","famsize","Pstatus","Medu","Fedu","Mjob","Fjob","reason","nursery","internet")

data_joined <- inner_join(data_mat, data_por, by = join_by, suffix = c(".mat", ".por"))
data_joined

dim(data_joined)
str(data_joined)
colnames(data_joined)

# joined_data has 382 observations and 53 variables

###### Data Wrangling - Part 5 ######

# create a new data frame with only the joined columns
alc <- select(data_joined, one_of(join_by))

# the columns in the datasets which were not used for joining the data
notjoined_columns <- colnames(data_mat)[!colnames(data_mat) %in% join_by]

# print out the columns not used for joining
notjoined_columns

# for every column name not used for joining...
for(column_name in notjoined_columns) {
  # select two columns from 'data_joined' with the same original name
  two_columns <- select(data_joined, starts_with(column_name))
  # select the first column vector of those two columns
  first_column <- select(two_columns, 1)[[1]]
  
  # if that first column vector is numeric...
  if(is.numeric(first_column)) {
    # take a rounded average of each row of the two columns and
    # add the resulting vector to the alc data frame
    alc[column_name] <- round(rowMeans(two_columns))
  } else { # else if it's not numeric...
    # add the first column vector to the alc data frame
    alc[column_name] <- first_column
  }
}

###### Data Wrangling - Part 6 ######

library(ggplot2)

# define a new column alc_use 
alc <- mutate(alc, alc_use = (Dalc + Walc) / 2)

# define a new logical column 'high_use'
alc <- mutate(alc, high_use = alc_use > 2)

###### Data Wrangling - Part 7 ######

# glimpse at the new combined data
glimpse(alc)
# checking dimensions
dim(alc)

# joined data has 382 observations of 35 variables

write.csv(alc, file = "data/alc.csv", row.names = FALSE)

datafromfile <- read.csv(file="data/alc.csv")
# str(datafromfile)
# colnames(datafromfile)
