# WELCOME TO R STUDIO ################################
## This is the interface you are going to get used to ======
# This is color coded in green beacuse it is a comment
# You can change the visualisation by going on Tools>Golobal Options

# Flag the soft-wrap R source files option to have the code going authomatically to the next raw when it is too long 

# To comment and un-comment strings you can use the shift+ctrl+c shortcut
#comments can be used to create paragraph and subparagraphs in your document

# THIS IS A LEVEL 1 HEADER #################################

## This Is a Level 2 Header ================================

### This is a level 3 header. ------------------------------

# BASIC OPERATIONS WITH R################################
## Math ================
8+5 #Basic math; press ctrl+enter to run it
#R works in vector [1] is the index number ctrl Enter

## Create a sequence ================
1:250 #Print numbers between 1 and 250 across several lines
#To Clear the console press ctrl+l
100:1 #Print numbers from 100 to 1
seq(10)#Print numbers from 1 to 10
seq(30, 0, by = -3)#Print numbers from 30 to 0 every 3

## Print a String ================
print('Hello World!') #Prints "Hello World" in the console basically a string variable 

## Define Variables ================
x <- 1:5 #Put the numbers between 1-5 in the variable x
x #Displays the values we have set in x

#NB R is Case sensitive Y is not the same of y

y <- c(6,7,8,9,10) #puts numbers between 6-10 in y
y
#Short cut for <- is alt+-
### Assign the same value to multiple vectors---------------
a <- b <- c <- 3


## Vector math ================
x+y #sum the x sequence plus the y sequence
x*2 #multiply for 2 each number in x

#To remove variables from the environment
rm(x) #Remove an object from the workspace
rm (a, b) #Remove more than one
rm (list = ls()) #Remove everything

#INSTALLING PACKAGES ###################
#list of packages available by subject
browseURL("https://cran.r-project.org/web/views/")

#list of packages available by name
browseURL("https://cran.r-project.org/web/packages/available_packages_by_name.html")

## See current packages ==========================
library()#List the available ones
search()#List the ready to go ones 

## Install packages ==========================
#you can use: tools>Install packages
#or directly
install.packages("tidyverse")
?install.packages

## Activate packages ==========================
library(tidyverse)

## Check for updates ==========================
#tools>check for updates
update.packages()

## To unload packages ==========================
#unflag or reboot (everytime you close the system the non default packages get unloaded)
detach ("package:tidyverse", unload = TRUE)

## To Remove packages ==========================
#x in the packages windows 
remove.packages("nameofthepackage")

# DATA STRUCTURE ######################

#Vector ==============================================
#One dimentional collection of data
y <- c(6,7,8,9,10)
is.vector(y)

x <- c("b","d","a","f","h")
is.vector(x)

#Matrix==============================================
#bidimential collection of data
m1 <- matrix(c(T, T, F, F, T, F), nrow = 2)
m1

m2 <- matrix(c("a", "b", 
               "c", "d"), 
             nrow = 2,
             byrow = T)
m2

#A matrix has data all of the same type

m3 <- matrix(c(1, "b", 
               "c", "d"), 
             nrow = 2,
             byrow = T)
m3
## Array more than 2 dimentsions===================================
#multidimentional collection of data 
# Give data, then dimensions (rows, columns, tables)
a1 <- array(c( 1:24), c(4, 3, 2))
a1

## Data Frame ==============================================

# Can combine vectors of the same length
#different type variables (similar to a table in spreadsheet)
vNumeric   <- c(1, 2, 3)
vCharacter <- c("a", "b", "c")
vLogical   <- c(T, F, T)

df1 <- cbind(vNumeric, vCharacter, vLogical)
df1  # Coerces all values to most basic data type

df2 <- as.data.frame(cbind(vNumeric, vCharacter, vLogical))
df2  # Makes a data frame with three different data types


# Clear environment
rm(list = ls()) 

# Clear console
cat("\014")  # ctrl+L


# IMPORTING DATA ##############################

