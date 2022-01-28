#PURPOSE OF THE POST: review R codes
#PACKAGE USED: tidyverse, palmerpenguins, dplyr, here, skimr, janitor

#TABLE OF CONTENTS#
#BASIC1: VECTOR, LIST, MATRIX AND DATA FRAME
#BASIC2: FUNCTION, VARIABLE AND DOCUMENTS

#PART1: INSTALL AND LOAD PACKAGES
#PART2: IMPORT AND PREPARE DATA
#PART3: VIEW SUMMARY DATA
#PART4: ORGANIZE DATA
#PART5: MANIPULATE DATA
#PART6: VISUALIZE DATA
#PART7: NESTED AND PIPE
#PART8: LOGICAL OPERATION AND CONDITIONAL STATEMENT

#TIP1 : DO NOT TRUST DATA 
#TIP2 : CHECK THE BIAS
###




#----- BASIC1: VECTOR, LIST, MATRIX AND DATA FRAME
#1. vector: A group of data elements of the same type stored in a sequence
vec_1 <- c(12,34,56,78.9)
vec_2 <- c(1L, 5L, 10L)
vec_3 <- c("Anna", "Beta", "Cera")

#2. list: similar to vector but containing different type 
list("a", 1L, 3.5, FALSE)

#3. calculate elements, assign titles for vector and list
length(vec_1)
names(vec_1) <- c("x-axis", "y-axis", "z-axis", "average")

list('x-axis'=1, 'y-axis'=2, 'z-axis'=3)

#4. data frame: collection of columns, typically imported from different source
data.frame(city=c("NY", "SF", "CO"), days=c(2.4, 4.4, 5.1), rank=c(2,1,3))
#or step-by-step
city <- c("NY", "SF", "CO")
days <- c(2.4, 4.4, 5.1)
rank <- c(2,5,77)
result <- data.frame(city,days,rank)

#5. matrix: two-dimentional collection of data elements, containing a single data type
#matrix(c(3:9), nrow=2) will give an error, as 7 elemetns are not 2x multiplier
matrix(c(3:10), nrow=2)
matrix(c(3:10), ncol=2)


#----- BASIC2: FUNCTION, VARIABLE AND DOCUMENTS
#1. functions: print 
print("Today is January 02, 2022")

#2. variable: also called as objects
variable_x <- "this is variable"
variable_y <- 123.45
variable_y-23.45

#3. ask about function: add ? before function name
?print()

#4. ask about package: package guide
browseVignettes("tidyverse")






#----- PART1: INSTALL AND LOAD PACKAGES
#1. check installed packages
installed.packages()

#2. install package if needed
install.packages("palmerpenguins")

#3. load package before using it. Nothing will show up in the console: library(package) / data(dataset)
#data() will display list of available datasets.
library("palmerpenguins")
data(penguins)


#----- PART2: IMPORT AND PREPARE DATA
#1. working with csv: import csv file and select certain columns
test_file <- read_csv("test.csv")
test_extract <- select(test_file, column1, column2, column3)

#2. working with excel: import excel file and read specific sheet
read_excel("test.xls")
excel_sheets("test.xls")
read_excel("test.xls", sheet="sales")


#----- PART3: VIEW SUMMARY DATA
#1. View will display data in reader-friendly table format
View(penguins)  

#2. view summary: disply columns and first few rows, more of preview of data
head(penguins)
colnames(penguins)
glimpse(penguins)
str(penguins)

#3. view summary statistics
skim_without_charts(penguins) 
summary(penguins)                  

#4. view specific column(s)
select(penguins,species) # sames as below
penguins %>%
  select(species)

#by adding - before the column, will display all columns except for species
penguins %>%
  select(-species)


#----- PART4: ORGANIZE DATA
#1. arrange (sort) data. By adding - sign, you can sort DESC instead of default ASC
arrange(penguins, bill_length_mm)
arrange(penguins, desc(bill_length_mm))
penguins %>% arrange(bill_length_mm)
penguins %>% arrange(-bill_length_mm)

