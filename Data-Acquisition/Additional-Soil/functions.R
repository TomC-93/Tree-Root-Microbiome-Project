### Written by Thomas Carlin - tom.carlin@scionresearch.com/t.carlin@live.co.uk
## 30/09/21
## Function for collecting soil data

soildat <- function(dat,depth="all",uncertainty=F) {
  ### Load raster library
  library(raster)
  
  ### Retain working directory + set new working directory (for easier raster grabbing)
  orig_wd <- getwd()
  setwd("Q:/Tree Root Microbiome/RA 3  Characterising the soil environment/Projects/Envirotyping data/Global Soil Data/Soil_Data")
  
  ### Load in world reference base soil map
  soil_map <- raster("class.tif")
  
  ### Pull soil attributes, set projection of points and converts points to spatialpoints
  sol <- as.character(soil_map@data@attributes[[1]][["RSG"]])
  prj_ <- CRS("EPSG:4326")
  coords <- SpatialPoints(dat, proj4string = prj_)
  
  if (uncertainty==T){
    names <- c("Longitude","Latitude","Soilclass","ocs","un_ocs","depth","bdod","cec","cfvo","clay","nitrogen","ocd","phh2o","sand","silt","soc","un_bdod","un_cec","un_cfvo","un_clay","un_nitrogen","un_ocd","un_phh2o","un_sand","un_silt","un_soc")
    dat[,names[3:26]] <- NA
  } else{
    names <- c("Longitude","Latitude","Soilclass","ocs","un_ocs","depth","bdod","cec","cfvo","clay","nitrogen","ocd","phh2o","sand","silt","soc")
    dat[,names[3:16]] <- NA
  }
    
  ### Extract value of raster at points
  extdat <- extract(soil_map, coords)
  dat[,3] <- extdat
  
  ### Assign correct soil names to factor classes, given numeric position in list
  dat$Soilclass <- sol[dat[,3]+1] #Need to add +1 as the list of numbers starts at 0, but list of names starts at 1.
  message("Soil class extracted")
  
  ### Extract organic carbon stock data (this is only available at 0-30cm depth)
  ocs <- raster("ocs_0_30.tif")
  UNCocs <- raster("UNCocs_0_30.tif")
  d0_30 <- stack(ocs,UNCocs)
  extdat <- extract(d0_30, coords)
  dat[,4:5] <- extdat
  message("Organic carbon stock extracted (fixed depth 0-30cm)")
  
  ### May be a more elegant way using switch(), rather than many if else statements?

   if (depth=="0-5"){
     
     bdod <- raster("bdod_0_5.tif")
     cec <- raster("cec_0_5.tif")
     cfvo <- raster("cfvo_0_5.tif")
     clay <- raster("clay_0_5.tif")
     nitrogen <- raster("nitrogen_0_5.tif")
     ocd <- raster("ocd_0_5.tif")
     phh2o <- raster("phh2o_0_5.tif")
     sand <- raster("sand_0_5.tif")
     silt <- raster("silt_0_5.tif")
     soc <- raster("soc_0_5.tif")
     d0_5 <- stack(bdod,cec,cfvo,clay,nitrogen,ocd,phh2o,sand,silt,soc)
     
     dat[,6] <- "0-5"
     extdat <- extract(d0_5, coords)
     dat[,7:16] <- extdat
     
     message("Soil properties extracted")
     
     if (uncertainty==TRUE) {
       
       UNCbdod <- raster("UNCbdod_0_5.tif")
       UNCcec <- raster("UNCcec_0_5.tif")
       UNCcfvo <- raster("UNCcfvo_0_5.tif")
       UNCclay <- raster("UNCclay_0_5.tif")
       UNCnitrogen <- raster("UNCnitrogen_0_5.tif")
       UNCocd <- raster("UNCocd_0_5.tif")
       UNCphh2o <- raster("UNCphh2o_0_5.tif")
       UNCsand <- raster("UNCsand_0_5.tif")
       UNCsilt <- raster("UNCsilt_0_5.tif")
       UNCsoc <- raster("UNCsoc_0_5.tif")
       d0_5u <- stack(UNCbdod,UNCcec,UNCcfvo,UNCclay,UNCnitrogen,UNCocd,UNCphh2o,UNCsand,UNCsilt,UNCsoc)
       
       extdat <- extract(d0_5u, coords)
       dat[,17:26] <- extdat
       
       message("Uncertainty values extracted")
     } 
     
     result <- dat
     return(result)
     ### Reset the working directory
     setwd(orig_wd)
     message("Data extraction complete")
     
   } else if (depth=="5-15"){
     
     bdod <- raster("bdod_5_15.tif")
     cec <- raster("cec_5_15.tif")
     cfvo <- raster("cfvo_5_15.tif")
     clay <- raster("clay_5_15.tif")
     nitrogen <- raster("nitrogen_5_15.tif")
     ocd <- raster("ocd_5_15.tif")
     phh2o <- raster("phh2o_5_15.tif")
     sand <- raster("sand_5_15.tif")
     silt <- raster("silt_5_15.tif")
     soc <- raster("soc_5_15.tif")
     d5_15 <- stack(bdod,cec,cfvo,clay,nitrogen,ocd,phh2o,sand,silt,soc)
     
     dat[,6] <- "5-15"
     extdat <- extract(d5_15, coords)
     dat[,7:16] <- extdat
     
     message("Soil properties extracted")
     
     if (uncertainty==TRUE) {
       
       UNCbdod <- raster("UNCbdod_5_15.tif")
       UNCcec <- raster("UNCcec_5_15.tif")
       UNCcfvo <- raster("UNCcfvo_5_15.tif")
       UNCclay <- raster("UNCclay_5_15.tif")
       UNCnitrogen <- raster("UNCnitrogen_5_15.tif")
       UNCocd <- raster("UNCocd_5_15.tif")
       UNCphh2o <- raster("UNCphh2o_5_15.tif")
       UNCsand <- raster("UNCsand_5_15.tif")
       UNCsilt <- raster("UNCsilt_5_15.tif")
       UNCsoc <- raster("UNCsoc_5_15.tif")
       d5_15u <- stack(UNCbdod,UNCcec,UNCcfvo,UNCclay,UNCnitrogen,UNCocd,UNCphh2o,UNCsand,UNCsilt,UNCsoc)
       
       extdat <- extract(d5_15u, coords)
       dat[,17:26] <- extdat
       
       message("Uncertainty values extracted")
     } 
     
     result <- dat
     return(result)
     ### Reset the working directory
     setwd(orig_wd)
     message("Data extraction complete")
     
   } else if (depth=="15-30"){
     
     bdod <- raster("bdod_15_30.tif")
     cec <- raster("cec_15_30.tif")
     cfvo <- raster("cfvo_15_30.tif")
     clay <- raster("clay_15_30.tif")
     nitrogen <- raster("nitrogen_15_30.tif")
     ocd <- raster("ocd_15_30.tif")
     phh2o <- raster("phh2o_15_30.tif")
     sand <- raster("sand_15_30.tif")
     silt <- raster("silt_15_30.tif")
     soc <- raster("soc_15_30.tif")
     d15_30 <- stack(bdod,cec,cfvo,clay,nitrogen,ocd,phh2o,sand,silt,soc)
     
     dat[,6] <- "15-30"
     extdat <- extract(d15_30, coords)
     dat[,7:16] <- extdat
     
     message("Soil properties extracted")
     
     if (uncertainty==TRUE) {
       
       UNCbdod <- raster("UNCbdod_15_30.tif")
       UNCcec <- raster("UNCcec_15_30.tif")
       UNCcfvo <- raster("UNCcfvo_15_30.tif")
       UNCclay <- raster("UNCclay_15_30.tif")
       UNCnitrogen <- raster("UNCnitrogen_15_30.tif")
       UNCocd <- raster("UNCocd_15_30.tif")
       UNCphh2o <- raster("UNCphh2o_15_30.tif")
       UNCsand <- raster("UNCsand_15_30.tif")
       UNCsilt <- raster("UNCsilt_15_30.tif")
       UNCsoc <- raster("UNCsoc_15_30.tif")
       d15_30u <- stack(UNCbdod,UNCcec,UNCcfvo,UNCclay,UNCnitrogen,UNCocd,UNCphh2o,UNCsand,UNCsilt,UNCsoc)
       
       extdat <- extract(d15_30u, coords)
       dat[,17:26] <- extdat
       
       message("Uncertainty values extracted")
     } 
     
     result <- dat
     return(result)
     ### Reset the working directory
     setwd(orig_wd)
     message("Data extraction complete")
     
   } else if (depth=="30-60"){
     
     bdod <- raster("bdod_30_60.tif")
     cec <- raster("cec_30_60.tif")
     cfvo <- raster("cfvo_30_60.tif")
     clay <- raster("clay_30_60.tif")
     nitrogen <- raster("nitrogen_30_60.tif")
     ocd <- raster("ocd_30_60.tif")
     phh2o <- raster("phh2o_30_60.tif")
     sand <- raster("sand_30_60.tif")
     silt <- raster("silt_30_60.tif")
     soc <- raster("soc_30_60.tif")
     d30_60 <- stack(bdod,cec,cfvo,clay,nitrogen,ocd,phh2o,sand,silt,soc)
     
     dat[,6] <- "30-60"
     extdat <- extract(d30_60, coords)
     dat[,7:16] <- extdat
     
     message("Soil properties extracted")
     
     if (uncertainty==TRUE) {
       
       UNCbdod <- raster("UNCbdod_30_60.tif")
       UNCcec <- raster("UNCcec_30_60.tif")
       UNCcfvo <- raster("UNCcfvo_30_60.tif")
       UNCclay <- raster("UNCclay_30_60.tif")
       UNCnitrogen <- raster("UNCnitrogen_30_60.tif")
       UNCocd <- raster("UNCocd_30_60.tif")
       UNCphh2o <- raster("UNCphh2o_30_60.tif")
       UNCsand <- raster("UNCsand_30_60.tif")
       UNCsilt <- raster("UNCsilt_30_60.tif")
       UNCsoc <- raster("UNCsoc_30_60.tif")
       d30_60u <- stack(UNCbdod,UNCcec,UNCcfvo,UNCclay,UNCnitrogen,UNCocd,UNCphh2o,UNCsand,UNCsilt,UNCsoc)
       
       extdat <- extract(d30_60u, coords)
       dat[,17:26] <- extdat
       
       message("Uncertainty values extracted")
     }  
     
     result <- dat
     return(result)
     ### Reset the working directory
     setwd(orig_wd)
     message("Data extraction complete")
     
   } else if (depth=="60-100"){
     
     bdod <- raster("bdod_60_100.tif")
     cec <- raster("cec_60_100.tif")
     cfvo <- raster("cfvo_60_100.tif")
     clay <- raster("clay_60_100.tif")
     nitrogen <- raster("nitrogen_60_100.tif")
     ocd <- raster("ocd_60_100.tif")
     phh2o <- raster("phh2o_60_100.tif")
     sand <- raster("sand_60_100.tif")
     silt <- raster("silt_60_100.tif")
     soc <- raster("soc_60_100.tif")
     d60_100 <- stack(bdod,cec,cfvo,clay,nitrogen,ocd,phh2o,sand,silt,soc)
     
     dat[,6] <- "60-100"
     extdat <- extract(d60_100, coords)
     dat[,7:16] <- extdat
     
     message("Soil properties extracted")
     
     if (uncertainty==TRUE) {
       
       UNCbdod <- raster("UNCbdod_60_100.tif")
       UNCcec <- raster("UNCcec_60_100.tif")
       UNCcfvo <- raster("UNCcfvo_60_100.tif")
       UNCclay <- raster("UNCclay_60_100.tif")
       UNCnitrogen <- raster("UNCnitrogen_60_100.tif")
       UNCocd <- raster("UNCocd_60_100.tif")
       UNCphh2o <- raster("UNCphh2o_60_100.tif")
       UNCsand <- raster("UNCsand_60_100.tif")
       UNCsilt <- raster("UNCsilt_60_100.tif")
       UNCsoc <- raster("UNCsoc_60_100.tif")
       d60_100u <- stack(UNCbdod,UNCcec,UNCcfvo,UNCclay,UNCnitrogen,UNCocd,UNCphh2o,UNCsand,UNCsilt,UNCsoc)
       
       extdat <- extract(d60_100u, coords)
       dat[,17:26] <- extdat
       
       message("Uncertainty values extracted")
     }  
     
     result <- dat
     return(result)
     ### Reset the working directory
     setwd(orig_wd)
     message("Data extraction complete")
     
   } else if (depth=="100-200"){
     
     bdod <- raster("bdod_100_200.tif")
     cec <- raster("cec_100_200.tif")
     cfvo <- raster("cfvo_100_200.tif")
     clay <- raster("clay_100_200.tif")
     nitrogen <- raster("nitrogen_100_200.tif")
     ocd <- raster("ocd_100_200.tif")
     phh2o <- raster("phh2o_100_200.tif")
     sand <- raster("sand_100_200.tif")
     silt <- raster("silt_100_200.tif")
     soc <- raster("soc_100_200.tif")
     d100_200 <- stack(bdod,cec,cfvo,clay,nitrogen,ocd,phh2o,sand,silt,soc)
     
     dat[,6] <- "100-200"
     extdat <- extract(d100_200, coords)
     dat[,7:16] <- extdat
     
     message("Soil properties extracted")
     
     if (uncertainty==TRUE) {
       
       UNCbdod <- raster("UNCbdod_100_200.tif")
       UNCcec <- raster("UNCcec_100_200.tif")
       UNCcfvo <- raster("UNCcfvo_100_200.tif")
       UNCclay <- raster("UNCclay_100_200.tif")
       UNCnitrogen <- raster("UNCnitrogen_100_200.tif")
       UNCocd <- raster("UNCocd_100_200.tif")
       UNCphh2o <- raster("UNCphh2o_100_200.tif")
       UNCsand <- raster("UNCsand_100_200.tif")
       UNCsilt <- raster("UNCsilt_100_200.tif")
       UNCsoc <- raster("UNCsoc_100_200.tif")
       d100_200u <- stack(UNCbdod,UNCcec,UNCcfvo,UNCclay,UNCnitrogen,UNCocd,UNCphh2o,UNCsand,UNCsilt,UNCsoc)
       
       extdat <- extract(d100_200u, coords)
       dat[,17:26] <- extdat
       
       message("Uncertainty values extracted")
     } 
     
     result <- dat
     return(result)
     ### Reset the working directory
     setwd(orig_wd)
     message("Data extraction complete")
     
   } else if (depth=="all"){
     
     #Load in and stack all rasters from 0-5cm depth
     bdod <- raster("bdod_0_5.tif")
     cec <- raster("cec_0_5.tif")
     cfvo <- raster("cfvo_0_5.tif")
     clay <- raster("clay_0_5.tif")
     nitrogen <- raster("nitrogen_0_5.tif")
     ocd <- raster("ocd_0_5.tif")
     phh2o <- raster("phh2o_0_5.tif")
     sand <- raster("sand_0_5.tif")
     silt <- raster("silt_0_5.tif")
     soc <- raster("soc_0_5.tif")
     d0_5 <- stack(bdod,cec,cfvo,clay,nitrogen,ocd,phh2o,sand,silt,soc)
     
     dat1 <- dat
     dat1[,6] <- "0-5"
     extdat <- extract(d0_5, coords)
     dat1[,7:16] <- extdat
     
     message("Depth 0-5cm complete, now extracting 5-15cm")
     
     #Load in and stack all rasters from 5-15cm depth
     bdod <- raster("bdod_5_15.tif")
     cec <- raster("cec_5_15.tif")
     cfvo <- raster("cfvo_5_15.tif")
     clay <- raster("clay_5_15.tif")
     nitrogen <- raster("nitrogen_5_15.tif")
     ocd <- raster("ocd_5_15.tif")
     phh2o <- raster("phh2o_5_15.tif")
     sand <- raster("sand_5_15.tif")
     silt <- raster("silt_5_15.tif")
     soc <- raster("soc_5_15.tif")
     d5_15 <- stack(bdod,cec,cfvo,clay,nitrogen,ocd,phh2o,sand,silt,soc)
     
     dat2 <- dat
     dat2[,6] <- "5-15"
     extdat <- extract(d5_15, coords)
     dat2[,7:16] <- extdat
     
     message("Depth 5-15cm complete, now extracting 15-30cm")
     
     #Load in and stack all rasters from 15-30cm depth
     bdod <- raster("bdod_15_30.tif")
     cec <- raster("cec_15_30.tif")
     cfvo <- raster("cfvo_15_30.tif")
     clay <- raster("clay_15_30.tif")
     nitrogen <- raster("nitrogen_15_30.tif")
     ocd <- raster("ocd_15_30.tif")
     phh2o <- raster("phh2o_15_30.tif")
     sand <- raster("sand_15_30.tif")
     silt <- raster("silt_15_30.tif")
     soc <- raster("soc_15_30.tif")
     d15_30 <- stack(bdod,cec,cfvo,clay,nitrogen,ocd,phh2o,sand,silt,soc)
     
     dat3 <- dat
     dat3[,6] <- "15-30"
     extdat <- extract(d15_30, coords)
     dat3[,7:16] <- extdat
     
     message("Depth 15-30cm complete, now extracting 30-60cm")
     
     #Load in and stack all rasters from 30-60cm depth
     bdod <- raster("bdod_30_60.tif")
     cec <- raster("cec_30_60.tif")
     cfvo <- raster("cfvo_30_60.tif")
     clay <- raster("clay_30_60.tif")
     nitrogen <- raster("nitrogen_30_60.tif")
     ocd <- raster("ocd_30_60.tif")
     phh2o <- raster("phh2o_30_60.tif")
     sand <- raster("sand_30_60.tif")
     silt <- raster("silt_30_60.tif")
     soc <- raster("soc_30_60.tif")
     d30_60 <- stack(bdod,cec,cfvo,clay,nitrogen,ocd,phh2o,sand,silt,soc)
     
     dat4 <- dat
     dat4[,6] <- "30-60"
     extdat <- extract(d30_60, coords)
     dat4[,7:16] <- extdat
     
     message("Depth 30-60cm complete, now extracting 60-100cm")
     
     #Load in and stack all rasters from 60-100cm depth
     bdod <- raster("bdod_60_100.tif")
     cec <- raster("cec_60_100.tif")
     cfvo <- raster("cfvo_60_100.tif")
     clay <- raster("clay_60_100.tif")
     nitrogen <- raster("nitrogen_60_100.tif")
     ocd <- raster("ocd_60_100.tif")
     phh2o <- raster("phh2o_60_100.tif")
     sand <- raster("sand_60_100.tif")
     silt <- raster("silt_60_100.tif")
     soc <- raster("soc_60_100.tif")
     d60_100 <- stack(bdod,cec,cfvo,clay,nitrogen,ocd,phh2o,sand,silt,soc)
     
     dat5 <- dat
     dat5[,6] <- "60-100"
     extdat <- extract(d60_100, coords)
     dat5[,7:16] <- extdat
     
     message("Depth 60-100cm complete, now extracting 100-200cm")
     
     #Load in and stack all rasters from 100-200cm depth
     bdod <- raster("bdod_100_200.tif")
     cec <- raster("cec_100_200.tif")
     cfvo <- raster("cfvo_100_200.tif")
     clay <- raster("clay_100_200.tif")
     nitrogen <- raster("nitrogen_100_200.tif")
     ocd <- raster("ocd_100_200.tif")
     phh2o <- raster("phh2o_100_200.tif")
     sand <- raster("sand_100_200.tif")
     silt <- raster("silt_100_200.tif")
     soc <- raster("soc_100_200.tif")
     d100_200 <- stack(bdod,cec,cfvo,clay,nitrogen,ocd,phh2o,sand,silt,soc)
     
     dat6 <- dat
     dat6[,6] <- "100-200"
     extdat <- extract(d100_200, coords)
     dat6[,7:16] <- extdat
     
     message("Depth 100-200cm complete")
     
     result <- rbind(dat1,dat2,dat3,dat4,dat5,dat6)
     result[,c(8:10,12:16)] <- result[,c(8:10,12:16)]/10 ### Convert into conventional units
     result[,c(7,11)] <- result[,7,11]/100 ### Convert into conventional units
     
     if (uncertainty==TRUE) {
       message("Extracting uncertainty values")
       
       UNCbdod <- raster("UNCbdod_0_5.tif")
       UNCcec <- raster("UNCcec_0_5.tif")
       UNCcfvo <- raster("UNCcfvo_0_5.tif")
       UNCclay <- raster("UNCclay_0_5.tif")
       UNCnitrogen <- raster("UNCnitrogen_0_5.tif")
       UNCocd <- raster("UNCocd_0_5.tif")
       UNCphh2o <- raster("UNCphh2o_0_5.tif")
       UNCsand <- raster("UNCsand_0_5.tif")
       UNCsilt <- raster("UNCsilt_0_5.tif")
       UNCsoc <- raster("UNCsoc_0_5.tif")
       d0_5u <- stack(UNCbdod,UNCcec,UNCcfvo,UNCclay,UNCnitrogen,UNCocd,UNCphh2o,UNCsand,UNCsilt,UNCsoc)
       
       extdat <- extract(d0_5u, coords)
       dat1[,17:26] <- extdat
       
       UNCbdod <- raster("UNCbdod_5_15.tif")
       UNCcec <- raster("UNCcec_5_15.tif")
       UNCcfvo <- raster("UNCcfvo_5_15.tif")
       UNCclay <- raster("UNCclay_5_15.tif")
       UNCnitrogen <- raster("UNCnitrogen_5_15.tif")
       UNCocd <- raster("UNCocd_5_15.tif")
       UNCphh2o <- raster("UNCphh2o_5_15.tif")
       UNCsand <- raster("UNCsand_5_15.tif")
       UNCsilt <- raster("UNCsilt_5_15.tif")
       UNCsoc <- raster("UNCsoc_5_15.tif")
       d5_15u <- stack(UNCbdod,UNCcec,UNCcfvo,UNCclay,UNCnitrogen,UNCocd,UNCphh2o,UNCsand,UNCsilt,UNCsoc)
       
       extdat <- extract(d5_15u, coords)
       dat2[,17:26] <- extdat
       
       UNCbdod <- raster("UNCbdod_15_30.tif")
       UNCcec <- raster("UNCcec_15_30.tif")
       UNCcfvo <- raster("UNCcfvo_15_30.tif")
       UNCclay <- raster("UNCclay_15_30.tif")
       UNCnitrogen <- raster("UNCnitrogen_15_30.tif")
       UNCocd <- raster("UNCocd_15_30.tif")
       UNCphh2o <- raster("UNCphh2o_15_30.tif")
       UNCsand <- raster("UNCsand_15_30.tif")
       UNCsilt <- raster("UNCsilt_15_30.tif")
       UNCsoc <- raster("UNCsoc_15_30.tif")
       d15_30u <- stack(UNCbdod,UNCcec,UNCcfvo,UNCclay,UNCnitrogen,UNCocd,UNCphh2o,UNCsand,UNCsilt,UNCsoc)
       
       extdat <- extract(d15_30u, coords)
       dat3[,17:26] <- extdat
       
       UNCbdod <- raster("UNCbdod_30_60.tif")
       UNCcec <- raster("UNCcec_30_60.tif")
       UNCcfvo <- raster("UNCcfvo_30_60.tif")
       UNCclay <- raster("UNCclay_30_60.tif")
       UNCnitrogen <- raster("UNCnitrogen_30_60.tif")
       UNCocd <- raster("UNCocd_30_60.tif")
       UNCphh2o <- raster("UNCphh2o_30_60.tif")
       UNCsand <- raster("UNCsand_30_60.tif")
       UNCsilt <- raster("UNCsilt_30_60.tif")
       UNCsoc <- raster("UNCsoc_30_60.tif")
       d30_60u <- stack(UNCbdod,UNCcec,UNCcfvo,UNCclay,UNCnitrogen,UNCocd,UNCphh2o,UNCsand,UNCsilt,UNCsoc)
       
       extdat <- extract(d30_60u, coords)
       dat4[,17:26] <- extdat
       
       UNCbdod <- raster("UNCbdod_60_100.tif")
       UNCcec <- raster("UNCcec_60_100.tif")
       UNCcfvo <- raster("UNCcfvo_60_100.tif")
       UNCclay <- raster("UNCclay_60_100.tif")
       UNCnitrogen <- raster("UNCnitrogen_60_100.tif")
       UNCocd <- raster("UNCocd_60_100.tif")
       UNCphh2o <- raster("UNCphh2o_60_100.tif")
       UNCsand <- raster("UNCsand_60_100.tif")
       UNCsilt <- raster("UNCsilt_60_100.tif")
       UNCsoc <- raster("UNCsoc_60_100.tif")
       d60_100u <- stack(UNCbdod,UNCcec,UNCcfvo,UNCclay,UNCnitrogen,UNCocd,UNCphh2o,UNCsand,UNCsilt,UNCsoc)
       
       extdat <- extract(d60_100u, coords)
       dat5[,17:26] <- extdat
       
       UNCbdod <- raster("UNCbdod_100_200.tif")
       UNCcec <- raster("UNCcec_100_200.tif")
       UNCcfvo <- raster("UNCcfvo_100_200.tif")
       UNCclay <- raster("UNCclay_100_200.tif")
       UNCnitrogen <- raster("UNCnitrogen_100_200.tif")
       UNCocd <- raster("UNCocd_100_200.tif")
       UNCphh2o <- raster("UNCphh2o_100_200.tif")
       UNCsand <- raster("UNCsand_100_200.tif")
       UNCsilt <- raster("UNCsilt_100_200.tif")
       UNCsoc <- raster("UNCsoc_100_200.tif")
       d100_200u <- stack(UNCbdod,UNCcec,UNCcfvo,UNCclay,UNCnitrogen,UNCocd,UNCphh2o,UNCsand,UNCsilt,UNCsoc)
       
       extdat <- extract(d100_200u, coords)
       dat6[,17:26] <- extdat
       
       result <- rbind(dat1,dat2,dat3,dat4,dat5,dat6)
       
       message("Uncertainty values extracted")
     } 
     
     return(result)
     ### Reset the working directory
     setwd(orig_wd)
     message("Data extraction complete")
     
   } else {
     stop("Error: depth argument must be either 'all', '5-15', '15-30', '30-60', '60-100', or '100-200'")
     ### Reset the working directory
     setwd(orig_wd)
   }
}