#Using embedded datasets
#No need to import anything you just use it 
iris


library(tidyverse)
# Import CSV files with readr::read_csv() from tidyverse
Books<- read_csv("data/BooksB.csv")
IrisNull <- read_csv("data/IrisNulls.csv")

# Import CSV files and modify the form and names of variables
df3 <- read_csv("data/IrisNulls.csv") %>%
  select(Sepal.Length,Sepal.Width,Species) %>% 
  mutate(Species = as.factor(Species)) %>%
  rename(SepalLength = Sepal.Length) %>%
  print(df3)

# Import CSV files from online repo
college <- read_csv('http://672258.youcanlearnit.net/college.csv')
college <- college %>%
  mutate(state=as.factor(state), region=as.factor(region),
         highest_degree=as.factor(highest_degree),
         control=as.factor(control), gender=as.factor(gender),
         loan_default_rate=as.numeric(loan_default_rate))


##The Grammar of Graphics==========================
###Level 1 Data --------------------------
iris
###Level 2 and 3 aesthetics and Geometries --------------------------
ggplot(iris, aes(x=Petal.Length, y=Petal.Width)) + geom_point()

###Level 2 aesthetics: use a third variable to color code --------------------------
ggplot(iris, aes(x=Petal.Length, y=Petal.Width, colour=Species)) + geom_point()

###Level 2 aesthetics: use a forth variable to set the size of the dots --------------------------
ggplot(iris, aes(x=Petal.Length, y=Petal.Width, color=Species, size=Sepal.Width, alpha=Sepal.Width)) + geom_point()

###Level 3 geometry: increase the size of all dots --------------------------
ggplot(iris, aes(x=Petal.Length, y=Petal.Width, color=Species)) + geom_point(size=4, alpha=0.5)

###Level 4 faceting: Subdivide the visualisation in subplots --------------------------
ggplot(iris, aes(x=Petal.Length, y=Petal.Width, color=Species)) + geom_point(size=4, alpha=0.5)+facet_wrap(~Species)

###Level 4 faceting: Subdivide the visualisation in subplots according to 2 variables --------------------------
ggplot(iris, aes(x=Petal.Length, y=Petal.Width, color=Species, size=Sepal.Width)) + geom_point()+facet_grid(Petal.Width~Species)

###Level 5 Statistics: plot summ stats instead of the data --------------------------
ggplot(iris, aes(x=Petal.Length, y=Petal.Width)) + stat_summary_bin(fun="mean", geom = "bar")

###Level 6 Coordinates: attributes of the coordinate axis --------------------------
ggplot(iris, aes(x=Petal.Length, y=Petal.Width, color=Species, size=Sepal.Width)) + geom_point()+facet_wrap(~Species)+coord_polar()

###Level 7 Themes: change the global setting of the charts --------------------------
ggplot(iris, aes(x=Petal.Length, y=Petal.Width, color=Species, size=Sepal.Width)) + geom_point()+theme_bw()


ggplot(iris, aes(x=Petal.Length, y=Petal.Width, color=Species, size=Sepal.Width)) + geom_point()+theme_bw() + labs(title = "New plot title", subtitle = "A subtitle", caption = "(based on data from ... N= 500)", x = "Petal Length", y= "New y label", color = "Colours")

#EXPLORING DISTRIBUTION##############
#Histogram=========================
ggplot(iris, aes(x=Petal.Width, fill=Species))+ 
  geom_histogram(alpha=0.8,color="black", binwidth=sd(iris$Petal.Width)/10)+
  geom_vline(aes(xintercept = mean(Petal.Width)),col='red',size=2)+
  theme_bw()+facet_wrap(~Species, ncol = 1)