#2. max, min, mean: if dataset contains NA, result will show as NA
min(penguins$year)
max(penguins$year)
mean(penguins$year)

#3. group data -> remove NA value -> summarize them
penguins %>% group_by(island) %>% drop_na() %>% summarize(mean_bl_value=mean(bill_length_mm))
penguins %>% group_by(species, island) %>% drop_na() %>%
  summarize(mean_bl=mean(bill_length_mm), max_bl=max(bill_length_mm))

#4. filter value
filter(penguins, species=='Gentoo')
penguins %>% filter(species == "Gentoo")

#5. save cleaned data frame
cleaned_penguins <- penguins %>% arrange(bill_length_mm)
cleaned2_penguins <- penguins %>% select(island, species)


#----- PART5: MANIPULATE DATA
#1. rename column or variable: rename(dataset, new_name=old_name) 
rename(diamonds, carat_new=carat)
#similarly, this can be written in pipe
diamonds %>%
  rename(carat_new=carat)

#2. update all columns to upper/lower case
rename_with(diamonds,toupper)
rename_with(diamonds,tolower)

#3. clean column names by ensuring only characters, numbers and _ are in the columns
clean_names(diamonds)

#4. combine columns
example <- bookings_data %>%
  select(arrival_date_year, arrival_date_month) %>%
  unite(arrival_year_month, c("arrival_date_year", "arrival_date_month"), sep = " ,")

unite(bookings_data, 'arrival_year_month', arrival_data_year, arrival_date_month, sep= ' ,')
  
#5. separate column
separate(example, arrival_year_month, into=c('arrival_date_year', 'arrival_date_month'), sep= ' ')

#6. add column: mutate(dataset, new_column=explain)
mutate(diamonds, carat_2=carat*100)

example_2 <- bookings_data %>%
  mutate(total_guests=adults+children+babies)

#7. summary statistics: summarize(dataset, col_name=mean(col))
summarize(diamonds, mean_carat=mean(carat))

example3 <-bookings_data %>%
  summarize(number_canceled=sum(is_canceled),
            average_lead_time=mean(lead_time))

example4 <- bookings_data %>%
  mutate(number_canceled=sum(is_canceled),
         average_lead_time=mean(lead_time))

#example3 vs example4: ex3 shows summary statistics in one line. head() works well for ex3.


#----- PART6: VISUALIZE DATA
#1. basic
ggplot(data=penguins) + geom_point(mapping=aes(x=flipper_length_mm, y=body_mass_g))
ggplot(data=penguins, mapping=aes(x=flipper_length_mm, y=body_mass_g)) + geom_point

#2. map color, size, shape or alpha(difference in density)
ggplot(data=penguins)+geom_point(mapping=aes(x=flipper_length_mm,y=body_mass_g,color=species))
ggplot(data=penguins)+geom_point(mapping=aes(x=flipper_length_mm,y=body_mass_g,color=species,shape=species))
ggplot(data=penguins)+geom_point(mapping=aes(x=plipper_length_mm,y=body_mass_g,alpha=species))

#alternatives
ggplot(data=penguins, aes(x=flipper_length_mm, y=body_mass_g)) + geom_point()
ggplot(data=penguins, aes(x=flipper_length_mm,y=body_mass_g,color=species))+geom_point()
ggplot(data=penguins, aes(x=flipper_length_mm,y=body_mass_g,color=species))+geom_point(color="purple")
ggplot(data=penguins, aes(x=flipper_length_mm,y=body_mass_g,color=species))+geom_point()+facet_wrap(~species)

#3. do not map the color to specific variable but apply to entire chart
ggplot(data=penguins)+geom_point(mapping=aes(x=flipper_length_mm,y=body_mass_g),color="purple")

