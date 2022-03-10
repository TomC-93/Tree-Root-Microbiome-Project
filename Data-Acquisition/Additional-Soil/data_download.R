##### Downloading Global Soil Data Using GDAL Software #####

## Thomas Carlin  
## tom.carlin@scionresearch.com | t.carlin@live.co.uk
## 29/09/21

### Purpose: Downloading Soil data and creating a usable tif file in a WGS84 projection.

### Inputs: Downloads .vrt files from https://files.isric.org/soilgrids/latest/data/ (Requires internet access)
### Outputs: TIF files of world maps with associated data.
### All TIF files available in:
### Q:\Tree Root Microbiome\RA 3  Characterising the soil environment\Projects\Envirotyping data\Global Soil Data\Soil_Data

#### Metadata ####
### Data from: https://www.isric.org/explore/soilgrids
### Data files available cover:
# Bulk density of the fine earth fraction
# Cation Exchange Capacity of the soil
# Volumetric fraction of coarse fragments (> 2 mm)
# Proportion of clay particles (< 0.002 mm) in the fine earth fraction
# Total nitrogen (N)
# Soil pH
# Proportion of sand particles (> 0.05 mm) in the fine earth fraction
# Proportion of silt particles (??? 0.002 mm and ??? 0.05 mm) in the fine earth fraction
# Soil organic carbon content in the fine earth fraction
# Organic carbon density
# Organic carbon stocks

### Available at 6 depth increments:
#   
# 0-5cm
# 5-15cm
# 15-30cm
# 30-60cm
# 60-100cm
# 100-200cm

## Organic carbon stocks (ocs) only available at a 0-30cm depth increment

### Along with associated uncertainty files
#####

### This file is intended only to download and create tif files of soil data. 
### You do not need to follow these instructions if you only want to *extract* data from the existing soil files.

################
#     NOTE     #
################
## Before this R script can be run you MUST install gdal software onto your computer.
## You can find gdal software from a number of locations, however I recommend:
## https://trac.osgeo.org/osgeo4w/
## Simply follow the instructions, ensure you tick the box next to gdal when installing, and the following R code will run.

setwd("Q:/Tree Root Microbiome/RA 3  Characterising the soil environment/Projects/Envirotyping data/Global Soil Data/Soil_Data")

library(rgdal)
library(gdalUtils)

### The following command downloads soil data directly into your working directory

## The resolution of data can be changed by altering the tr=c(0.01,0.01) argument, where smaller numbers are finer resolution and larger numbers are coarser resolution.

### Resolution of 0.01 is ~ 1.11km. (values in decimal degrees)

#### Soil Class ####
gdalwarp(t_srs="EPSG:4326", multi=TRUE, wm=200, # EPSG:4326 is the EPSG identifier code for WGS84 projection
         co=c("BIGTIFF=YES", "COMPRESS=DEFLATE", "TILED=TRUE"),
         tr=c(0.01,0.01), # Desired output resolution
         verbose=T,
         "/vsicurl?max_retry=3&retry_delay=1&list_dir=no&url=https://files.isric.org/soilgrids/latest/data/wrb/MostProbable.vrt", # Input VRT
         "class.tif") # Output file

#### Bulk density of the fine earth fraction ####
## 0-5cm depth
gdalwarp(t_srs="EPSG:4326", multi=TRUE, wm=200, 
         co=c("BIGTIFF=YES", "COMPRESS=DEFLATE", "TILED=TRUE"),
         tr=c(0.01,0.01), # Desired output resolution
         verbose=T,
         "/vsicurl?max_retry=3&retry_delay=1&list_dir=no&url=https://files.isric.org/soilgrids/latest/data/bdod/bdod_0-5cm_mean.vrt", # Input VRT
         "bdod_0_5.tif") # Output file
## 0-5cm uncertainty
gdalwarp(t_srs="EPSG:4326", multi=TRUE, wm=200, 
         co=c("BIGTIFF=YES", "COMPRESS=DEFLATE", "TILED=TRUE"),
         tr=c(0.01,0.01), # Desired output resolution
         verbose=T,
         "/vsicurl?max_retry=3&retry_delay=1&list_dir=no&url=https://files.isric.org/soilgrids/latest/data/bdod/bdod_0-5cm_uncertainty.vrt", # Input VRT
         "UNCbdod_0_5.tif") # Output file
## 5-15cm depth
gdalwarp(t_srs="EPSG:4326", multi=TRUE, wm=200, 
         co=c("BIGTIFF=YES", "COMPRESS=DEFLATE", "TILED=TRUE"),
         tr=c(0.01,0.01), # Desired output resolution
         verbose=T,
         "/vsicurl?max_retry=3&retry_delay=1&list_dir=no&url=https://files.isric.org/soilgrids/latest/data/bdod/bdod_5-15cm_mean.vrt", # Input VRT
         "bdod_5_15.tif") # Output file
## 5-15cm uncertainty
gdalwarp(t_srs="EPSG:4326", multi=TRUE, wm=200, 
         co=c("BIGTIFF=YES", "COMPRESS=DEFLATE", "TILED=TRUE"),
         tr=c(0.01,0.01), # Desired output resolution
         verbose=T,
         "/vsicurl?max_retry=3&retry_delay=1&list_dir=no&url=https://files.isric.org/soilgrids/latest/data/bdod/bdod_5-15cm_uncertainty.vrt", # Input VRT
         "UNCbdod_5_15.tif") # Output file
## 15-30cm depth
gdalwarp(t_srs="EPSG:4326", multi=TRUE, wm=200, 
         co=c("BIGTIFF=YES", "COMPRESS=DEFLATE", "TILED=TRUE"),
         tr=c(0.01,0.01), # Desired output resolution
         verbose=T,
         "/vsicurl?max_retry=3&retry_delay=1&list_dir=no&url=https://files.isric.org/soilgrids/latest/data/bdod/bdod_15-30cm_mean.vrt", # Input VRT
         "bdod_15_30.tif") # Output file
## 15-30cm uncertainty
gdalwarp(t_srs="EPSG:4326", multi=TRUE, wm=200, 
         co=c("BIGTIFF=YES", "COMPRESS=DEFLATE", "TILED=TRUE"),
         tr=c(0.01,0.01), # Desired output resolution
         verbose=T,
         "/vsicurl?max_retry=3&retry_delay=1&list_dir=no&url=https://files.isric.org/soilgrids/latest/data/bdod/bdod_15-30cm_uncertainty.vrt", # Input VRT
         "UNCbdod_15_30.tif") # Output file
## 30-60cm depth
gdalwarp(t_srs="EPSG:4326", multi=TRUE, wm=200, 
         co=c("BIGTIFF=YES", "COMPRESS=DEFLATE", "TILED=TRUE"),
         tr=c(0.01,0.01), # Desired output resolution
         verbose=T,
         "/vsicurl?max_retry=3&retry_delay=1&list_dir=no&url=https://files.isric.org/soilgrids/latest/data/bdod/bdod_30-60cm_mean.vrt", # Input VRT
         "bdod_30_60.tif") # Output file
## 30-60cm uncertainty
gdalwarp(t_srs="EPSG:4326", multi=TRUE, wm=200, 
         co=c("BIGTIFF=YES", "COMPRESS=DEFLATE", "TILED=TRUE"),
         tr=c(0.01,0.01), # Desired output resolution
         verbose=T,
         "/vsicurl?max_retry=3&retry_delay=1&list_dir=no&url=https://files.isric.org/soilgrids/latest/data/bdod/bdod_30-60cm_uncertainty.vrt", # Input VRT
         "UNCbdod_30_60.tif") # Output file
## 60-100cm depth
gdalwarp(t_srs="EPSG:4326", multi=TRUE, wm=200, 
         co=c("BIGTIFF=YES", "COMPRESS=DEFLATE", "TILED=TRUE"),
         tr=c(0.01,0.01), # Desired output resolution
         verbose=T,
         "/vsicurl?max_retry=3&retry_delay=1&list_dir=no&url=https://files.isric.org/soilgrids/latest/data/bdod/bdod_60-100cm_mean.vrt", # Input VRT
         "bdod_60_100.tif") # Output file
## 60-100cm uncertainty
gdalwarp(t_srs="EPSG:4326", multi=TRUE, wm=200, 
         co=c("BIGTIFF=YES", "COMPRESS=DEFLATE", "TILED=TRUE"),
         tr=c(0.01,0.01), # Desired output resolution
         verbose=T,
         "/vsicurl?max_retry=3&retry_delay=1&list_dir=no&url=https://files.isric.org/soilgrids/latest/data/bdod/bdod_60-100cm_uncertainty.vrt", # Input VRT
         "UNCbdod_60_100.tif") # Output file