#+facet_wrap(~species, ncol = 1) 
#Using the subplot mean values to plot the differences
ggplot(iris, aes(x=Petal.Width, fill=Species)) + 
  geom_histogram(alpha=0.8, color="black", binwidth=0.08)+
  geom_vline(data=filter(iris, Species=="setosa"),aes(xintercept = mean(Petal.Width)),col='red',size=2)+
  geom_vline(data=filter(iris, Species=="versicolor"),aes(xintercept = mean(Petal.Width)),col='green',size=2)+
  geom_vline(data=filter(iris, Species=="virginica"),aes(xintercept = mean(Petal.Width)),col='blue',size=2)+
  theme_bw()+
  facet_wrap(~Species, ncol = 1) 

Setosa<- subset(iris,Species=="setosa")


#Density plot======================================
ggplot(iris, aes(x=Petal.Width, fill=Species))+ 
  geom_density(alpha = 0.5)+
  geom_vline(aes(xintercept = mean(Petal.Width)),col='red',size=2)+
  theme_bw()

#, fill=Species +facet_wrap(~Species, ncol = 1) 

#BOXPLOT##########
#Boxplots are an other way to visualise summarising statistic of the dataset breaked out according to a categorical value 

#Let's get back to our iris dataset
##Subsetting the sample to see the difference across a categorical values

virginica <- subset(iris, Species=="virginica")
versicolor <- subset(iris, Species=="versicolor")
setosa <- subset(iris, Species=="setosa")

#Now lets calculate again and compare 
#Values of Virginica
mean(virginica$Petal.Width)
median(virginica$Petal.Width)
var(virginica$Petal.Width)
sd (virginica$Petal.Width)

#Values of versicolor
mean(versicolor$Petal.Width)
median(versicolor$Petal.Width)
var(versicolor$Petal.Width)
sd (versicolor$Petal.Width)

#Values of setosa
mean(setosa$Petal.Width)
median(setosa$Petal.Width)
var(setosa$Petal.Width)
sd (setosa$Petal.Width)


ggplot(iris, aes(x=Petal.Width, fill=Species)) + 
  geom_histogram(alpha=0.8, color="black", binwidth=0.08)+
  geom_vline(data=filter(iris, Species=="setosa"),aes(xintercept = mean(Petal.Width)),col='red',size=2)+
  geom_vline(data=filter(iris, Species=="versicolor"),aes(xintercept = mean(Petal.Width)),col='green',size=2)+
  geom_vline(data=filter(iris, Species=="virginica"),aes(xintercept = mean(Petal.Width)),col='blue',size=2)+
  theme_bw()+
  facet_wrap(~Species, ncol = 1) 

#an other way to visualise it is using the Boxplot 
ggplot(iris, aes(x=Species, y=Petal.Width)) + 
  geom_boxplot()+
  theme_bw()

#adding some color-coded info 
ggplot(iris, aes(x=Species, y=Petal.Width, fill=Species)) + 
  geom_boxplot()+
  theme_bw()

#you can also have a multilayered representation by plotting also the single observations
ggplot(iris, aes(x=Species, y=Petal.Width, color=Species)) + 
  geom_boxplot(outlier.color = "black")+
  geom_jitter(alpha =0.3)+
  theme_bw()

#removing the outliers from graph cause they can be confusing
ggplot(iris, aes(x=Species, y=Petal.Width, color=Species)) + 
  geom_boxplot(outlier.alpha = 0)+
  geom_jitter(size= 4, alpha =0.3)+
  theme_bw()


#what if I want to plot the mean too
means <- aggregate(Petal.Width ~ Species, iris, mean)

ggplot(iris, aes(x=Species, y=Petal.Width, color=Species)) + 
  geom_boxplot()+
  theme_bw()+
  stat_summary(fun=mean, colour="darkred", geom="point", 
               shape=18, size=3,show.legend = FALSE) + 
  geom_text(data = means, aes(label = Petal.Width, y = Petal.Width + 0.08))


#EXPLORING RATIO ################
# THE PROBLEM WITH PIE CHARTS
# Three data sets
pie.a <- c(22, 14, 18, 20, 14, 12)
pie.b <- c(20, 18, 16, 18, 16, 12)
pie.c <- c(12, 14, 20, 18, 14, 22)

