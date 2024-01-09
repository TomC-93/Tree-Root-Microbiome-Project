### Written by Thomas Carlin - tom.carlin@scionresearch.com/t.carlin@live.co.uk
## 23/09/21
## List of functions written to collect elevation, climate, and soil data for any given coordinates
elevation <- function(dat,plot=F) {
  library(elevatr)
  library(raster)
  library(rgdal)

  dat[dat[,1]>180,1] <- dat[dat[,1]>180,1]-360 ## This line corrects for any longitudes recorded above 180 (as has happened before...)

  colnames(dat) <- c("x","y") # get_elev_raster() function now confusingly requires dataframe columns to explicitly be named "x" and "y".
  
  prj_ <- CRS("+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs")
  dat2 <- SpatialPoints(dat, proj4string = prj_)
  prj_dd <- "+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs"
  
  
    
    for (i in 1:nrow(dat)){
      
      # Use elevatr package to get elevation data for each point.
      elev <- get_elev_raster(dat[i,], prj = prj_dd, z = 7)
      slop <- terrain(elev, opt=c('slope', 'aspect'), unit='degrees')
      stack <- stack(elev, slop[[1]],slop[[2]])
      
      extdat <- extract(stack, dat2[i])
      dat[i,c(3:5)] <- extdat
      
      if (plot==T) {
        par(mfrow=c(1,3)) # Change plot window to plot all 3 rasters on one figure
        plot(elev, main="Elevation") 
        points(dat[i,1:2])
        plot(slop[[1]], main="Slope")
        points(dat[i,1:2])
        plot(slop[[2]], main="Aspect")
        points(dat[i,1:2])
      }
      else {}
    }
    

  colnames(dat) <- c("lon","lat","Elevation","Slope","Aspect")
  return(dat)
}

climate <- function(dat,plot=F) {
  library(raster)

  dat[dat[,1]>180,1] <- dat[dat[,1]>180,1]-360 ## This line corrects for any longitudes recorded above 180 (as has happened before...)
  
  prj_ <- CRS("+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs")
  dat2 <- SpatialPoints(dat, proj4string = prj_)
  
  
    for (i in 1:nrow(dat)){
      
      clim_stack <- getData('worldclim', var='bio', res=0.5, lon=dat[i,1], lat=dat[i,2], path='Q:/Tree Root Microbiome/RA 3  Characterising the soil environment/Projects/Envirotyping data/worldclim 0.5') # Resolution here is 30 arcseconds
      extdat <- extract(clim_stack, dat2[i])
      dat[i,c(3:21)] <- extdat
      if (plot==T) {
        plot(clim_stack, main=c('MeanTemp','DayRange','Isotherm','TempSeason','MaxTemp','MinTemp','YrRange','MeanTempWet','MeanTempDry','MeanWarmTemp','MeanColdTemp','Precip','PrecipWetMo','PrecipDryMo','PrecipSeason','PrecipWetQ','PrecipDryQ','PrecipWarmQ','PrecipColdQ'))
      }
      else {}
    }
    
    colnames(dat) <- c('lon','lat','MeanTemp','DayRange','Isotherm','TempSeason','MaxTemp'
                       ,'MinTemp','YrRange','MeanTempWet','MeanTempDry','MeanWarmTemp','MeanColdTemp','Precip'
                       ,'PrecipWetMo','PrecipDryMo','PrecipSeason','PrecipWetQ'
                       ,'PrecipDryQ','PrecipWarmQ','PrecipColdQ')
    dat[,c(3,7,8,10:13)] <- dat[,c(3,7,8,10:13)]/10 ### Convert Temperature data into celsius (currently celsius*10)
    dat[,6] <- dat[,6]/100 ### Convert temperature seasonality value in sd of mean temp values
    
    return(dat)
}

soil <- function(dat,plot=F) {
  ### Load raster library
  library(raster)

  dat[dat[,1]>180,1] <- dat[dat[,1]>180,1]-360 ## This line corrects for any longitudes recorded above 180 (as has happened before...)
  
  ### Load in world refernce base soil map
  soil_map <- raster("wrb.tif")
 
  
  ### Pull soil attributes, set projection of points and converts points to spatialpoints
  sol <- as.character(soil_map@data@attributes[[1]][["RSG"]])
  prj_ <- CRS("EPSG:4326")
  dat2 <- SpatialPoints(dat, proj4string = prj_)
  
  ### Plot points on map
  if (plot==T) {
    plot(soil_map)
    points(dat)
  }
  else {}
  
  ### Extract value of raster at points
  extdat <- extract(soil_map, dat2)
  dat[,3] <- extdat
  
  ### Assign correct soil names to factor classes, given numeric position in list
  dat$Soil <- sol[dat[,3]+1] #Need to add +1 as the list of numbers starts at 0, but list of names starts at 1.
  dat <- dat[,c(1,2,4)] 
  return(dat)
}

environs <- function(dat) {
  dat1 <- elevation(dat)
  dat2 <- soil(dat)
  dat3 <- climate(dat)
  dat <- cbind(dat1,dat2[,3],dat3[,3:21])
  names(dat)[names(dat) == "dat2[, 3]"] <- 'Soil'
  return(dat)
}
