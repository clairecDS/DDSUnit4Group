require(gdata)
require(plyr)
install.packages("plyr")# install packages
install.packages("gdata")# install packages
library(plyr)# load package
library(gdata) # load package

list.files(path = "C:/Users/Marvin/Documents/DDSUnit4Group/Analysis" )

bk <- read.csv("rollingsales_queens.csv",skip=4,header=TRUE)  #read/assign csv file after saving to directory

head(bk) #observe top six records 
summary(bk) #observe data summary
str(bk) #observe varaible data types and values

bk$SALE.PRICE.N <- as.numeric(gsub("[^[:digit:]]","", bk$SALE.PRICE)) #New variable created as numeric

count(is.na(bk$SALE.PRICE.N)) #count NAs and non NAs 


names(bk) <- tolower(names(bk)) # make all variable names lower case

bk$gross.sqft <- as.numeric(gsub("[^[:digit:]]","", bk$gross.square.feet)) ## convert to numeric and get rid of leading digits
bk$land.sqft <- as.numeric(gsub("[^[:digit:]]","", bk$land.square.feet))  ## convert to numeric and get rid of leading digits

bk.sale <- bk[bk$sale.price.n!=0,] #remove any "0" values
plot(bk.sale$gross.sqft,bk.sale$sale.price.n)#plot of x-gross.sqft,y-sale.price.n, (outliers exist on both variables)
plot(log10(bk.sale$gross.sqft),log10(bk.sale$sale.price.n)) #log transformation plot


plot(bk.sale$land.sqft,bk.sale$sale.price.n)#plot of x-gross.sqft,y-sale.price.n, (outliers exist on both variables)
plot(log10(bk.sale$land.sqft),log10(bk.sale$sale.price.n)) #log transformation plot

sessionInfo()