# Changing graphical parameters for a minute
oldpar <- par()   # Stores old graphical parameters
par(mfrow    = c(1, 3),  # Num. rows/cols
    cex.main = 3)   #  Main title 3x bigger
colors <- c("grey98", "grey90", "lightskyblue", "lightgreen", "grey98", "grey90")
?colors

# Three pie charts side by side
# Is the green slice or blue slice bigger?
pie(pie.a, main = "Pie A", col = colors)
pie(pie.b, main = "Pie B", col = colors)
pie(pie.c, main = "Pie C", col = colors)

# Three bar charts side by side
# Is the green bar or blue bar bigger?
barplot(pie.a, main = "Bar A", col = colors)
barplot(pie.b, main = "Bar B", col = colors)
barplot(pie.c, main = "Bar C", col = colors)

#BARCHARTS#############
#Grouped, stacked and percent stacked barplot==========
#Dataset
Books <- read_csv("data/BooksB.csv")
#Modify a little bit the dataset
BooksR <- subset(Books, Pages>30 & Pages<500)

#Check the Type ad Type of Binging in relation to the weight
ggplot(BooksR, aes(fill=Binding, y=Weight, x=Type)) + 
  geom_bar(position="dodge", stat="identity")+theme_bw()
#Make it stacked
ggplot(BooksR, aes(fill=Binding, y=Weight, x=Type)) + 
  geom_bar(position="Stack", stat="identity")+theme_bw()
#Using percentage
ggplot(BooksR, aes(fill=Binding, y=Weight, x=Type)) + 
  geom_bar(position="fill", stat="identity")+theme_bw()

#Using the counts
ggplot(BooksR, aes(x=Type, fill=Binding))+ 
  geom_bar()+theme_bw()

#Add labels count
ggplot(BooksR, aes(x=factor(Type), fill=Type)) + 
  geom_bar(position="dodge")+
  geom_text(aes(label=stat(count)),stat='count',  nudge_y=-20, color="white")+theme_bw()

#Using the percentage for categorical variable
#Percentage for bar
ggplot(BooksR, aes(x=factor(Type), fill=Binding)) + 
  geom_bar(aes(y = (..count..)/sum(..count..)), position="fill")+theme_bw()+ scale_y_continuous(labels = scales::percent)+ labs(y="Percentage by Novel types", x="Type")

#Total percentage
ggplot(BooksR, aes(x=factor(Type), fill=Binding)) + 
  geom_bar(aes(y = (..count..)/sum(..count..)))+theme_bw()+ scale_y_continuous(labels = scales::percent)+ labs(y="Percentage books", x="Type")


#Adding legend
ggplot(BooksR, aes(x=factor(Type), fill=Type)) + 
  geom_bar(aes(y = (..count..)/sum(..count..)))+
  theme_bw()+ 
  scale_y_continuous(labels = scales::percent)+ labs(y="Percentage books", x="Type")+
  geom_text(aes(y = ((..count..)/sum(..count..)),label=scales::percent((..count..)/sum(..count..))), stat = "count", color="black", vjust = -0.25)

#Treemap =====================
install.packages("treemapify")
library(treemapify)

#Extract the information I want 
BreakoutRegion<-  college %>% 
  group_by(region, state) %>% 
  summarize(Number = n())%>%
  arrange(desc(Number))

#Create a new column that will collect both book type and number
BreakoutRegion$Label = paste0(BreakoutRegion$state," ","(",BreakoutRegion$Number,")")

#Plot it with treemapify
ggplot(BreakoutRegion, aes(area = Number, fill = region, label=Label, subgroup=state)) + 
  geom_treemap(color="black")+ #it will not work without the treemapify
  geom_treemap_subgroup_border(color="black")+ #border the group in black
  geom_treemap_text(colour = "black", place = "centre", reflow = T)+
  theme()+ #I do not need a legend 
  guides(alpha=TRUE)+
  labs(caption= "(N = 1269)")

#RELATIONSHIPS#############
#Scatterplot======
#we already see it before 