## 100-200cm depth
gdalwarp(t_srs="EPSG:4326", multi=TRUE, wm=200, 
         co=c("BIGTIFF=YES", "COMPRESS=DEFLATE", "TILED=TRUE"),
         tr=c(0.01,0.01), # Desired output resolution
         verbose=T,
         "/vsicurl?max_retry=3&retry_delay=1&list_dir=no&url=https://files.isric.org/soilgrids/latest/data/bdod/bdod_100-200cm_mean.vrt", # Input VRT
         "bdod_100_200.tif") # Output file
## 100-200cm uncertainty
gdalwarp(t_srs="EPSG:4326", multi=TRUE, wm=200, 
         co=c("BIGTIFF=YES", "COMPRESS=DEFLATE", "TILED=TRUE"),
         tr=c(0.01,0.01), # Desired output resolution
         verbose=T,
         "/vsicurl?max_retry=3&retry_delay=1&list_dir=no&url=https://files.isric.org/soilgrids/latest/data/bdod/bdod_100-200cm_uncertainty.vrt", # Input VRT
         "UNCbdod_100_200.tif") # Output file

#### 	Cation Exchange Capacity of the soil ####
## 0-5cm depth
gdalwarp(t_srs="EPSG:4326", multi=TRUE, wm=200, 
         co=c("BIGTIFF=YES", "COMPRESS=DEFLATE", "TILED=TRUE"),
         tr=c(0.01,0.01), # Desired output resolution
         verbose=T,
         "/vsicurl?max_retry=3&retry_delay=1&list_dir=no&url=https://files.isric.org/soilgrids/latest/data/cec/cec_0-5cm_mean.vrt", # Input VRT
         "cec_0_5.tif") # Output file
## 0-5cm uncertainty
gdalwarp(t_srs="EPSG:4326", multi=TRUE, wm=200, 
         co=c("BIGTIFF=YES", "COMPRESS=DEFLATE", "TILED=TRUE"),
         tr=c(0.01,0.01), # Desired output resolution
         verbose=T,
         "/vsicurl?max_retry=3&retry_delay=1&list_dir=no&url=https://files.isric.org/soilgrids/latest/data/cec/cec_0-5cm_uncertainty.vrt", # Input VRT
         "UNCcec_0_5.tif") # Output file
## 5-15cm depth
gdalwarp(t_srs="EPSG:4326", multi=TRUE, wm=200, 
         co=c("BIGTIFF=YES", "COMPRESS=DEFLATE", "TILED=TRUE"),
         tr=c(0.01,0.01), # Desired output resolution
         verbose=T,
         "/vsicurl?max_retry=3&retry_delay=1&list_dir=no&url=https://files.isric.org/soilgrids/latest/data/cec/cec_5-15cm_mean.vrt", # Input VRT
         "cec_5_15.tif") # Output file
## 5-15cm uncertainty
gdalwarp(t_srs="EPSG:4326", multi=TRUE, wm=200, 
         co=c("BIGTIFF=YES", "COMPRESS=DEFLATE", "TILED=TRUE"),
         tr=c(0.01,0.01), # Desired output resolution
         verbose=T,
         "/vsicurl?max_retry=3&retry_delay=1&list_dir=no&url=https://files.isric.org/soilgrids/latest/data/cec/cec_5-15cm_uncertainty.vrt", # Input VRT
         "UNCcec_5_15.tif") # Output file
## 15-30cm depth
gdalwarp(t_srs="EPSG:4326", multi=TRUE, wm=200, 
         co=c("BIGTIFF=YES", "COMPRESS=DEFLATE", "TILED=TRUE"),
         tr=c(0.01,0.01), # Desired output resolution
         verbose=T,
         "/vsicurl?max_retry=3&retry_delay=1&list_dir=no&url=https://files.isric.org/soilgrids/latest/data/cec/cec_15-30cm_mean.vrt", # Input VRT
         "cec_15_30.tif") # Output file
## 15-30cm uncertainty
gdalwarp(t_srs="EPSG:4326", multi=TRUE, wm=200, 
         co=c("BIGTIFF=YES", "COMPRESS=DEFLATE", "TILED=TRUE"),
         tr=c(0.01,0.01), # Desired output resolution
         verbose=T,
         "/vsicurl?max_retry=3&retry_delay=1&list_dir=no&url=https://files.isric.org/soilgrids/latest/data/cec/cec_15-30cm_uncertainty.vrt", # Input VRT
         "UNCcec_15_30.tif") # Output file
## 30-60cm depth
gdalwarp(t_srs="EPSG:4326", multi=TRUE, wm=200, 
         co=c("BIGTIFF=YES", "COMPRESS=DEFLATE", "TILED=TRUE"),
         tr=c(0.01,0.01), # Desired output resolution
         verbose=T,
         "/vsicurl?max_retry=3&retry_delay=1&list_dir=no&url=https://files.isric.org/soilgrids/latest/data/cec/cec_30-60cm_mean.vrt", # Input VRT
         "cec_30_60.tif") # Output file
## 30-60cm uncertainty
gdalwarp(t_srs="EPSG:4326", multi=TRUE, wm=200, 
         co=c("BIGTIFF=YES", "COMPRESS=DEFLATE", "TILED=TRUE"),
         tr=c(0.01,0.01), # Desired output resolution
         verbose=T,
         "/vsicurl?max_retry=3&retry_delay=1&list_dir=no&url=https://files.isric.org/soilgrids/latest/data/cec/cec_30-60cm_uncertainty.vrt", # Input VRT
         "UNCcec_30_60.tif") # Output file
## 60-100cm depth
gdalwarp(t_srs="EPSG:4326", multi=TRUE, wm=200, 
         co=c("BIGTIFF=YES", "COMPRESS=DEFLATE", "TILED=TRUE"),
         tr=c(0.01,0.01), # Desired output resolution
         verbose=T,
         "/vsicurl?max_retry=3&retry_delay=1&list_dir=no&url=https://files.isric.org/soilgrids/latest/data/cec/cec_60-100cm_mean.vrt", # Input VRT
         "cec_60_100.tif") # Output file
## 60-100cm uncertainty
gdalwarp(t_srs="EPSG:4326", multi=TRUE, wm=200, 
         co=c("BIGTIFF=YES", "COMPRESS=DEFLATE", "TILED=TRUE"),
         tr=c(0.01,0.01), # Desired output resolution
         verbose=T,
         "/vsicurl?max_retry=3&retry_delay=1&list_dir=no&url=https://files.isric.org/soilgrids/latest/data/cec/cec_60-100cm_uncertainty.vrt", # Input VRT
         "UNCcec_60_100.tif") # Output file
## 100-200cm depth
gdalwarp(t_srs="EPSG:4326", multi=TRUE, wm=200, 
         co=c("BIGTIFF=YES", "COMPRESS=DEFLATE", "TILED=TRUE"),
         tr=c(0.01,0.01), # Desired output resolution
         verbose=T,
         "/vsicurl?max_retry=3&retry_delay=1&list_dir=no&url=https://files.isric.org/soilgrids/latest/data/cec/cec_100-200cm_mean.vrt", # Input VRT
         "cec_100_200.tif") # Output file
## 100-200cm uncertainty
gdalwarp(t_srs="EPSG:4326", multi=TRUE, wm=200, 
         co=c("BIGTIFF=YES", "COMPRESS=DEFLATE", "TILED=TRUE"),
         tr=c(0.01,0.01), # Desired output resolution
         verbose=T,
         "/vsicurl?max_retry=3&retry_delay=1&list_dir=no&url=https://files.isric.org/soilgrids/latest/data/cec/cec_100-200cm_uncertainty.vrt", # Input VRT
         "UNCcec_100_200.tif") # Output file

#### 	Volumetric fraction of coarse fragments (> 2 mm) ####
## 0-5cm depth
gdalwarp(t_srs="EPSG:4326", multi=TRUE, wm=200, 
         co=c("BIGTIFF=YES", "COMPRESS=DEFLATE", "TILED=TRUE"),
         tr=c(0.01,0.01), # Desired output resolution
         verbose=T,
         "/vsicurl?max_retry=3&retry_delay=1&list_dir=no&url=https://files.isric.org/soilgrids/latest/data/cfvo/cfvo_0-5cm_mean.vrt", # Input VRT
         "cfvo_0_5.tif") # Output file
## 0-5cm uncertainty
gdalwarp(t_srs="EPSG:4326", multi=TRUE, wm=200, 
         co=c("BIGTIFF=YES", "COMPRESS=DEFLATE", "TILED=TRUE"),
         tr=c(0.01,0.01), # Desired output resolution
         verbose=T,
         "/vsicurl?max_retry=3&retry_delay=1&list_dir=no&url=https://files.isric.org/soilgrids/latest/data/cfvo/cfvo_0-5cm_uncertainty.vrt", # Input VRT
         "UNCcfvo_0_5.tif") # Output file
