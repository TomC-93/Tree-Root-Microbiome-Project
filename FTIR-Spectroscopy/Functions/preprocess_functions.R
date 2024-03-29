###--- Preprocessing functions ---###

#----------------------------------------------#
# Get Spectral Library Functions #
#----------------------------------------------#

# Get Spectral Library

getSpecLib <- function(SPECPATH="/Data_Raw/SPECTRA", 
                       LABPATH="Data_Raw/LAB_DATA.csv", SAVENAME="none"){
  # Extract OPUS Files
  spectra <- opus_to_dataset(SPECPATH)
  
  names <- attributes(spectra$spc)[2]$dimnames[1]
  
  # Subset Spectral Range
  spectra$spc <- subset_spectral_range(spectra$spc)
  
  attributes(spectra$spc)[2]$dimnames[1] <- names
  
  # Where calibration transfer would occur
  
  # Baseline Transformation
  spectra$spc <- base_offset(spectra$spc)
  
  # Merge with Lab Data
  lab <- data.frame(read.csv(LABPATH))
  speclib <- merge(lab, spectra, all.x=T) ### TC Changed all.y to all.x to retain data
  
  # Optional Save after Processing
  if(SAVENAME!= "none"){
    assign(SAVENAME,speclib)
    if(file.exists("./Data_Processed")==FALSE){dir.create("./Data_Processed")}
    savefile <- paste0("./Data_Processed/",SAVENAME,".rds")
    saveRDS(get(SAVENAME), file=savefile)
    cat(paste(SAVENAME,"saved to", savefile))
  }
  return(speclib)
}


# Opus to Dataset
library(stringr) #used for str_sub
library(foreach)
source("Functions/simplerspec/gather-spc.R")
source("Functions/simplerspec/read-opus-universal2.R")

opus_to_dataset <- function(SPECPATH ="/Data_Raw/SPECTRA", NWAVE=3017, SAVENAME="none"){
  #--- Converts OPUS files to RData ---#
  
  #---List Files---#
  dirs <- list.dirs(paste(getwd(),SPECPATH,sep=""), full.names=TRUE)
  all.files <- list.files(dirs, pattern= glob2rx("*.0"), recursive=TRUE,full.names=TRUE)
  
  #---Extract Spectra---#
  spc_list <- read_opus_univ(fnames = all.files, extract = c("spc"))
  soilspec_tbl <- spc_list %>%
    gather_spc() # Gather list of spectra data into tibble data frame
  spc <- soilspec_tbl$spc
  
  #---Truncate Spectra---#
  #spc.trun <- lapply(1:length(spc),function(x) spc[[x]][,1:NWAVE]) # Truncate at 3017 by default
  spc.trun <- lapply(1:length(spc),function(x) spc[[x]][,600:4000]) ## TC - Truncate between 600-4000 as paper describes
  
  #---Process to Dataframe---#
  spc.df <- as.data.frame(matrix(unlist(spc.trun), nrow=length(spc.trun), byrow=T))
  colnames(spc.df) <- colnames(spc.trun[[1]]) 
  rownames(spc.df) <- as.character(seq(1,nrow(spc.df)))
  
  #---Assign sample_ids---#
  spc.df <- data.frame(sample_id = soilspec_tbl$sample_id, spc.df)
  spc.df$sample_id <- substr(spc.df$sample_id, 1, 6) ### TC - Changed this line to just keep first 6 letters of ID as per Loretta's soil archive naming convention. May need updating if soil IDs go beyond S99999.
  spc.avg.df <- aggregate(.~sample_id, data = spc.df, FUN=mean, na.rm=TRUE)
  
  #---Reformat w/ Spectral Matrix Column---#
  spectra <- data.frame(spc.avg.df[,1])
  spectra$spc <- as.matrix(spc.avg.df[,2:ncol(spc.avg.df)])
  colnames(spectra) <- c("sample_id", "spc")
  
  #---Optionally Saves---#
  if(SAVENAME != "none"){
    assign(SAVENAME, spectra)
    savefile <- paste0("Data_Processed/", SAVENAME, ".RData")
    save(list= SAVENAME, file= savefile)
    cat(paste(SAVENAME,"saved to", savefile))
  }
  
  return(spectra)
  
}


# Subset Spectral Range