###Heatmap=====================
ggplot(college, aes(x=control, y=region))+ geom_bin2d(colour="black") +theme_bw()

#plot
p <-ggplot(college, aes(x=control, y=region))+ geom_bin2d(colour="black") +theme_bw()

p
#Add the information 

# Get data from the plot created (save the results as a new dataframe)
newdata <- ggplot_build(p)$data[[1]]

# add in text labels
p + geom_text(data=newdata, aes((xmin + xmax)/2, (ymin + ymax)/2, 
                                label=count), col="white")


#Network Graph 
#We need some more package 
install.packages("sna")
library(GGally)
library(network)
library(sna)

# random graph
net = rgraph(10, mode = "graph", tprob = 0.5)
net = network(net, directed = FALSE)

# vertex names
network.vertex.names(net) = letters[1:10]

#Lets plot it 
ggnet2(net)

#Modify the main values
ggnet2(net, node.size = 8, node.color = "black", edge.size = 1, edge.color = "red")

#Way of display the network
ggnet2(net, mode = "fruchtermanreingold", layout.par = list(cell.jitter = 0.75))

ggnet2(net, mode = "target", layout.par = list(niter = 100))

#Define if it contain vowels or consonants
net %v% "phono" = ifelse(letters[1:10] %in% c("a", "e", "i"), "vowel", "consonant")
ggnet2(net, color = "phono")

#Set nicer colours
net %v% "colour" = ifelse(net %v% "phono" == "vowel", "blue", "green")
ggnet2(net, color = "colour")

#Change Size
ggnet2(net, size = "phono",color = "colour", size.palette = c("vowel" = 10, "consonant" = 5))

ggnet2(net, label = TRUE, size = "phono",color = "colour", size.palette = c("vowel" = 10, "consonant" = 5))


#PLOT CHANGE############
# create data
xValue <- 1:10
yValue <- cumsum(rnorm(10))
data <- data.frame(xValue,yValue)

# Plot
ggplot(data, aes(x=xValue, y=yValue)) +
  geom_line()+theme_bw()


#Define line type and colour and title
ggplot(data, aes(x=xValue, y=yValue)) +
  geom_line( color="red", size=2, alpha=0.9, linetype=2) +
  theme_bw() +
  ggtitle("Random Evolution")

#Add single observations
ggplot(data, aes(x=xValue, y=yValue)) +
  geom_line( color="red", size=2, alpha=0.9, linetype=2) +
  geom_point(color="blue", size= 6)+
  theme_bw() +
  ggtitle("Random Evolution")

#Streamgraph==================
# Library
install.packages("devtools")
library(devtools)
devtools::install_github("hrbrmstr/streamgraph")
library(streamgraph)
install.packages("babynames")
library(babynames)

# Create data:
data <- babynames %>% 
  filter(name %in% c("Ashley", "Amanda", "Jessica",    "Patricia", "Linda", "Deborah",   "Dorothy", "Betty", "Helen")) %>%
  filter(sex=="F")


# Basic stream graph: just give the 3 arguments
streamgraph(data, key="name", value="n", date="year", height="300px", width="1000px")



# SOME MORE NICE GRAPHS OPTIONS

#dataset 
college <- read_csv('http://672258.youcanlearnit.net/college.csv')
college <- college %>%
  mutate(state=as.factor(state), region=as.factor(region),
         highest_degree=as.factor(highest_degree),
         control=as.factor(control), gender=as.factor(gender),
         loan_default_rate=as.numeric(loan_default_rate))

##Visualise the density on 2 numerical variables=======
#using +geom_density_2d() to convey to highlight the distribution
#basically is performing a 2d version of the density plot we were looking at for single variables last week

ggplot(college, aes(x=sat_avg, y=admission_rate, color=region)) + geom_point(alpha=0.5)+theme_bw()+facet_wrap(~region)+ geom_density_2d()