## 5-15cm depth
gdalwarp(t_srs="EPSG:4326", multi=TRUE, wm=200, 
         co=c("BIGTIFF=YES", "COMPRESS=DEFLATE", "TILED=TRUE"),
         tr=c(0.01,0.01), # Desired output resolution
         verbose=T,
         "/vsicurl?max_retry=3&retry_delay=1&list_dir=no&url=https://files.isric.org/soilgrids/latest/data/cfvo/cfvo_5-15cm_mean.vrt", # Input VRT
         "cfvo_5_15.tif") # Output file
## 5-15cm uncertainty
gdalwarp(t_srs="EPSG:4326", multi=TRUE, wm=200, 
         co=c("BIGTIFF=YES", "COMPRESS=DEFLATE", "TILED=TRUE"),
         tr=c(0.01,0.01), # Desired output resolution
         verbose=T,
         "/vsicurl?max_retry=3&retry_delay=1&list_dir=no&url=https://files.isric.org/soilgrids/latest/data/cfvo/cfvo_5-15cm_uncertainty.vrt", # Input VRT
         "UNCcfvo_5_15.tif") # Output file
## 15-30cm depth
gdalwarp(t_srs="EPSG:4326", multi=TRUE, wm=200, 
         co=c("BIGTIFF=YES", "COMPRESS=DEFLATE", "TILED=TRUE"),
         tr=c(0.01,0.01), # Desired output resolution
         verbose=T,
         "/vsicurl?max_retry=3&retry_delay=1&list_dir=no&url=https://files.isric.org/soilgrids/latest/data/cfvo/cfvo_15-30cm_mean.vrt", # Input VRT
         "cfvo_15_30.tif") # Output file
## 15-30cm uncertainty
gdalwarp(t_srs="EPSG:4326", multi=TRUE, wm=200, 
         co=c("BIGTIFF=YES", "COMPRESS=DEFLATE", "TILED=TRUE"),
         tr=c(0.01,0.01), # Desired output resolution
         verbose=T,
         "/vsicurl?max_retry=3&retry_delay=1&list_dir=no&url=https://files.isric.org/soilgrids/latest/data/cfvo/cfvo_15-30cm_uncertainty.vrt", # Input VRT
         "UNCcfvo_15_30.tif") # Output file
## 30-60cm depth
gdalwarp(t_srs="EPSG:4326", multi=TRUE, wm=200, 
         co=c("BIGTIFF=YES", "COMPRESS=DEFLATE", "TILED=TRUE"),
         tr=c(0.01,0.01), # Desired output resolution
         verbose=T,
         "/vsicurl?max_retry=3&retry_delay=1&list_dir=no&url=https://files.isric.org/soilgrids/latest/data/cfvo/cfvo_30-60cm_mean.vrt", # Input VRT
         "cfvo_30_60.tif") # Output file
## 30-60cm uncertainty
gdalwarp(t_srs="EPSG:4326", multi=TRUE, wm=200, 
         co=c("BIGTIFF=YES", "COMPRESS=DEFLATE", "TILED=TRUE"),
         tr=c(0.01,0.01), # Desired output resolution
         verbose=T,
         "/vsicurl?max_retry=3&retry_delay=1&list_dir=no&url=https://files.isric.org/soilgrids/latest/data/cfvo/cfvo_30-60cm_uncertainty.vrt", # Input VRT
         "UNCcfvo_30_60.tif") # Output file
## 60-100cm depth
gdalwarp(t_srs="EPSG:4326", multi=TRUE, wm=200, 
         co=c("BIGTIFF=YES", "COMPRESS=DEFLATE", "TILED=TRUE"),
         tr=c(0.01,0.01), # Desired output resolution
         verbose=T,
         "/vsicurl?max_retry=3&retry_delay=1&list_dir=no&url=https://files.isric.org/soilgrids/latest/data/cfvo/cfvo_60-100cm_mean.vrt", # Input VRT
         "cfvo_60_100.tif") # Output file
## 60-100cm uncertainty
gdalwarp(t_srs="EPSG:4326", multi=TRUE, wm=200, 
         co=c("BIGTIFF=YES", "COMPRESS=DEFLATE", "TILED=TRUE"),
         tr=c(0.01,0.01), # Desired output resolution
         verbose=T,
         "/vsicurl?max_retry=3&retry_delay=1&list_dir=no&url=https://files.isric.org/soilgrids/latest/data/cfvo/cfvo_60-100cm_uncertainty.vrt", # Input VRT
         "UNCcfvo_60_100.tif") # Output file
## 100-200cm depth
gdalwarp(t_srs="EPSG:4326", multi=TRUE, wm=200, 
         co=c("BIGTIFF=YES", "COMPRESS=DEFLATE", "TILED=TRUE"),
         tr=c(0.01,0.01), # Desired output resolution
         verbose=T,
         "/vsicurl?max_retry=3&retry_delay=1&list_dir=no&url=https://files.isric.org/soilgrids/latest/data/cfvo/cfvo_100-200cm_mean.vrt", # Input VRT
         "cfvo_100_200.tif") # Output file
## 100-200cm uncertainty
gdalwarp(t_srs="EPSG:4326", multi=TRUE, wm=200, 
         co=c("BIGTIFF=YES", "COMPRESS=DEFLATE", "TILED=TRUE"),
         tr=c(0.01,0.01), # Desired output resolution
         verbose=T,
         "/vsicurl?max_retry=3&retry_delay=1&list_dir=no&url=https://files.isric.org/soilgrids/latest/data/cfvo/cfvo_100-200cm_uncertainty.vrt", # Input VRT
         "UNCcfvo_100_200.tif") # Output file

#### 	Proportion of clay particles (< 0.002 mm) in the fine earth fraction (> 2 mm) ####
## 0-5cm depth
gdalwarp(t_srs="EPSG:4326", multi=TRUE, wm=200, 
         co=c("BIGTIFF=YES", "COMPRESS=DEFLATE", "TILED=TRUE"),
         tr=c(0.01,0.01), # Desired output resolution
         verbose=T,
         "/vsicurl?max_retry=3&retry_delay=1&list_dir=no&url=https://files.isric.org/soilgrids/latest/data/clay/clay_0-5cm_mean.vrt", # Input VRT
         "clay_0_5.tif") # Output file
## 0-5cm uncertainty
gdalwarp(t_srs="EPSG:4326", multi=TRUE, wm=200, 
         co=c("BIGTIFF=YES", "COMPRESS=DEFLATE", "TILED=TRUE"),
         tr=c(0.01,0.01), # Desired output resolution
         verbose=T,
         "/vsicurl?max_retry=3&retry_delay=1&list_dir=no&url=https://files.isric.org/soilgrids/latest/data/clay/clay_0-5cm_uncertainty.vrt", # Input VRT
         "UNCclay_0_5.tif") # Output file
## 5-15cm depth
gdalwarp(t_srs="EPSG:4326", multi=TRUE, wm=200, 
         co=c("BIGTIFF=YES", "COMPRESS=DEFLATE", "TILED=TRUE"),
         tr=c(0.01,0.01), # Desired output resolution
         verbose=T,
         "/vsicurl?max_retry=3&retry_delay=1&list_dir=no&url=https://files.isric.org/soilgrids/latest/data/clay/clay_5-15cm_mean.vrt", # Input VRT
         "clay_5_15.tif") # Output file
## 5-15cm uncertainty
gdalwarp(t_srs="EPSG:4326", multi=TRUE, wm=200, 
         co=c("BIGTIFF=YES", "COMPRESS=DEFLATE", "TILED=TRUE"),
         tr=c(0.01,0.01), # Desired output resolution
         verbose=T,
         "/vsicurl?max_retry=3&retry_delay=1&list_dir=no&url=https://files.isric.org/soilgrids/latest/data/clay/clay_5-15cm_uncertainty.vrt", # Input VRT
         "UNCclay_5_15.tif") # Output file
## 15-30cm depth
gdalwarp(t_srs="EPSG:4326", multi=TRUE, wm=200, 
         co=c("BIGTIFF=YES", "COMPRESS=DEFLATE", "TILED=TRUE"),
         tr=c(0.01,0.01), # Desired output resolution
         verbose=T,
         "/vsicurl?max_retry=3&retry_delay=1&list_dir=no&url=https://files.isric.org/soilgrids/latest/data/clay/clay_15-30cm_mean.vrt", # Input VRT
         "clay_15_30.tif") # Output file
## 15-30cm uncertainty
gdalwarp(t_srs="EPSG:4326", multi=TRUE, wm=200, 
         co=c("BIGTIFF=YES", "COMPRESS=DEFLATE", "TILED=TRUE"),
         tr=c(0.01,0.01), # Desired output resolution
         verbose=T,
         "/vsicurl?max_retry=3&retry_delay=1&list_dir=no&url=https://files.isric.org/soilgrids/latest/data/clay/clay_15-30cm_uncertainty.vrt", # Input VRT
         "UNCclay_15_30.tif") # Output file