subset_spectral_range <- function(SPECTRA){
  #--- Subsets columns of the spectral range,
  #--- excluding CO2 sensitive region and truncating at 628.
  ### NOTE ###
  ### TC - Function rewritten as a loop (below) as original code did not work, however code not required for our purposes (our instrument does this automatically)
  
  # SPECTRAlist <- list()
  # 
  # for(i in 1:nrow(SPECTRA)){
  #   SPECTRA_i <- SPECTRA[i,]
  #   SPECTRA_i <- SPECTRA_i[!SPECTRA_i %in% 0:628]
  #   SPECTRA_i <- SPECTRA_i[!SPECTRA_i %in% 2268:2389]
  #   SPECTRAlist[[i]] <- SPECTRA_i
  # }
  
  # SPECTRA <- do.call(rbind, SPECTRAlist)
  return(SPECTRA)
  
  
}


# Base Offset
library(matrixStats)
                     
base_offset <- function(x){
  row_mins <- rowMins(x)
  return(spectra$spc-row_mins)
}


#----------------------------------------------#
# Refine Spectral Library Functions #
#----------------------------------------------#

# Refine Spectral Library
source("Functions/outlier_functions.R")

refineSpecLib <- function(SPECLIB, PROP=NA, OUTLIER=c("stdev","fratio"), LARGE=FALSE, CALVAL=FALSE, SAVENAME="none"){
  
  # Following line reduces dataframe to 3 columns which drastically speeds up code. Other columns unnecessary at this stage as plsr model only based on individual "PROP" + "spc" cols. Required as a "quality of life" hack when dealing with many soil properties.
  SPECLIB <- SPECLIB[,c(which(colnames(SPECLIB)=="sample_id"),which(colnames(SPECLIB)==PROP),which(colnames(SPECLIB)=="spc"))]
  
  # Remove rows with faulty lab data
  if(!is.na(PROP)){
    SPECLIB  <- noNA(SPECLIB , PROP) # Remove NAs
    SPECLIB  <- noNeg(SPECLIB , PROP) # Remove Negative
    if("stdev" %in% OUTLIER){
      outliers <- stdev_outliers(SPECLIB,PROP)
      if(is.na(outliers)==FALSE){
        SPECLIB  <- SPECLIB[-outliers,] # Remove lab data outliers
      } ### TC - Added this if statement (and outliers object) to allow for no outliers to be present
    } 
  }
  
  # Remove spectral outliers
  if(("fratio" %in% OUTLIER)){
    SPECLIB  <- SPECLIB[-fratio_outliers(SPECLIB),] # Identified with fratio
  } 
  
  # Subset a large dataset to 15000
  if(LARGE==TRUE){
    SPECLIB$spc <- sub_large_set(SPECLIB) # Subset to 15000 samples
  }
  
  # Split calibration/validation sets
  if(CALVAL==TRUE){
    SPECLIB <- calValSplit(SPECLIB)
  }
  
  # Save the refined set for OC
  if(SAVENAME != "none"){
    if(file.exists("./Data_Processed")==FALSE){dir.create("./Data_Processed")}
    assign(SAVENAME, SPECLIB)
    savefile <- paste0("./Data_Processed/",SAVENAME,".rds")
    saveRDS(get(SAVENAME), file=savefile)
    cat(paste("\n", SAVENAME,"saved to", savefile))
  }
  return(SPECLIB)
}


# Get Rid of NAs

noNA <- function(DATASET, column){
  return(DATASET[!is.na(DATASET[,column]),])
}


# Get Rid of Negative Values

noNeg <- function(DATASET, column){
  return(DATASET[which(DATASET[,column] > 0),])
}


# Subset Large Datasets
library(clhs)
                     
sub_large_set <- function(SPECLIB, SUBCOUNT=15000){
  #Conditional Latin Hypercube Sampling if the set exceeds 15000 samples
  spectra <- data.frame(SPECLIB$spc)
  subset <- clhs(spectra, size = SUBCOUNT, progress = TRUE, iter = 500)
  SPECLIB <- SPECLIB[subset,] #double check
  
  return(SPECLIB)
}


# Split into Calibration and Validation Sets
library(prospectr)
calValSplit <- function(SPECLIB, FRAC=0.8){
  
  #perform kennard stone to separate data into 80% calibration and 20% validation sets
  ken_stone<- prospectr::kenStone(X = na.omit(SPECLIB$spc), 
                                  k = as.integer(FRAC*nrow(SPECLIB)), 
                                  metric = "mahal", pc = 10)
  
  subset <- data.frame(SPECLIB[,1, drop=F])
  subset$calib <- 0
  subset[ken_stone$model, "calib"] <- 1
  SPECLIB <- data.frame(subset,SPECLIB[,2:ncol(SPECLIB),drop=F])
  
  return(SPECLIB)
}