#use density 
ggplot(college, aes(x=sat_avg, y=admission_rate, color=region))  +theme_bw()+facet_wrap(~region)+ stat_density_2d(aes(fill = ..level..), geom = "polygon")

#Hexbin
install.packages("hexbin")
library(hexbin)
ggplot(college, aes(x=sat_avg, y=admission_rate) ) +
  geom_hex(bins = 25) +
  scale_fill_continuous(type = "viridis") +
  theme_bw()+facet_wrap(~region)

##Assessing the incidence of the subplots =======
###Bubble Graph----------
#when you analyse the sample you need to assess also how many data you have for each cluster of analysis (i.e. our species)
ggplot(college, aes(x=region, y=control, color=region))+ geom_count() +theme_bw()

ggplot(college, aes(x=region, y=state, color=region))+ geom_count() +theme_bw()

#COSTUMISE YOUR GRAPH 

#Order your results###########
#Order result for specific graph
p <- ggplot(BooksR, aes(x=factor(Type), fill=Type)) + 
  geom_bar()+
  geom_text(aes(label=stat(count)),stat='count',  nudge_y=-20, color="white", size=5)
p
p + scale_x_discrete(limits=c("Romance", "Short Stories", "Noir"))

#Order result for all dataset=========================
#If I replot it 
p
ggplot(BooksR, aes(x=factor(Type), fill=Type)) + 
  geom_bar()+
  geom_text(aes(label=stat(count)),stat='count',  nudge_y=-20, color="white")


#Make sure the variable is recognise as factor---------------
newBooks <- BooksR %>% 
  mutate(Type = as.factor(Type))
# Examine levels
newBooks %>% 
  pull(Type) %>% 
  levels()
#Let's check
levels(newBooks$Type)
levels(BooksR$Type)

#Reorder---------------
newBooks$Type <- factor(newBooks$Type, levels(newBooks$Type)[c(2,3,1)])
#New plot version--------------
ggplot(newBooks, aes(x=factor(Type), fill=Type)) + 
  geom_bar()+
  geom_text(aes(label=stat(count)),stat='count',  nudge_y=-20, color="white")

#let's play with the colours ###################
#using palettes
means <- aggregate(Petal.Width ~ Species, iris, mean)
ggplot(iris, aes(x=Species, y=Petal.Width, color=Species)) + 
  geom_boxplot(outlier.alpha = 0)+
  geom_jitter(size= 3, alpha =0.3)+
  theme_bw()+
  stat_summary(fun=mean, colour="darkred", geom="point", 
               shape=18, size=3,show.legend = FALSE) + 
  geom_text(data = means, aes(label = Petal.Width, y = Petal.Width + 0.08))+
  scale_color_brewer(palette="Spectral")#you need to use a scale_fill_brewer if the colours you are using are in the fill comand 
?scale_color_brewer
#in this case you shall use scale_fill_brewer because the color coded comand is fill and not colour
ggplot(iris, aes(x=Petal.Width, fill=Species)) + 
  geom_histogram(alpha=0.8, color="black", binwidth=0.08)+
  facet_wrap(~Species, ncol = 1)+
  scale_fill_brewer(palette="Dark2") 

#More palettes: wesanderson Palette
install.packages("wesanderson")
library(wesanderson)

ggplot(iris, aes(x=Species, y=Petal.Width, color=Species)) + 
  geom_boxplot(outlier.alpha = 0)+
  geom_jitter(size= 3, alpha =0.3)+
  theme_bw()+
  stat_summary(fun=mean, colour="darkred", geom="point", 
               shape=18, size=3,show.legend = FALSE) + 
  geom_text(data = means, aes(label = Petal.Width, y = Petal.Width + 0.08))+
  scale_color_manual(values = wes_palette("BottleRocket2", n = 3))

#many other palettes available 
browseURL("https://www.datanovia.com/en/blog/top-r-color-palettes-to-know-for-great-data-visualization/")