## 30-60cm depth
gdalwarp(t_srs="EPSG:4326", multi=TRUE, wm=200, 
         co=c("BIGTIFF=YES", "COMPRESS=DEFLATE", "TILED=TRUE"),
         tr=c(0.01,0.01), # Desired output resolution
         verbose=T,
         "/vsicurl?max_retry=3&retry_delay=1&list_dir=no&url=https://files.isric.org/soilgrids/latest/data/clay/clay_30-60cm_mean.vrt", # Input VRT
         "clay_30_60.tif") # Output file
## 30-60cm uncertainty
gdalwarp(t_srs="EPSG:4326", multi=TRUE, wm=200, 
         co=c("BIGTIFF=YES", "COMPRESS=DEFLATE", "TILED=TRUE"),
         tr=c(0.01,0.01), # Desired output resolution
         verbose=T,
         "/vsicurl?max_retry=3&retry_delay=1&list_dir=no&url=https://files.isric.org/soilgrids/latest/data/clay/clay_30-60cm_uncertainty.vrt", # Input VRT
         "UNCclay_30_60.tif") # Output file
## 60-100cm depth
gdalwarp(t_srs="EPSG:4326", multi=TRUE, wm=200, 
         co=c("BIGTIFF=YES", "COMPRESS=DEFLATE", "TILED=TRUE"),
         tr=c(0.01,0.01), # Desired output resolution
         verbose=T,
         "/vsicurl?max_retry=3&retry_delay=1&list_dir=no&url=https://files.isric.org/soilgrids/latest/data/clay/clay_60-100cm_mean.vrt", # Input VRT
         "clay_60_100.tif") # Output file
## 60-100cm uncertainty
gdalwarp(t_srs="EPSG:4326", multi=TRUE, wm=200, 
         co=c("BIGTIFF=YES", "COMPRESS=DEFLATE", "TILED=TRUE"),
         tr=c(0.01,0.01), # Desired output resolution
         verbose=T,
         "/vsicurl?max_retry=3&retry_delay=1&list_dir=no&url=https://files.isric.org/soilgrids/latest/data/clay/clay_60-100cm_uncertainty.vrt", # Input VRT
         "UNCclay_60_100.tif") # Output file
## 100-200cm depth
gdalwarp(t_srs="EPSG:4326", multi=TRUE, wm=200, 
         co=c("BIGTIFF=YES", "COMPRESS=DEFLATE", "TILED=TRUE"),
         tr=c(0.01,0.01), # Desired output resolution
         verbose=T,
         "/vsicurl?max_retry=3&retry_delay=1&list_dir=no&url=https://files.isric.org/soilgrids/latest/data/clay/clay_100-200cm_mean.vrt", # Input VRT
         "clay_100_200.tif") # Output file
## 100-200cm uncertainty
gdalwarp(t_srs="EPSG:4326", multi=TRUE, wm=200, 
         co=c("BIGTIFF=YES", "COMPRESS=DEFLATE", "TILED=TRUE"),
         tr=c(0.01,0.01), # Desired output resolution
         verbose=T,
         "/vsicurl?max_retry=3&retry_delay=1&list_dir=no&url=https://files.isric.org/soilgrids/latest/data/clay/clay_100-200cm_uncertainty.vrt", # Input VRT
         "UNCclay_100_200.tif") # Output file

#### 	Total nitrogen (N) ####
## 0-5cm depth
gdalwarp(t_srs="EPSG:4326", multi=TRUE, wm=200, 
         co=c("BIGTIFF=YES", "COMPRESS=DEFLATE", "TILED=TRUE"),
         tr=c(0.01,0.01), # Desired output resolution
         verbose=T,
         "/vsicurl?max_retry=3&retry_delay=1&list_dir=no&url=https://files.isric.org/soilgrids/latest/data/nitrogen/nitrogen_0-5cm_mean.vrt", # Input VRT
         "nitrogen_0_5.tif") # Output file
## 0-5cm uncertainty
gdalwarp(t_srs="EPSG:4326", multi=TRUE, wm=200, 
         co=c("BIGTIFF=YES", "COMPRESS=DEFLATE", "TILED=TRUE"),
         tr=c(0.01,0.01), # Desired output resolution
         verbose=T,
         "/vsicurl?max_retry=3&retry_delay=1&list_dir=no&url=https://files.isric.org/soilgrids/latest/data/nitrogen/nitrogen_0-5cm_uncertainty.vrt", # Input VRT
         "UNCnitrogen_0_5.tif") # Output file
## 5-15cm depth
gdalwarp(t_srs="EPSG:4326", multi=TRUE, wm=200, 
         co=c("BIGTIFF=YES", "COMPRESS=DEFLATE", "TILED=TRUE"),
         tr=c(0.01,0.01), # Desired output resolution
         verbose=T,
         "/vsicurl?max_retry=3&retry_delay=1&list_dir=no&url=https://files.isric.org/soilgrids/latest/data/nitrogen/nitrogen_5-15cm_mean.vrt", # Input VRT
         "nitrogen_5_15.tif") # Output file
## 5-15cm uncertainty
gdalwarp(t_srs="EPSG:4326", multi=TRUE, wm=200, 
         co=c("BIGTIFF=YES", "COMPRESS=DEFLATE", "TILED=TRUE"),
         tr=c(0.01,0.01), # Desired output resolution
         verbose=T,
         "/vsicurl?max_retry=3&retry_delay=1&list_dir=no&url=https://files.isric.org/soilgrids/latest/data/nitrogen/nitrogen_5-15cm_uncertainty.vrt", # Input VRT
         "UNCnitrogen_5_15.tif") # Output file
## 15-30cm depth
gdalwarp(t_srs="EPSG:4326", multi=TRUE, wm=200, 
         co=c("BIGTIFF=YES", "COMPRESS=DEFLATE", "TILED=TRUE"),
         tr=c(0.01,0.01), # Desired output resolution
         verbose=T,
         "/vsicurl?max_retry=3&retry_delay=1&list_dir=no&url=https://files.isric.org/soilgrids/latest/data/nitrogen/nitrogen_15-30cm_mean.vrt", # Input VRT
         "nitrogen_15_30.tif") # Output file
## 15-30cm uncertainty
gdalwarp(t_srs="EPSG:4326", multi=TRUE, wm=200, 
         co=c("BIGTIFF=YES", "COMPRESS=DEFLATE", "TILED=TRUE"),
         tr=c(0.01,0.01), # Desired output resolution
         verbose=T,
         "/vsicurl?max_retry=3&retry_delay=1&list_dir=no&url=https://files.isric.org/soilgrids/latest/data/nitrogen/nitrogen_15-30cm_uncertainty.vrt", # Input VRT
         "UNCnitrogen_15_30.tif") # Output file
## 30-60cm depth
gdalwarp(t_srs="EPSG:4326", multi=TRUE, wm=200, 
         co=c("BIGTIFF=YES", "COMPRESS=DEFLATE", "TILED=TRUE"),
         tr=c(0.01,0.01), # Desired output resolution
         verbose=T,
         "/vsicurl?max_retry=3&retry_delay=1&list_dir=no&url=https://files.isric.org/soilgrids/latest/data/nitrogen/nitrogen_30-60cm_mean.vrt", # Input VRT
         "nitrogen_30_60.tif") # Output file
## 30-60cm uncertainty
gdalwarp(t_srs="EPSG:4326", multi=TRUE, wm=200, 
         co=c("BIGTIFF=YES", "COMPRESS=DEFLATE", "TILED=TRUE"),
         tr=c(0.01,0.01), # Desired output resolution
         verbose=T,
         "/vsicurl?max_retry=3&retry_delay=1&list_dir=no&url=https://files.isric.org/soilgrids/latest/data/nitrogen/nitrogen_30-60cm_uncertainty.vrt", # Input VRT
         "UNCnitrogen_30_60.tif") # Output file
## 60-100cm depth
gdalwarp(t_srs="EPSG:4326", multi=TRUE, wm=200, 
         co=c("BIGTIFF=YES", "COMPRESS=DEFLATE", "TILED=TRUE"),
         tr=c(0.01,0.01), # Desired output resolution
         verbose=T,
         "/vsicurl?max_retry=3&retry_delay=1&list_dir=no&url=https://files.isric.org/soilgrids/latest/data/nitrogen/nitrogen_60-100cm_mean.vrt", # Input VRT
         "nitrogen_60_100.tif") # Output file
## 60-100cm uncertainty
gdalwarp(t_srs="EPSG:4326", multi=TRUE, wm=200, 
         co=c("BIGTIFF=YES", "COMPRESS=DEFLATE", "TILED=TRUE"),
         tr=c(0.01,0.01), # Desired output resolution
         verbose=T,
         "/vsicurl?max_retry=3&retry_delay=1&list_dir=no&url=https://files.isric.org/soilgrids/latest/data/nitrogen/nitrogen_60-100cm_uncertainty.vrt", # Input VRT
         "UNCnitrogen_60_100.tif") # Output file
