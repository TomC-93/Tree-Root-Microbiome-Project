## Thomas Carlin  
### Downloading Soil data and creating a usable tif file.

################
#     NOTE     #
################
## Before this R script can be run you MUST install gdal software onto your computer.
## You can find gdal software from a number of locations, however I recommend:
## https://trac.osgeo.org/osgeo4w/
## Simply follow the instructions, ensure you tick the box next to gdal when installing, and the following R code will run.

library(rgdal)
library(gdalUtils)

### The following command downloads soil data directly into your working directory

## The resolution of data can be changed by altering the tr=c(0.01,0.01) argument, where smaller numbers are finer resolution and larger numbers are coarser resolution.

### Resolution of 0.01 is ~ 1km
gdalwarp(t_srs="EPSG:4326", multi=TRUE, wm=200, 
         co=c("BIGTIFF=YES", "COMPRESS=DEFLATE", "TILED=TRUE"),
         tr=c(0.01,0.01), # Desired output resolution
         verbose=T,
         "/vsicurl?max_retry=3&retry_delay=1&list_dir=no&url=https://files.isric.org/soilgrids/latest/data/wrb/MostProbable.vrt", # Input VRT
         "wrb4.tif") # Output file


##### We can check the data

soil_map <- raster("wrb4.tif")
plot(soil_map)

sol <- as.character(soil_map@data@attributes[[1]][["RSG"]])

### Now check we can extract data 

dat <- read.csv("test_dat.csv")
prj_ <- CRS("EPSG:4326")
dat2 <- SpatialPoints(dat, proj4string = prj_)
prj_dd <- "+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs"
points(dat)

extdat <- extract(soil_map, dat2)
dat[,3] <- extdat
dat$Soil <- sol[dat[,3]+1] #Need to add +1 as the list of numbers starts at 0, but list of names starts at 1.
data <- dat[,c(1,2,4)] 
