cars<-c(1,4,6,10,15)
plot(cars,type="o")
title(main="Cars vs Index")

#Using ggplot
library(ggplot2)
ggplot(mtcars,aes(x=mpg,y=wt))+geom_point()+ggtitle("Miles per gallon vs weight")+labs(y="weight",x="Miles per gallon")+  geom_smooth(method = "lm",se=FALSE,color="Blue")



library(datasets)

#load data
data("mtcars")
View(mtcars)

#viewing first 5 rows
head(mtcars,5)

#create a scatter plot of displacement and miles per gallon
#add a title and axis names

ggplot(aes(x=disp,y=mpg),data=mtcars)+geom_point()+ggtitle("displacement vs miles per gallon")+labs(x="Displacement",y="Miles per Gallon")

#make vs a factor
mtcars$vs<-as.factor(mtcars$vs)

#create a boxplot for distribution of for v-shaped and straight engine
ggplot(aes(x=vs,y=mpg),data=mtcars)+geom_boxplot()

#add color to the boxplot to help differentiate
ggplot(aes(x=vs,y=mpg,fill=vs),data=mtcars)+
  geom_boxplot(alpha=0.3)+
  theme(legend.position = "none")

#create a histogram of wt
ggplot(aes(x=wt),data=mtcars)+geom_histogram(binwidth = 0.5)