## 100-200cm depth
gdalwarp(t_srs="EPSG:4326", multi=TRUE, wm=200, 
         co=c("BIGTIFF=YES", "COMPRESS=DEFLATE", "TILED=TRUE"),
         tr=c(0.01,0.01), # Desired output resolution
         verbose=T,
         "/vsicurl?max_retry=3&retry_delay=1&list_dir=no&url=https://files.isric.org/soilgrids/latest/data/nitrogen/nitrogen_100-200cm_mean.vrt", # Input VRT
         "nitrogen_100_200.tif") # Output file
## 100-200cm uncertainty
gdalwarp(t_srs="EPSG:4326", multi=TRUE, wm=200, 
         co=c("BIGTIFF=YES", "COMPRESS=DEFLATE", "TILED=TRUE"),
         tr=c(0.01,0.01), # Desired output resolution
         verbose=T,
         "/vsicurl?max_retry=3&retry_delay=1&list_dir=no&url=https://files.isric.org/soilgrids/latest/data/nitrogen/nitrogen_100-200cm_uncertainty.vrt", # Input VRT
         "UNCnitrogen_100_200.tif") # Output file

#### 	Soil pH ####
## 0-5cm depth
gdalwarp(t_srs="EPSG:4326", multi=TRUE, wm=200, 
         co=c("BIGTIFF=YES", "COMPRESS=DEFLATE", "TILED=TRUE"),
         tr=c(0.01,0.01), # Desired output resolution
         verbose=T,
         "/vsicurl?max_retry=3&retry_delay=1&list_dir=no&url=https://files.isric.org/soilgrids/latest/data/phh2o/phh2o_0-5cm_mean.vrt", # Input VRT
         "phh2o_0_5.tif") # Output file
## 0-5cm uncertainty
gdalwarp(t_srs="EPSG:4326", multi=TRUE, wm=200, 
         co=c("BIGTIFF=YES", "COMPRESS=DEFLATE", "TILED=TRUE"),
         tr=c(0.01,0.01), # Desired output resolution
         verbose=T,
         "/vsicurl?max_retry=3&retry_delay=1&list_dir=no&url=https://files.isric.org/soilgrids/latest/data/phh2o/phh2o_0-5cm_uncertainty.vrt", # Input VRT
         "UNCphh2o_0_5.tif") # Output file
## 5-15cm depth
gdalwarp(t_srs="EPSG:4326", multi=TRUE, wm=200, 
         co=c("BIGTIFF=YES", "COMPRESS=DEFLATE", "TILED=TRUE"),
         tr=c(0.01,0.01), # Desired output resolution
         verbose=T,
         "/vsicurl?max_retry=3&retry_delay=1&list_dir=no&url=https://files.isric.org/soilgrids/latest/data/phh2o/phh2o_5-15cm_mean.vrt", # Input VRT
         "phh2o_5_15.tif") # Output file
## 5-15cm uncertainty
gdalwarp(t_srs="EPSG:4326", multi=TRUE, wm=200, 
         co=c("BIGTIFF=YES", "COMPRESS=DEFLATE", "TILED=TRUE"),
         tr=c(0.01,0.01), # Desired output resolution
         verbose=T,
         "/vsicurl?max_retry=3&retry_delay=1&list_dir=no&url=https://files.isric.org/soilgrids/latest/data/phh2o/phh2o_5-15cm_uncertainty.vrt", # Input VRT
         "UNCphh2o_5_15.tif") # Output file
## 15-30cm depth
gdalwarp(t_srs="EPSG:4326", multi=TRUE, wm=200, 
         co=c("BIGTIFF=YES", "COMPRESS=DEFLATE", "TILED=TRUE"),
         tr=c(0.01,0.01), # Desired output resolution
         verbose=T,
         "/vsicurl?max_retry=3&retry_delay=1&list_dir=no&url=https://files.isric.org/soilgrids/latest/data/phh2o/phh2o_15-30cm_mean.vrt", # Input VRT
         "phh2o_15_30.tif") # Output file
## 15-30cm uncertainty
gdalwarp(t_srs="EPSG:4326", multi=TRUE, wm=200, 
         co=c("BIGTIFF=YES", "COMPRESS=DEFLATE", "TILED=TRUE"),
         tr=c(0.01,0.01), # Desired output resolution
         verbose=T,
         "/vsicurl?max_retry=3&retry_delay=1&list_dir=no&url=https://files.isric.org/soilgrids/latest/data/phh2o/phh2o_15-30cm_uncertainty.vrt", # Input VRT
         "UNCphh2o_15_30.tif") # Output file
## 30-60cm depth
gdalwarp(t_srs="EPSG:4326", multi=TRUE, wm=200, 
         co=c("BIGTIFF=YES", "COMPRESS=DEFLATE", "TILED=TRUE"),
         tr=c(0.01,0.01), # Desired output resolution
         verbose=T,
         "/vsicurl?max_retry=3&retry_delay=1&list_dir=no&url=https://files.isric.org/soilgrids/latest/data/phh2o/phh2o_30-60cm_mean.vrt", # Input VRT
         "phh2o_30_60.tif") # Output file
## 30-60cm uncertainty
gdalwarp(t_srs="EPSG:4326", multi=TRUE, wm=200, 
         co=c("BIGTIFF=YES", "COMPRESS=DEFLATE", "TILED=TRUE"),
         tr=c(0.01,0.01), # Desired output resolution
         verbose=T,
         "/vsicurl?max_retry=3&retry_delay=1&list_dir=no&url=https://files.isric.org/soilgrids/latest/data/phh2o/phh2o_30-60cm_uncertainty.vrt", # Input VRT
         "UNCphh2o_30_60.tif") # Output file
## 60-100cm depth
gdalwarp(t_srs="EPSG:4326", multi=TRUE, wm=200, 
         co=c("BIGTIFF=YES", "COMPRESS=DEFLATE", "TILED=TRUE"),
         tr=c(0.01,0.01), # Desired output resolution
         verbose=T,
         "/vsicurl?max_retry=3&retry_delay=1&list_dir=no&url=https://files.isric.org/soilgrids/latest/data/phh2o/phh2o_60-100cm_mean.vrt", # Input VRT
         "phh2o_60_100.tif") # Output file
## 60-100cm uncertainty
gdalwarp(t_srs="EPSG:4326", multi=TRUE, wm=200, 
         co=c("BIGTIFF=YES", "COMPRESS=DEFLATE", "TILED=TRUE"),
         tr=c(0.01,0.01), # Desired output resolution
         verbose=T,
         "/vsicurl?max_retry=3&retry_delay=1&list_dir=no&url=https://files.isric.org/soilgrids/latest/data/phh2o/phh2o_60-100cm_uncertainty.vrt", # Input VRT
         "UNCphh2o_60_100.tif") # Output file
## 100-200cm depth
gdalwarp(t_srs="EPSG:4326", multi=TRUE, wm=200, 
         co=c("BIGTIFF=YES", "COMPRESS=DEFLATE", "TILED=TRUE"),
         tr=c(0.01,0.01), # Desired output resolution
         verbose=T,
         "/vsicurl?max_retry=3&retry_delay=1&list_dir=no&url=https://files.isric.org/soilgrids/latest/data/phh2o/phh2o_100-200cm_mean.vrt", # Input VRT
         "phh2o_100_200.tif") # Output file
## 100-200cm uncertainty
gdalwarp(t_srs="EPSG:4326", multi=TRUE, wm=200, 
         co=c("BIGTIFF=YES", "COMPRESS=DEFLATE", "TILED=TRUE"),
         tr=c(0.01,0.01), # Desired output resolution
         verbose=T,
         "/vsicurl?max_retry=3&retry_delay=1&list_dir=no&url=https://files.isric.org/soilgrids/latest/data/phh2o/phh2o_100-200cm_uncertainty.vrt", # Input VRT
         "UNCphh2o_100_200.tif") # Output file

#### Proportion of sand particles (> 0.05 mm) in the fine earth fraction ####
## 0-5cm depth
gdalwarp(t_srs="EPSG:4326", multi=TRUE, wm=200, 
         co=c("BIGTIFF=YES", "COMPRESS=DEFLATE", "TILED=TRUE"),
         tr=c(0.01,0.01), # Desired output resolution
         verbose=T,
         "/vsicurl?max_retry=3&retry_delay=1&list_dir=no&url=https://files.isric.org/soilgrids/latest/data/sand/sand_0-5cm_mean.vrt", # Input VRT
         "sand_0_5.tif") # Output file
## 0-5cm uncertainty
gdalwarp(t_srs="EPSG:4326", multi=TRUE, wm=200, 
         co=c("BIGTIFF=YES", "COMPRESS=DEFLATE", "TILED=TRUE"),
         tr=c(0.01,0.01), # Desired output resolution
         verbose=T,
         "/vsicurl?max_retry=3&retry_delay=1&list_dir=no&url=https://files.isric.org/soilgrids/latest/data/sand/sand_0-5cm_uncertainty.vrt", # Input VRT
         "UNCsand_0_5.tif") # Output file
