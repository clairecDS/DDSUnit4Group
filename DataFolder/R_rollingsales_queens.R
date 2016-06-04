# Author: Benjamin Reddy
# Taken from pages 49-50 of O'Neil and Schutt

# changed bk to qn for the queens data - Jean Jecha

require(gdata)
require(plyr) #Added by Monnie McGee
#install the gdata and plyr packages and load in to R.
library(plyr)
library(gdata)
setwd("/Users/jeanjecha/dropbox/Unit4LiveSessionHomework")

## You need a perl interpreter to do this on Windows.
## It's automatic in Mac
## bk <- read.xls("rollingsales_brooklyn.xls",pattern="BOROUGH")

# So, save the file as a csv and use read.csv instead
qn <- read.csv("rollingsales_queens.csv",skip=4,header=TRUE)

## Check the data
head(qn)
summary(qn)
str(qn) # Very handy function!

## clean/format the data with regular expressions
## More on these later. For now, know that the
## pattern "[^[:digit:]]" refers to members of the variable name that
## start with digits. We use the gsub command to replace them with a blank space.
# We create a new variable that is a "clean' version of sale.price.
# And sale.price.n is numeric, not a factor.
qn$SALE.PRICE.N <- as.numeric(gsub("[^[:digit:]]","", qn$SALE.PRICE))
count(is.na(qn$SALE.PRICE.N))

names(qn) <- tolower(names(qn)) # make all variable names lower case
## Get rid of leading digits
qn$gross.sqft <- as.numeric(gsub("[^[:digit:]]","", qn$gross.square.feet))
qn$land.sqft <- as.numeric(gsub("[^[:digit:]]","", qn$land.square.feet))
qn$year.built <- as.numeric(as.character(qn$year.built))

## do a bit of exploration to make sure there's not anything
## weird going on with sale prices
attach(qn)
hist(sale.price.n) 
detach(qn)

## keep only the actual sales

qn.sale <- qn[qn$sale.price.n!=0,]
plot(qn.sale$gross.sqft,qn.sale$sale.price.n)
plot(log10(qn.sale$gross.sqft),log10(qn.sale$sale.price.n))

## for now, let's look at 1-, 2-, and 3-family homes
qn.homes <- qn.sale[which(grepl("FAMILY",qn.sale$building.class.category)),]
dim(qn.homes)
plot(log10(qn.homes$gross.sqft),log10(qn.homes$sale.price.n))
summary(qn.homes[which(qn.homes$sale.price.n<100000),])


## remove outliers that seem like they weren't actual sales
qn.homes$outliers <- (log10(qn.homes$sale.price.n) <=5) + 0
qn.homes <- qn.homes[which(qn.homes$outliers==0),]
plot(log(qn.homes$gross.sqft),log(qn.homes$sale.price.n))


