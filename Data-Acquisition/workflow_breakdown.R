##### Example Workflow for accessing environmental data at certain coordinates #####
### By Thomas Carlin
### tom.carlin@scionresearch.com
### 24/09/21
###
### Requires: A coordinate dataset
### Required Libraries: elevatr, raster, rgdal
### Outputs: csv file that contains coordinates along with associated environmental data


##### Preparing for analysis #####

# Set a relevant working directory. Note that this example working directory may need updating if files have been moved.0
setwd("Q:/Tree Root Microbiome/RA 3  Characterising the soil environment/Projects/Envirotyping data")

# Source relevant functions
source("functions.R") # Contains climate(), elevation(), soil(), and environs()

# Read in dataset - can open csv or txt files easily. Excel files can be read in, but it is simpler to save them as csv.
data <- read.csv("test_data.csv") # read.csv() is a version of read.table() for reading in .csv files.
# data <- read.delim("test_data.txt") # read.delim() is a version of read.table() for reading in .txt files.

# Look at the data (can also click on the object in the global environment)
View(data)

# (Optional) Create rownames (only relevant if you have a "names" column)
coords <- data[,2:3]
rownames(coords) <- data[,1]
View(coords)

##### Getting environmental data #####
results <- environs(coords)
View(results)

##### Saving data outside of R #####
# Saving results as a csv
write.csv(results,"test_results.csv")

# Saving R environment (all objects currently in R) for later use (only recommended if necessary)
save.image()

##### Individual Functions + Plotting #####
# Elevation
elev_dat <- elevation(coords[10:12,], plot=TRUE)

# Soil
par(mfrow=c(1,1)) # This line resets the plotting window to display 1 plot per row and column, whereas the elevation function plots 3 plots per row
soil_dat <- soil(coords[6:9,],plot=T)

# Climate
clim_dat <- climate(coords[7,],plot=TRUE)

#########################################################
##### Function Breakdown + Modifying for your needs #####
#########################################################
### The following code breaks down the functions and highlight how you can dissect/modify them to your needs ###

### Elevation ###

# First we need to load in the relevant libraries
# library(elevatr)
# library(raster)
# library(rgdal)

# Load in Data
dat1 <- read.csv("test_data.csv")
dat1 <- dat1[,2:3] # remove names column (as an alternative to converting them to rownames)

# Define a coordinate system
prj_ <- CRS("+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs")

# Convert our coodinates data into "SpatialPoints" by assigning the coordinate system to them
dat2 <- SpatialPoints(dat1, proj4string = prj_)

# Define coordinate system "shorthand" for easier placement into later code
prj_dd <- "+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs"

## The following lines only consider 1 coordinate point, whereas the elevation() function applies a "for loop" to this.

# Use elevatr package to get elevation data.
elev <- get_elev_raster(dat1[1,], prj = prj_dd, z = 7) # Download elevation data
slop <- terrain(elev, opt=c('slope', 'aspect'), unit='degrees') # Calculate Slope and Aspect values
stack <- stack(elev, slop[[1]],slop[[2]]) # Stack the rasters to make extraction easier
  
extdat <- extract(stack, dat2[1]) # Extract the data from the raster stack at each spatial point
dat1[1,c(3:5)] <- extdat # Insert the extracted data alongside our original coordinates

par(mfrow=c(1,3)) # Change plot window to plot all 3 rasters on one figure
plot(elev, main="Elevation") 
points(dat1[1,1:2])
plot(slop[[1]], main="Slope")
points(dat1[1,1:2])
plot(slop[[2]], main="Aspect")
points(dat1[1,1:2])

colnames(dat1) <- c("lon","lat","Elevation","Slope","Aspect") # Change column names for easier identification

### Climate ### 

# Load in required libraries
# library(raster)

# Load in data
dat <- read.csv("test_data.csv")
dat <- dat[,2:3] # remove names column (as an alternative to converting them to rownames)

# Define a coordinate system and convert coordinates to SpatialPoints
prj_ <- CRS("+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs")
dat2 <- SpatialPoints(dat, proj4string = prj_)

## The following lines only consider 1 coordinate point, whereas the elevation() function applies a "for loop" to this.

# Download climate data into a raster stack
clim_stack <- getData('worldclim', var='bio', res=0.5, lon=dat[1,1], lat=dat[1,2], path='Q:/Tree Root Microbiome/RA 3  Characterising the soil environment/Projects/Envirotyping data/worldclim 0.5') # Resolution here is 30 arcseconds

# Extract data from rasters at spatial points
extdat <- extract(clim_stack, dat2[1])

# Insert the extracted data alongside our original coordinates
dat[2,c(3:21)] <- extdat

# Plot ALL climate variables
plot(clim_stack, main=c('MeanTemp','DayRange','Isotherm','TempSeason','MaxTemp','MinTemp','YrRange','MeanTempWet','MeanTempDry','MeanWarmTemp','MeanColdTemp','Precip','PrecipWetMo','PrecipDryMo','PrecipSeason','PrecipWetQ','PrecipDryQ','PrecipWarmQ','PrecipColdQ'))

# Or plot specific climate variables by specifying with [[]]
plot(clim_stack[[1]], main=c('MeanTemp'))
plot(clim_stack[[18]], main=c('PrecipWarmQ'))

# You can also restrict the plotting space to focus on an area
plot(clim_stack[[19]], main=c('PrecipColdQ'), xlim=c(165,180), ylim=c(-47,-34))


colnames(dat) <- c('lon','lat','MeanTemp','DayRange','Isotherm','TempSeason','MaxTemp'
                   ,'MinTemp','YrRange','MeanTempWet','MeanTempDry','MeanWarmTemp','MeanColdTemp','Precip'
                   ,'PrecipWetMo','PrecipDryMo','PrecipSeason','PrecipWetQ'
                   ,'PrecipDryQ','PrecipWarmQ','PrecipColdQ')

## Climate data needs "correcting" as it is stored without decimal points to save memory.
dat[,c(3,7,8,10:13)] <- dat[,c(3,7,8,10:13)]/10 ### Convert Temperature data into celsius (currently celsius*10)
dat[,6] <- dat[,6]/100 ### Convert temperature seasonality value in sd of mean temp values

### Soil ###

### Load required libraries
library(raster)

dat <- read.csv("test_data.csv")
dat <- dat[,2:3] # remove names column (as an alternative to converting them to rownames)

  ### Load in world reference base soil map
  soil_map <- raster("wrb.tif")
  
  ### Pull soil attributes, set projection of points and converts points to spatialpoints
  sol <- as.character(soil_map@data@attributes[[1]][["RSG"]])
  prj_ <- CRS("EPSG:4326")
  dat2 <- SpatialPoints(dat, proj4string = prj_)
  
  ### Plot points on map
    plot(soil_map)
    points(dat)

  ### Extract value of raster at points
  extdat <- extract(soil_map, dat2)
  dat[,3] <- extdat
  
  ### Assign correct soil names to factor classes, given numeric position in list
  dat$Soil <- sol[dat[,3]+1] #Need to add +1 as the list of numbers starts at 0, but list of names starts at 1.
  dat <- dat[,c(1,2,4)] # Remove unnecessary column