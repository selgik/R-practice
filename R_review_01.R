#R codes Review - Jan 02, 2022

#[1] Part 1
#1. install package
install.packages("palmerpenguins")

#2. check installed packages
installed.packages()

#3. load package before using, nothing will show up in the console
library("palmerpenguins")

#4. get summary, results will appear in the console
summary(penguins)

#5. View will show reader-friendly table separately
View(penguins)


#[2] Part 2
#1. Functions: print 
print("Today is January 02, 2022")

#2. Variable (also called as objects)
variable_x <- "this is variable"
variable_y <- 123.45
variable_y-23.45

#3. Ask about function: add ? before function name.
?print()

#4. Ask about package: package guide
browseVignettes("tidyverse")


#[3] Part 3
#1. Vector: add L for integer
vec_1 <- c(12,34,56,78.9)
vec_1 
vec_2 <- c(1L, 5L, 10L)
vec_2
vec_3 <- c("Anna", "Beta", "Cera")
vec_3

#2. Vector: calculate lenght, assign title
length(vec_1)
names(vec_1) <- c("x-axis", "y-axis", "z-axis", "average")
vec_1

#3. List: containing different type
list("a", 1L, 3.5, FALSE)
list('x-axis'=1, 'y-axis'=2, 'z-axis'=3)

#4. Data frame
data.frame(x=c(1,2,3), y=c(2.4, 4.4, 5.1), z=c("NY", "SF", "CO"))

#5. Matrix: c(3:9) won't work.
matrix(c(3:10), nrow=2)
matrix(c(3:10), ncol=2)


#[4] Part 4
#1. Logical operators: and &, or |, not!
x <-10
x<12 & x>11
x<12 | x>11
!x>11
!(x>15 | x<5)

#2. Conditional statement: if(){then}
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

#[5] Part 5
#1. view summary: tidyverse package is used.
head(diamonds)

#2. view column summary: function(dataset)
str(diamonds)
glimpse(diamonds)
colnames(diamonds)

#3. rename column or variable: rename(dataset, new_name=old_name) 
rename(diamonds, carat_new=carat)

#4. summary statistics: summarize(dataset, col_name=mean(col))
summarize(diamonds, mean_carat=mean(carat))

#5. viz data
ggplot(data=diamonds, aes(x=carat, y=price))+ geom_point()
ggplot(data=diamonds, aes(x=carat, y=price, color=cut)) + geom_point()
ggplot(data=diamonds, aes(x=carat, y=price, color=cut)) +
 geom_point() +
 facet_wrap(~cut)


#[6] Part 6
#1. Pipe: similar to nested query. Ex. gather->group->manipulate
data("ToothGrowth")
View(ToothGrowth)

#2. Install or load dplyr for filtering function.
library(dplyr)
filtered_tg <- filter(ToothGrowth,dose==0.5)
View(filtered_tg)

#3. Sort with arrange function
arrange(filtered_tg, len)

#4. Nested query
arrange(filter(ToothGrowth,dose==0.5), len)

#5. Use pipe: %>%
filtered_toothgrowth <- ToothGrowth %>%
filter(dose==0.5) %>%
arrange(len)
View(filtered_toothgrowth)

filtered_toothgrowth <- ToothGrowth %>%
filter(dose==0.5) %>%
group_by(supp) %>%
summarize(mean_len=mean(len,na.rm=T),.group="drop")
View(filtered_toothgrowth)

