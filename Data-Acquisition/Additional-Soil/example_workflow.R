##### Example Workflow for accessing soil data at any given global coordinates #####
### By Thomas Carlin
### 1/10/21
###
### Requires: A coordinate dataset
### Required Libraries: raster
### Outputs: csv file that contains coordinates along with associated soil data

#### Note
### Possible argument options are:
### depth= "all"/"0-5"/"5-15"/"15-30"/"30-60"/"60-100"/"100-200"
### uncertainty= T/F

setwd("Q:/Tree Root Microbiome/RA 3  Characterising the soil environment/Projects/Envirotyping data/Global Soil Data/R_scripts")

dat <- read.csv("testdat.csv")

x <- dat[2:3,] # This line will select only 2 rows of the data (the 2nd and 3rd) to make the code run faster

y <- soildat(x, depth="0-5")
View(y)

z <- soildat(x, depth="15-30")
View(z)

a <- soildat(x, depth="100-200", uncertainty = T)
View(a)

c <- soildat(dat)
d <- soildat(dat,uncertainty=T)

write.csv(d,file="example_output.csv")

