#PURPOSE OF THE POST: to practice and review R codes
#PACKAGE USED: tidyverse, palmerpenguins, dplyr

#TABLE OF CONTENTS#
#PART1: INSTALL AND LOAD PACKAGES
#PART2: FUNCTION, VARIABLE AND DOCUMENTS
#PART3: VECTOR, LIST, MATRIX AND DATA FRAME
#PART4: LOGICAL OPERATION AND CONDITIONAL STATEMENT
#PART5: REVIEW, MANIPULATE AND VIZ DATA (BASICS)
#PART6: NESTED AND PIPE

###



#PART1: INSTALL AND LOAD PACKAGES
#1. check installed packages
installed.packages()

#2. install package if needed
install.packages("palmerpenguins")

#3. load package before using it. Nothing will show up in the console: library() / data("")
library("palmerpenguins")

#4. get summary. Results will appear in the console
summary(penguins)

#5. View will show reader-friendly table separately
View(penguins)


#PART2: FUNCTION, VARIABLE AND DOCUMENTS
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


#PART3: VECTOR, LIST, MATRIX AND DATA FRAME
#1. vector: A group of data elements of the same type stored in a sequence
vec_1 <- c(12,34,56,78.9)
vec_2 <- c(1L, 5L, 10L)
vec_3 <- c("Anna", "Beta", "Cera")

#2. list: similar to vector but containing different type 
list("a", 1L, 3.5, FALSE)

#3. calculate elements, assign titles for vector and list
length(vec_1)
names(vec_1) <- c("x-axis", "y-axis", "z-axis", "average")
vec_1

list('x-axis'=1, 'y-axis'=2, 'z-axis'=3)

#4. data frame: collection of columns, typically imported from different source
data.frame(x=c(1,2,3), y=c(2.4, 4.4, 5.1), z=c("NY", "SF", "CO"))

#5. matrix: two-dimentional collection of data elements, containing a single data type
#matrix(c(3:9), nrow=2) will give an error, as 7 elemetns are not 2x multiplier
matrix(c(3:10), nrow=2)
matrix(c(3:10), ncol=2)


#PART4: LOGICAL OPERATION AND CONDITIONAL STATEMENT
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


#PART5: REVIEW, MANIPULATE AND VIZ DATA (BASICS)
#1. view summary: disply columns and first few rows 
head(diamonds)

#2. view column summary: function(dataset)
str(diamonds)
glimpse(diamonds)
colnames(diamonds)

#3. rename column or variable: rename(dataset, new_name=old_name) 
rename(diamonds, carat_new=carat)

#4 add column: mutate(dataset, new_column=explain)
mutate(diamonds, carat_2=carat*100)
       
#5. summary statistics: summarize(dataset, col_name=mean(col))
summarize(diamonds, mean_carat=mean(carat))

#6. viz data
ggplot(data=diamonds, aes(x=carat, y=price))+ geom_point()

ggplot(data=diamonds, aes(x=carat, y=price, color=cut)) + 
geom_point()

ggplot(data=diamonds, aes(x=carat, y=price, color=cut)) +
 geom_point() +
 facet_wrap(~cut)


#PART6: NESTED AND PIPE
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


###END