## 5-15cm depth
gdalwarp(t_srs="EPSG:4326", multi=TRUE, wm=200, 
         co=c("BIGTIFF=YES", "COMPRESS=DEFLATE", "TILED=TRUE"),
         tr=c(0.01,0.01), # Desired output resolution
         verbose=T,
         "/vsicurl?max_retry=3&retry_delay=1&list_dir=no&url=https://files.isric.org/soilgrids/latest/data/sand/sand_5-15cm_mean.vrt", # Input VRT
         "sand_5_15.tif") # Output file
## 5-15cm uncertainty
gdalwarp(t_srs="EPSG:4326", multi=TRUE, wm=200, 
         co=c("BIGTIFF=YES", "COMPRESS=DEFLATE", "TILED=TRUE"),
         tr=c(0.01,0.01), # Desired output resolution
         verbose=T,
         "/vsicurl?max_retry=3&retry_delay=1&list_dir=no&url=https://files.isric.org/soilgrids/latest/data/sand/sand_5-15cm_uncertainty.vrt", # Input VRT
         "UNCsand_5_15.tif") # Output file
## 15-30cm depth
gdalwarp(t_srs="EPSG:4326", multi=TRUE, wm=200, 
         co=c("BIGTIFF=YES", "COMPRESS=DEFLATE", "TILED=TRUE"),
         tr=c(0.01,0.01), # Desired output resolution
         verbose=T,
         "/vsicurl?max_retry=3&retry_delay=1&list_dir=no&url=https://files.isric.org/soilgrids/latest/data/sand/sand_15-30cm_mean.vrt", # Input VRT
         "sand_15_30.tif") # Output file
## 15-30cm uncertainty
gdalwarp(t_srs="EPSG:4326", multi=TRUE, wm=200, 
         co=c("BIGTIFF=YES", "COMPRESS=DEFLATE", "TILED=TRUE"),
         tr=c(0.01,0.01), # Desired output resolution
         verbose=T,
         "/vsicurl?max_retry=3&retry_delay=1&list_dir=no&url=https://files.isric.org/soilgrids/latest/data/sand/sand_15-30cm_uncertainty.vrt", # Input VRT
         "UNCsand_15_30.tif") # Output file
## 30-60cm depth
gdalwarp(t_srs="EPSG:4326", multi=TRUE, wm=200, 
         co=c("BIGTIFF=YES", "COMPRESS=DEFLATE", "TILED=TRUE"),
         tr=c(0.01,0.01), # Desired output resolution
         verbose=T,
         "/vsicurl?max_retry=3&retry_delay=1&list_dir=no&url=https://files.isric.org/soilgrids/latest/data/sand/sand_30-60cm_mean.vrt", # Input VRT
         "sand_30_60.tif") # Output file
## 30-60cm uncertainty
gdalwarp(t_srs="EPSG:4326", multi=TRUE, wm=200, 
         co=c("BIGTIFF=YES", "COMPRESS=DEFLATE", "TILED=TRUE"),
         tr=c(0.01,0.01), # Desired output resolution
         verbose=T,
         "/vsicurl?max_retry=3&retry_delay=1&list_dir=no&url=https://files.isric.org/soilgrids/latest/data/sand/sand_30-60cm_uncertainty.vrt", # Input VRT
         "UNCsand_30_60.tif") # Output file
## 60-100cm depth
gdalwarp(t_srs="EPSG:4326", multi=TRUE, wm=200, 
         co=c("BIGTIFF=YES", "COMPRESS=DEFLATE", "TILED=TRUE"),
         tr=c(0.01,0.01), # Desired output resolution
         verbose=T,
         "/vsicurl?max_retry=3&retry_delay=1&list_dir=no&url=https://files.isric.org/soilgrids/latest/data/sand/sand_60-100cm_mean.vrt", # Input VRT
         "sand_60_100.tif") # Output file
## 60-100cm uncertainty
gdalwarp(t_srs="EPSG:4326", multi=TRUE, wm=200, 
         co=c("BIGTIFF=YES", "COMPRESS=DEFLATE", "TILED=TRUE"),
         tr=c(0.01,0.01), # Desired output resolution
         verbose=T,
         "/vsicurl?max_retry=3&retry_delay=1&list_dir=no&url=https://files.isric.org/soilgrids/latest/data/sand/sand_60-100cm_uncertainty.vrt", # Input VRT
         "UNCsand_60_100.tif") # Output file
## 100-200cm depth
gdalwarp(t_srs="EPSG:4326", multi=TRUE, wm=200, 
         co=c("BIGTIFF=YES", "COMPRESS=DEFLATE", "TILED=TRUE"),
         tr=c(0.01,0.01), # Desired output resolution
         verbose=T,
         "/vsicurl?max_retry=3&retry_delay=1&list_dir=no&url=https://files.isric.org/soilgrids/latest/data/sand/sand_100-200cm_mean.vrt", # Input VRT
         "sand_100_200.tif") # Output file
## 100-200cm uncertainty
gdalwarp(t_srs="EPSG:4326", multi=TRUE, wm=200, 
         co=c("BIGTIFF=YES", "COMPRESS=DEFLATE", "TILED=TRUE"),
         tr=c(0.01,0.01), # Desired output resolution
         verbose=T,
         "/vsicurl?max_retry=3&retry_delay=1&list_dir=no&url=https://files.isric.org/soilgrids/latest/data/sand/sand_100-200cm_uncertainty.vrt", # Input VRT
         "UNCsand_100_200.tif") # Output file

#### Proportion of silt particles (≥ 0.002 mm and ≤ 0.05 mm) in the fine earth fraction ####
## 0-5cm depth
gdalwarp(t_srs="EPSG:4326", multi=TRUE, wm=200, 
         co=c("BIGTIFF=YES", "COMPRESS=DEFLATE", "TILED=TRUE"),
         tr=c(0.01,0.01), # Desired output resolution
         verbose=T,
         "/vsicurl?max_retry=3&retry_delay=1&list_dir=no&url=https://files.isric.org/soilgrids/latest/data/silt/silt_0-5cm_mean.vrt", # Input VRT
         "silt_0_5.tif") # Output file
## 0-5cm uncertainty
gdalwarp(t_srs="EPSG:4326", multi=TRUE, wm=200, 
         co=c("BIGTIFF=YES", "COMPRESS=DEFLATE", "TILED=TRUE"),
         tr=c(0.01,0.01), # Desired output resolution
         verbose=T,
         "/vsicurl?max_retry=3&retry_delay=1&list_dir=no&url=https://files.isric.org/soilgrids/latest/data/silt/silt_0-5cm_uncertainty.vrt", # Input VRT
         "UNCsilt_0_5.tif") # Output file
## 5-15cm depth
gdalwarp(t_srs="EPSG:4326", multi=TRUE, wm=200, 
         co=c("BIGTIFF=YES", "COMPRESS=DEFLATE", "TILED=TRUE"),
         tr=c(0.01,0.01), # Desired output resolution
         verbose=T,
         "/vsicurl?max_retry=3&retry_delay=1&list_dir=no&url=https://files.isric.org/soilgrids/latest/data/silt/silt_5-15cm_mean.vrt", # Input VRT
         "silt_5_15.tif") # Output file
## 5-15cm uncertainty
gdalwarp(t_srs="EPSG:4326", multi=TRUE, wm=200, 
         co=c("BIGTIFF=YES", "COMPRESS=DEFLATE", "TILED=TRUE"),
         tr=c(0.01,0.01), # Desired output resolution
         verbose=T,
         "/vsicurl?max_retry=3&retry_delay=1&list_dir=no&url=https://files.isric.org/soilgrids/latest/data/silt/silt_5-15cm_uncertainty.vrt", # Input VRT
         "UNCsilt_5_15.tif") # Output file
## 15-30cm depth
gdalwarp(t_srs="EPSG:4326", multi=TRUE, wm=200, 
         co=c("BIGTIFF=YES", "COMPRESS=DEFLATE", "TILED=TRUE"),
         tr=c(0.01,0.01), # Desired output resolution
         verbose=T,
         "/vsicurl?max_retry=3&retry_delay=1&list_dir=no&url=https://files.isric.org/soilgrids/latest/data/silt/silt_15-30cm_mean.vrt", # Input VRT
         "silt_15_30.tif") # Output file
## 15-30cm uncertainty
gdalwarp(t_srs="EPSG:4326", multi=TRUE, wm=200, 
         co=c("BIGTIFF=YES", "COMPRESS=DEFLATE", "TILED=TRUE"),
         tr=c(0.01,0.01), # Desired output resolution
         verbose=T,
         "/vsicurl?max_retry=3&retry_delay=1&list_dir=no&url=https://files.isric.org/soilgrids/latest/data/silt/silt_15-30cm_uncertainty.vrt", # Input VRT
         "UNCsilt_15_30.tif") # Output file