#4. different geoms such as smooth line and bar etc.
ggplot(data=penguins)+geom_smooth(mapping=aes(x=flipper_length_mm,y=body_mass_g))
ggplot(data=penguins)+geom_jitter(mapping=aes(x=flipper_length_mm,y=body_mass_g))    
ggplot(data=penguins)+geom_bar(mapping=aes(x=species))
ggplot(data=penguins)+geom_bar(mapping=aes(x=species,fill=species))  #color inside of the bar
ggplot(data=penguins)+geom_bar(mapping=aes(x=species,color=species)) #color outside of the bar
ggplot(data=penguins)+geom_bar(mapping=aes(x=species,fill=island))   #stacked bar chart

#examine relationship between trend line and data points
ggplot(data=penguins)+
  geom_smooth(mapping=aes(x=flipper_length_mm, y=body_mass_g))+
  geom_point(mapping=aes(x=flipper_length_mm, y=body_mass_g))

#different soothing lines
ggplot(data=penguins,aes(x=flipper_length_mm,y=body_mass_g))+
  geom_smooth(method="loess")                                       #Loess smoothing
  
ggplot(data=penguins,aes(x=flipper_length_mm,y=body_mass_g))+
  geom_smooth(method="gam",formula=y~s(x))                          #Gam smoothing

#5. facet function
ggplot(data=penguins)+
  geom_point(mapping=aes(x=flipper_length_mm, y=body_mass_g))+
  facet_wrap(~species)

ggplot(data=penguins)+
  geom_point(mapping=aes(x=flipper_length_mm,y=body_mass_g,color=species))+
  facet_grid(sex~species)

#6. filter before visualizing
penguins %>%
  filter(island=="Biscoe") %>%
  ggplot(mapping=aes(x=flipper_length_mm, y=body_mass_g,color=species))+
  geom_point()
 

#----- PART7: NESTED AND PIPE
#1. filter and sort data step by step 
data("ToothGrowth")
View(ToothGrowth)

#install or load dplyr for filtering function.
library(dplyr)
filtered_tg <- filter(ToothGrowth,dose==0.5)
View(filtered_tg)

#sort with arrange function
arrange(filtered_tg, len)

#2. nested query
arrange(filter(ToothGrowth,dose==0.5), len)

#3. use pipe: %>%
filtered_toothgrowth <- ToothGrowth %>%
filter(dose==0.5) %>%
arrange(len)
View(filtered_toothgrowth)

#filter->group->summarize
filtered_toothgrowth <- ToothGrowth %>%
filter(dose==0.5) %>%
group_by(supp) %>%
summarize(mean_len=mean(len,na.rm=T),.group="drop")
View(filtered_toothgrowth)


#----- PART8: LOGICAL OPERATION AND CONDITIONAL STATEMENT
#1. logical operators: and &, or |, not!
x <-10
x<12 & x>11      #FALSE
x<12 | x>11      #TRUE
!x>11            #TRUE
!(x>15 | x<5)    #TRUE

#2. conditional statement: if(){then}
x<- 5
if(x>0){
print("x is a positive number")
} else {
print("x is a negative number")
}

y <-1982
if (y>1990) {
print("Group1")
} else if (y>1980) {
print("Group2")
} else {
print("Group3")
}


#----- TIP1: DO NOT TRUST DATA
#1. Summary may indicate the similar dataset for below groups
libary('Tmisc')
data('quartet')
quartet %>%
  group_by(set) %>%
  summarize(mean(x),sd(x),mean(y),sd(y),cor(x,y))

#2. Visualizing them will reveal the difference between the grouped data
ggplot(quartet,aes(x,y))+geom_point()+geom_smooth(method=lm,se=FALSE)+facet_wrap(~set)


#----- TIP2: CHECK THE BIAS
#1. package needed
isntall.packages("SimDesign")
library("SimDesign")

#2. compare data
actual_data <- c(10,20,30,40,50)
predicted_data <-c(8,14,22,39,45)
bias(actual_data,predicted_data)
#result: [1] 4.4 

actual_data2 <- c(10,20,30,40,50)
predicted_data2 <- c(12,24,39,47,55)
bias(actual_data2, predicted_data2)
#result: [1] -5.4 
#the more the result is closer to 0, the less the dataset is biased

###END