#Print in Black and white [aes(shape=Species),]
ggplot(iris, aes(x=Species, y=Petal.Width, fill=Species)) + 
  geom_boxplot(outlier.alpha = 0)+
  theme_bw()+
  stat_summary(fun=mean, colour="black", geom="point", 
               shape=18, size=3,show.legend = FALSE) + 
  geom_text(data = means,colour="black", aes(label = Petal.Width, y = Petal.Width + 0.08))+
  scale_fill_grey(start = 0.8, end = 0.4) 

#Manually select colors 
ggplot(iris, aes(x=Species, y=Petal.Width, color=Species)) + 
  geom_boxplot(outlier.alpha = 0)+
  geom_jitter(size= 3, alpha =0.3)+
  theme_bw()+
  stat_summary(fun=mean, colour="black", geom="point", 
               shape=18, size=3,show.legend = FALSE) + 
  geom_text(data = means,colour= "black", aes(label = Petal.Width, y = Petal.Width + 0.08))+
  scale_color_manual(values=c("#80ec65", "#10ea31", "#700015"))

browseURL("https://www.hexcolortool.com/")

#Use gradients
ggplot(iris, aes(x=Petal.Length, y=Petal.Width, color=Species)) + geom_point(size=3)+theme_bw()

ggplot(iris, aes(x=Petal.Length, y=Petal.Width, color=Sepal.Width, shape=Species)) + geom_point(size=4, alpha=0.8)+
  scale_color_gradientn(colours = rainbow(7))+
  theme_dark()

#Remove null values##########
IrisNull <- read.csv("Data\\IrisNulls.csv")
#compute the mean----------------
mean(IrisNull$Petal.Length)
#clean the whole sample--------------------
IrisCleaned<- na.omit(IrisNull)
#re compute on the cleaned sample-----------------
mean(IrisCleaned$Petal.Length)
mean(IrisCleaned$Petal.Width)
#Clean single columns-------------------
IrisCleaned2<- IrisNull[!(is.na(IrisNull$Petal.Length) | IrisNull$Petal.Length==""), ]
#calculate mean again--------------------
mean(IrisCleaned$Petal.Length)
mean(IrisCleaned2$Petal.Length)

#Change scale of Graphs axis######################

#Initial graph--------------------
Mygraph <- ggplot(iris, aes(x=Petal.Length, y=Petal.Width, color=Species)) + geom_point(size=6, alpha=0.5)+theme_bw()+ labs(title = "Iris", subtitle = "Relationship between Petal Lengh and Petal Width", x = "Petal Length", y= "Petal Width")
Mygraph
#Define limits axis--------------
Mygraph +xlim(0, 10)+ylim(0, 3)
#Define limits and set intercept of X and Y----------------
Mygraph +expand_limits(x=c(0,10), y=c(0, 3))
#Plot in the log scale---------------------
Mygraph + coord_trans(x="log10", y="log10")

#Change unit of measurment---------------------------
ggplot(iris, aes(x=Petal.Length/2.54, y=Petal.Width/2.54, color=Species)) + geom_point(size=6, alpha=0.5)+theme_bw()+ labs(title = "Iris", subtitle = "Relationship between Petal Lengh and Petal Width", x = "Petal Length (Inches)", y= "Petal Width(Inches)")+expand_limits(x=c(0,3), y=c(0,1.5))

#Set the thicks in the grid--------------------------
ggplot(iris, aes(x=Petal.Length/2.54, y=Petal.Width/2.54, color=Species)) + geom_point(size=6, alpha=0.5)+theme_bw()+ labs(title = "Iris", subtitle = "Relationship between Petal Lengh and Petal Width", x = "Petal Length (Inches)", y= "Petal Width(Inches)")+expand_limits(x=c(0,3), y=c(0,1.5))+
  scale_x_continuous(minor_breaks = seq(0,4, 1), breaks = seq(0,4,2))+ scale_y_continuous(minor_breaks = seq(0,2, 0.25), breaks = seq(0,2,0.5))

#EXPORT GRAPHS########
ggsave(filename='Figure1.tiff', dpi=600, path='graph')
#THE END 