## 30-60cm depth
gdalwarp(t_srs="EPSG:4326", multi=TRUE, wm=200, 
         co=c("BIGTIFF=YES", "COMPRESS=DEFLATE", "TILED=TRUE"),
         tr=c(0.01,0.01), # Desired output resolution
         verbose=T,
         "/vsicurl?max_retry=3&retry_delay=1&list_dir=no&url=https://files.isric.org/soilgrids/latest/data/silt/silt_30-60cm_mean.vrt", # Input VRT
         "silt_30_60.tif") # Output file
## 30-60cm uncertainty
gdalwarp(t_srs="EPSG:4326", multi=TRUE, wm=200, 
         co=c("BIGTIFF=YES", "COMPRESS=DEFLATE", "TILED=TRUE"),
         tr=c(0.01,0.01), # Desired output resolution
         verbose=T,
         "/vsicurl?max_retry=3&retry_delay=1&list_dir=no&url=https://files.isric.org/soilgrids/latest/data/silt/silt_30-60cm_uncertainty.vrt", # Input VRT
         "UNCsilt_30_60.tif") # Output file
## 60-100cm depth
gdalwarp(t_srs="EPSG:4326", multi=TRUE, wm=200, 
         co=c("BIGTIFF=YES", "COMPRESS=DEFLATE", "TILED=TRUE"),
         tr=c(0.01,0.01), # Desired output resolution
         verbose=T,
         "/vsicurl?max_retry=3&retry_delay=1&list_dir=no&url=https://files.isric.org/soilgrids/latest/data/silt/silt_60-100cm_mean.vrt", # Input VRT
         "silt_60_100.tif") # Output file
## 60-100cm uncertainty
gdalwarp(t_srs="EPSG:4326", multi=TRUE, wm=200, 
         co=c("BIGTIFF=YES", "COMPRESS=DEFLATE", "TILED=TRUE"),
         tr=c(0.01,0.01), # Desired output resolution
         verbose=T,
         "/vsicurl?max_retry=3&retry_delay=1&list_dir=no&url=https://files.isric.org/soilgrids/latest/data/silt/silt_60-100cm_uncertainty.vrt", # Input VRT
         "UNCsilt_60_100.tif") # Output file
## 100-200cm depth
gdalwarp(t_srs="EPSG:4326", multi=TRUE, wm=200, 
         co=c("BIGTIFF=YES", "COMPRESS=DEFLATE", "TILED=TRUE"),
         tr=c(0.01,0.01), # Desired output resolution
         verbose=T,
         "/vsicurl?max_retry=3&retry_delay=1&list_dir=no&url=https://files.isric.org/soilgrids/latest/data/silt/silt_100-200cm_mean.vrt", # Input VRT
         "silt_100_200.tif") # Output file
## 100-200cm uncertainty
gdalwarp(t_srs="EPSG:4326", multi=TRUE, wm=200, 
         co=c("BIGTIFF=YES", "COMPRESS=DEFLATE", "TILED=TRUE"),
         tr=c(0.01,0.01), # Desired output resolution
         verbose=T,
         "/vsicurl?max_retry=3&retry_delay=1&list_dir=no&url=https://files.isric.org/soilgrids/latest/data/silt/silt_100-200cm_uncertainty.vrt", # Input VRT
         "UNCsilt_100_200.tif") # Output file

#### 	Soil organic carbon content in the fine earth fraction ####
## 0-5cm depth
gdalwarp(t_srs="EPSG:4326", multi=TRUE, wm=200, 
         co=c("BIGTIFF=YES", "COMPRESS=DEFLATE", "TILED=TRUE"),
         tr=c(0.01,0.01), # Desired output resolution
         verbose=T,
         "/vsicurl?max_retry=3&retry_delay=1&list_dir=no&url=https://files.isric.org/soilgrids/latest/data/soc/soc_0-5cm_mean.vrt", # Input VRT
         "soc_0_5.tif") # Output file
## 0-5cm uncertainty
gdalwarp(t_srs="EPSG:4326", multi=TRUE, wm=200, 
         co=c("BIGTIFF=YES", "COMPRESS=DEFLATE", "TILED=TRUE"),
         tr=c(0.01,0.01), # Desired output resolution
         verbose=T,
         "/vsicurl?max_retry=3&retry_delay=1&list_dir=no&url=https://files.isric.org/soilgrids/latest/data/soc/soc_0-5cm_uncertainty.vrt", # Input VRT
         "UNCsoc_0_5.tif") # Output file
## 5-15cm depth
gdalwarp(t_srs="EPSG:4326", multi=TRUE, wm=200, 
         co=c("BIGTIFF=YES", "COMPRESS=DEFLATE", "TILED=TRUE"),
         tr=c(0.01,0.01), # Desired output resolution
         verbose=T,
         "/vsicurl?max_retry=3&retry_delay=1&list_dir=no&url=https://files.isric.org/soilgrids/latest/data/soc/soc_5-15cm_mean.vrt", # Input VRT
         "soc_5_15.tif") # Output file
## 5-15cm uncertainty
gdalwarp(t_srs="EPSG:4326", multi=TRUE, wm=200, 
         co=c("BIGTIFF=YES", "COMPRESS=DEFLATE", "TILED=TRUE"),
         tr=c(0.01,0.01), # Desired output resolution
         verbose=T,
         "/vsicurl?max_retry=3&retry_delay=1&list_dir=no&url=https://files.isric.org/soilgrids/latest/data/soc/soc_5-15cm_uncertainty.vrt", # Input VRT
         "UNCsoc_5_15.tif") # Output file
## 15-30cm depth
gdalwarp(t_srs="EPSG:4326", multi=TRUE, wm=200, 
         co=c("BIGTIFF=YES", "COMPRESS=DEFLATE", "TILED=TRUE"),
         tr=c(0.01,0.01), # Desired output resolution
         verbose=T,
         "/vsicurl?max_retry=3&retry_delay=1&list_dir=no&url=https://files.isric.org/soilgrids/latest/data/soc/soc_15-30cm_mean.vrt", # Input VRT
         "soc_15_30.tif") # Output file
## 15-30cm uncertainty
gdalwarp(t_srs="EPSG:4326", multi=TRUE, wm=200, 
         co=c("BIGTIFF=YES", "COMPRESS=DEFLATE", "TILED=TRUE"),
         tr=c(0.01,0.01), # Desired output resolution
         verbose=T,
         "/vsicurl?max_retry=3&retry_delay=1&list_dir=no&url=https://files.isric.org/soilgrids/latest/data/soc/soc_15-30cm_uncertainty.vrt", # Input VRT
         "UNCsoc_15_30.tif") # Output file
## 30-60cm depth
gdalwarp(t_srs="EPSG:4326", multi=TRUE, wm=200, 
         co=c("BIGTIFF=YES", "COMPRESS=DEFLATE", "TILED=TRUE"),
         tr=c(0.01,0.01), # Desired output resolution
         verbose=T,
         "/vsicurl?max_retry=3&retry_delay=1&list_dir=no&url=https://files.isric.org/soilgrids/latest/data/soc/soc_30-60cm_mean.vrt", # Input VRT
         "soc_30_60.tif") # Output file
## 30-60cm uncertainty
gdalwarp(t_srs="EPSG:4326", multi=TRUE, wm=200, 
         co=c("BIGTIFF=YES", "COMPRESS=DEFLATE", "TILED=TRUE"),
         tr=c(0.01,0.01), # Desired output resolution
         verbose=T,
         "/vsicurl?max_retry=3&retry_delay=1&list_dir=no&url=https://files.isric.org/soilgrids/latest/data/soc/soc_30-60cm_uncertainty.vrt", # Input VRT
         "UNCsoc_30_60.tif") # Output file
## 60-100cm depth
gdalwarp(t_srs="EPSG:4326", multi=TRUE, wm=200, 
         co=c("BIGTIFF=YES", "COMPRESS=DEFLATE", "TILED=TRUE"),
         tr=c(0.01,0.01), # Desired output resolution
         verbose=T,
         "/vsicurl?max_retry=3&retry_delay=1&list_dir=no&url=https://files.isric.org/soilgrids/latest/data/soc/soc_60-100cm_mean.vrt", # Input VRT
         "soc_60_100.tif") # Output file
## 60-100cm uncertainty
gdalwarp(t_srs="EPSG:4326", multi=TRUE, wm=200, 
         co=c("BIGTIFF=YES", "COMPRESS=DEFLATE", "TILED=TRUE"),
         tr=c(0.01,0.01), # Desired output resolution
         verbose=T,
         "/vsicurl?max_retry=3&retry_delay=1&list_dir=no&url=https://files.isric.org/soilgrids/latest/data/soc/soc_60-100cm_uncertainty.vrt", # Input VRT
         "UNCsoc_60_100.tif") # Output file
## 100-200cm depth
gdalwarp(t_srs="EPSG:4326", multi=TRUE, wm=200, 
         co=c("BIGTIFF=YES", "COMPRESS=DEFLATE", "TILED=TRUE"),
         tr=c(0.01,0.01), # Desired output resolution
         verbose=T,
         "/vsicurl?max_retry=3&retry_delay=1&list_dir=no&url=https://files.isric.org/soilgrids/latest/data/soc/soc_100-200cm_mean.vrt", # Input VRT
         "soc_100_200.tif") # Output file
## 100-200cm uncertainty
gdalwarp(t_srs="EPSG:4326", multi=TRUE, wm=200, 
         co=c("BIGTIFF=YES", "COMPRESS=DEFLATE", "TILED=TRUE"),
         tr=c(0.01,0.01), # Desired output resolution
         verbose=T,
         "/vsicurl?max_retry=3&retry_delay=1&list_dir=no&url=https://files.isric.org/soilgrids/latest/data/soc/soc_100-200cm_uncertainty.vrt", # Input VRT
         "UNCsoc_100_200.tif") # Output file

#### 	Organic carbon density ####
## 0-5cm depth
gdalwarp(t_srs="EPSG:4326", multi=TRUE, wm=200, 
         co=c("BIGTIFF=YES", "COMPRESS=DEFLATE", "TILED=TRUE"),
         tr=c(0.01,0.01), # Desired output resolution
         verbose=T,
         "/vsicurl?max_retry=3&retry_delay=1&list_dir=no&url=https://files.isric.org/soilgrids/latest/data/ocd/ocd_0-5cm_mean.vrt", # Input VRT
         "ocd_0_5.tif") # Output file
## 0-5cm uncertainty
gdalwarp(t_srs="EPSG:4326", multi=TRUE, wm=200, 
         co=c("BIGTIFF=YES", "COMPRESS=DEFLATE", "TILED=TRUE"),
         tr=c(0.01,0.01), # Desired output resolution
         verbose=T,
         "/vsicurl?max_retry=3&retry_delay=1&list_dir=no&url=https://files.isric.org/soilgrids/latest/data/ocd/ocd_0-5cm_uncertainty.vrt", # Input VRT
         "UNCocd_0_5.tif") # Output file
## 5-15cm depth
gdalwarp(t_srs="EPSG:4326", multi=TRUE, wm=200, 
         co=c("BIGTIFF=YES", "COMPRESS=DEFLATE", "TILED=TRUE"),
         tr=c(0.01,0.01), # Desired output resolution
         verbose=T,
         "/vsicurl?max_retry=3&retry_delay=1&list_dir=no&url=https://files.isric.org/soilgrids/latest/data/ocd/ocd_5-15cm_mean.vrt", # Input VRT
         "ocd_5_15.tif") # Output file
## 5-15cm uncertainty
gdalwarp(t_srs="EPSG:4326", multi=TRUE, wm=200, 
         co=c("BIGTIFF=YES", "COMPRESS=DEFLATE", "TILED=TRUE"),
         tr=c(0.01,0.01), # Desired output resolution
         verbose=T,
         "/vsicurl?max_retry=3&retry_delay=1&list_dir=no&url=https://files.isric.org/soilgrids/latest/data/ocd/ocd_5-15cm_uncertainty.vrt", # Input VRT
         "UNCocd_5_15.tif") # Output file
## 15-30cm depth
gdalwarp(t_srs="EPSG:4326", multi=TRUE, wm=200, 
         co=c("BIGTIFF=YES", "COMPRESS=DEFLATE", "TILED=TRUE"),
         tr=c(0.01,0.01), # Desired output resolution
         verbose=T,
         "/vsicurl?max_retry=3&retry_delay=1&list_dir=no&url=https://files.isric.org/soilgrids/latest/data/ocd/ocd_15-30cm_mean.vrt", # Input VRT
         "ocd_15_30.tif") # Output file
## 15-30cm uncertainty
gdalwarp(t_srs="EPSG:4326", multi=TRUE, wm=200, 
         co=c("BIGTIFF=YES", "COMPRESS=DEFLATE", "TILED=TRUE"),
         tr=c(0.01,0.01), # Desired output resolution
         verbose=T,
         "/vsicurl?max_retry=3&retry_delay=1&list_dir=no&url=https://files.isric.org/soilgrids/latest/data/ocd/ocd_15-30cm_uncertainty.vrt", # Input VRT
         "UNCocd_15_30.tif") # Output file
## 30-60cm depth
gdalwarp(t_srs="EPSG:4326", multi=TRUE, wm=200, 
         co=c("BIGTIFF=YES", "COMPRESS=DEFLATE", "TILED=TRUE"),
         tr=c(0.01,0.01), # Desired output resolution
         verbose=T,
         "/vsicurl?max_retry=3&retry_delay=1&list_dir=no&url=https://files.isric.org/soilgrids/latest/data/ocd/ocd_30-60cm_mean.vrt", # Input VRT
         "ocd_30_60.tif") # Output file
## 30-60cm uncertainty
gdalwarp(t_srs="EPSG:4326", multi=TRUE, wm=200, 
         co=c("BIGTIFF=YES", "COMPRESS=DEFLATE", "TILED=TRUE"),
         tr=c(0.01,0.01), # Desired output resolution
         verbose=T,
         "/vsicurl?max_retry=3&retry_delay=1&list_dir=no&url=https://files.isric.org/soilgrids/latest/data/ocd/ocd_30-60cm_uncertainty.vrt", # Input VRT
         "UNCocd_30_60.tif") # Output file
## 60-100cm depth
gdalwarp(t_srs="EPSG:4326", multi=TRUE, wm=200, 
         co=c("BIGTIFF=YES", "COMPRESS=DEFLATE", "TILED=TRUE"),
         tr=c(0.01,0.01), # Desired output resolution
         verbose=T,
         "/vsicurl?max_retry=3&retry_delay=1&list_dir=no&url=https://files.isric.org/soilgrids/latest/data/ocd/ocd_60-100cm_mean.vrt", # Input VRT
         "ocd_60_100.tif") # Output file
## 60-100cm uncertainty
gdalwarp(t_srs="EPSG:4326", multi=TRUE, wm=200, 
         co=c("BIGTIFF=YES", "COMPRESS=DEFLATE", "TILED=TRUE"),
         tr=c(0.01,0.01), # Desired output resolution
         verbose=T,
         "/vsicurl?max_retry=3&retry_delay=1&list_dir=no&url=https://files.isric.org/soilgrids/latest/data/ocd/ocd_60-100cm_uncertainty.vrt", # Input VRT
         "UNCocd_60_100.tif") # Output file
## 100-200cm depth
gdalwarp(t_srs="EPSG:4326", multi=TRUE, wm=200, 
         co=c("BIGTIFF=YES", "COMPRESS=DEFLATE", "TILED=TRUE"),
         tr=c(0.01,0.01), # Desired output resolution
         verbose=T,
         "/vsicurl?max_retry=3&retry_delay=1&list_dir=no&url=https://files.isric.org/soilgrids/latest/data/ocd/ocd_100-200cm_mean.vrt", # Input VRT
         "ocd_100_200.tif") # Output file
## 100-200cm uncertainty
gdalwarp(t_srs="EPSG:4326", multi=TRUE, wm=200, 
         co=c("BIGTIFF=YES", "COMPRESS=DEFLATE", "TILED=TRUE"),
         tr=c(0.01,0.01), # Desired output resolution
         verbose=T,
         "/vsicurl?max_retry=3&retry_delay=1&list_dir=no&url=https://files.isric.org/soilgrids/latest/data/ocd/ocd_100-200cm_uncertainty.vrt", # Input VRT
         "UNCocd_100_200.tif") # Output file

#### 	Organic carbon stocks ####
## 0-30cm depth
gdalwarp(t_srs="EPSG:4326", multi=TRUE, wm=200, 
         co=c("BIGTIFF=YES", "COMPRESS=DEFLATE", "TILED=TRUE"),
         tr=c(0.01,0.01), # Desired output resolution
         verbose=T,
         "/vsicurl?max_retry=3&retry_delay=1&list_dir=no&url=https://files.isric.org/soilgrids/latest/data/ocs/ocs_0-30cm_mean.vrt", # Input VRT
         "ocs_0_30.tif") # Output file
## 0-30cm uncertainty
gdalwarp(t_srs="EPSG:4326", multi=TRUE, wm=200, 
         co=c("BIGTIFF=YES", "COMPRESS=DEFLATE", "TILED=TRUE"),
         tr=c(0.01,0.01), # Desired output resolution
         verbose=T,
         "/vsicurl?max_retry=3&retry_delay=1&list_dir=no&url=https://files.isric.org/soilgrids/latest/data/ocs/ocs_0-30cm_uncertainty.vrt", # Input VRT
         "UNCocs_0_30.tif") # Output file
