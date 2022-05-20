###--- Simplified Preprocessing functions for Sample Predictions only (not calibrating/validating models ---###
### Thomas Carlin
### 01/03/22

### This script gathers some useful functions + produces a few to speed up our processing of samples. Based heavily on other existing functions from Charlotte Rivard + Shree Dangal.


load_dat <- function(SPECPATH="/Spectra/Example", SAVENAME="example_01032022"){
  
  # Opus to Dataset
  library(stringr) #used for str_sub
  library(foreach)
  library(dplyr)
  source("Functions/simplerspec/gather-spc.R")
  source("Functions/simplerspec/read-opus-universal2.R")
  
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
    spc.trun <- lapply(1:length(spc),function(x) spc[[x]][,600:4000]) # Truncate between 600-4000 as paper describes
    
    #---Process to Dataframe---#
    spc.df <- as.data.frame(matrix(unlist(spc.trun), nrow=length(spc.trun), byrow=T))
    colnames(spc.df) <- colnames(spc.trun[[1]]) 
    rownames(spc.df) <- as.character(seq(1,nrow(spc.df)))
    
    #---Assign sample_ids---#
    spc.df <- data.frame(sample_id = soilspec_tbl$sample_id, spc.df)
    spc.df$sample_id <- substr(spc.df$sample_id, 1, 6) ### TC - Changed this line to just keep first 6 letters of ID as per Lorettas soil archive naming convention. May need updating if soil IDs go beyond S99999.
    spc.avg.df <- aggregate(.~sample_id, data = spc.df, FUN=mean, na.rm=TRUE)
    
    #---Reformat w/ Spectral Matrix Column---#
    spectra <- data.frame(spc.avg.df[,1])
    spectra$spc <- as.matrix(spc.avg.df[,2:ncol(spc.avg.df)])
    colnames(spectra) <- c("sample_id", "spc")
    
    #---Optionally Saves---#
    if(SAVENAME != "none"){
      assign(SAVENAME, spectra)
      savefile <- paste0("Veritec/Data_Processed/", SAVENAME, ".RData")
      save(list= SAVENAME, file= savefile)
      cat(paste(SAVENAME,"saved to", savefile))
    }
    
    names <- attributes(spectra$spc)[2]$dimnames[1]
    
    attributes(spectra$spc)[2]$dimnames[1] <- names
    
    spectra <<- spectra
    
    spectra$spc <- base_offset(spectra$spc)
    
    return(spectra)
    
}

refineSpecLib2 <- function(SPECLIB,  OUTLIER=c("stdev","fratio"), LARGE=FALSE, SAVENAME="none"){
  
  # Remove spectral outliers
  if(("fratio" %in% OUTLIER)){
    outliers <- fratio_outliers(SPECLIB) ### TC - Created outliers object early for purpose of new if statement (below)
    if(outliers != "No Spectral Outliers"){ ### TC - Added additional if statement to allow for "outliers" object to be empty
      SPECLIB  <- SPECLIB[-outliers,] # Identified with fratio
     } else{}
    } 
  
  # Subset a large dataset to 15000
  if(LARGE==TRUE){
    SPECLIB$spc <- sub_large_set(SPECLIB) # Subset to 15000 samples
  }
  
  # Save the refined set
  if(SAVENAME != "none"){
    if(file.exists("./Data_Processed")==FALSE){dir.create("./Data_Processed")}
    assign(SAVENAME, SPECLIB)
    savefile <- paste0("./Data_Processed/",SAVENAME,".rds")
    saveRDS(get(SAVENAME), file=savefile)
    cat(paste("\n", SAVENAME,"saved to", savefile))
  }
  return(SPECLIB)
}

FTIRpred <- function(PROP="ALL", PREDNAME=predSet, SAVENAME=NA){
  
  # Quick function to loop through any/all soil properties
  
  ### Begin by removing all old objects from the global environment that could interfere with this function
  ### Note that if these objects are NOT removed, they will be merged with the new data at the end of the function and cause confusion
  rm(list=ls(pattern="^pls.predictions"))
  
  ### Create a list of all *possible* objects, so that they can be merged at the end
  objects <- c("pls.predictions1","pls.predictions2","pls.predictions3","pls.predictions4","pls.predictions5","pls.predictions6","pls.predictions7","pls.predictions8","pls.predictions9","pls.predictions10","pls.predictions11","pls.predictions12","pls.predictions13","pls.predictions14","pls.predictions15")

  source("Functions/plsr_functions.R")
  source("Functions/perform_functions.R")
  
  ### Refine data to remove outliers
  
  data <- refineSpecLib2(PREDNAME)
  
  ###### TC ######
  
  if(PROP=="ALL" | PROP=="TC"){
  
    load("Models/plsr.TC.RData")
    
    pred <- as.data.frame(getPredPLS(plsr.TC, NCOMP=ncompOneSigma(plsr.TC), PREDTYPE="predict", PREDSET=data))
    pls.predictions1 <- cbind(data$sample_id, pred)
    names(pls.predictions1) <- c("sample_id", "TC.PLS")
    
  }
  
  ###### pH ######
  
  if(PROP=="ALL" | PROP=="pH"){
    
    load("Models/plsr.pH.RData")
    
    pred <- as.data.frame(getPredPLS(plsr.pH, NCOMP=ncompOneSigma(plsr.pH), PREDTYPE="predict", PREDSET=data))
    pls.predictions2 <- cbind(data$sample_id, pred)
    names(pls.predictions2) <- c("sample_id", "pH.PLS")
    
  }
  
  ###### TN ######
  
  if(PROP=="ALL" | PROP=="TN"){
    
    load("Models/plsr.TN.RData")
    
    pred <- as.data.frame(getPredPLS(plsr.TN, NCOMP=ncompOneSigma(plsr.TN), PREDTYPE="predict", PREDSET=data))
    pls.predictions3 <- cbind(data$sample_id, pred)
    names(pls.predictions3) <- c("sample_id", "TN.PLS")
    
  }
  
  ###### TP ######
  
  if(PROP=="ALL" | PROP=="TP"){
    
    load("Models/plsr.TP.RData")
    
    pred <- as.data.frame(getPredPLS(plsr.TP, NCOMP=ncompOneSigma(plsr.TP), PREDTYPE="predict", PREDSET=data))
    pls.predictions4 <- cbind(data$sample_id, pred)
    names(pls.predictions4) <- c("sample_id", "TP.PLS")
    
  }
  
  ###### M3_CEC_calc ######
  
  if(PROP=="ALL" | PROP=="M3_CEC_calc"){
    
    load("Models/plsr.M3_CEC_calc.RData")
    
    pred <- as.data.frame(getPredPLS(plsr.M3_CEC_calc, NCOMP=ncompOneSigma(plsr.M3_CEC_calc), PREDTYPE="predict", PREDSET=data))
    pls.predictions5 <- cbind(data$sample_id, pred)
    names(pls.predictions5) <- c("sample_id", "M3_CEC_calc.PLS")
    
  }
  
  ###### M3_BS_calc ######
  
  if(PROP=="ALL" | PROP=="M3_BS_calc"){
    
    load("Models/plsr.M3_BS_calc.RData")
    
    pred <- as.data.frame(getPredPLS(plsr.M3_BS_calc, NCOMP=ncompOneSigma(plsr.M3_BS_calc), PREDTYPE="predict", PREDSET=data))
    pls.predictions6 <- cbind(data$sample_id, pred)
    names(pls.predictions6) <- c("sample_id", "M3_BS_calc.PLS")
    
  }
  
  ###### M3_Al ######
  
  if(PROP=="ALL" | PROP=="M3_Al"){
    
    load("Models/plsr.M3_Al.RData")
    
    pred <- as.data.frame(getPredPLS(plsr.M3_Al, NCOMP=ncompOneSigma(plsr.M3_Al), PREDTYPE="predict", PREDSET=data))
    pls.predictions7 <- cbind(data$sample_id, pred)
    names(pls.predictions7) <- c("sample_id", "M3_Al.PLS")
    
  }
  
  ###### M3_Ca ######
  
  if(PROP=="ALL" | PROP=="M3_Ca"){
    
    load("Models/plsr.M3_Ca.RData")
    
    pred <- as.data.frame(getPredPLS(plsr.M3_Ca, NCOMP=ncompOneSigma(plsr.M3_Ca), PREDTYPE="predict", PREDSET=data))
    pls.predictions8 <- cbind(data$sample_id, pred)
    names(pls.predictions8) <- c("sample_id", "M3_Ca.PLS")

  }
  
  ###### X24Mg ######
  
  if(PROP=="ALL" | PROP=="X24Mg"){
    
    load("Models/plsr.X24Mg.RData")
    
    pred <- as.data.frame(getPredPLS(plsr.X24Mg, NCOMP=ncompOneSigma(plsr.X24Mg), PREDTYPE="predict", PREDSET=data))
    pls.predictions9 <- cbind(data$sample_id, pred)
    names(pls.predictions9) <- c("sample_id", "X24Mg.PLS")

  }
  
  ###### X27Al ######
  
  if(PROP=="ALL" | PROP=="X27Al"){
    
    load("Models/plsr.X27Al.RData")
    
    pred <- as.data.frame(getPredPLS(plsr.X27Al, NCOMP=ncompOneSigma(plsr.X27Al), PREDTYPE="predict", PREDSET=data))
    pls.predictions10 <- cbind(data$sample_id, pred)
    names(pls.predictions10) <- c("sample_id", "X27Al.PLS")
    
  }
  
  ###### X39K ######
  
  if(PROP=="ALL" | PROP=="X39K"){
    
    load("Models/plsr.X39K.RData")
    
    pred <- as.data.frame(getPredPLS(plsr.X39K, NCOMP=ncompOneSigma(plsr.X39K), PREDTYPE="predict", PREDSET=data))
    pls.predictions11 <- cbind(data$sample_id, pred)
    names(pls.predictions11) <- c("sample_id", "X39K.PLS")
    
  }
  
  ###### X43Ca ######
  
  if(PROP=="ALL" | PROP=="X43Ca"){
    
    load("Models/plsr.X43Ca.RData")
    
    pred <- as.data.frame(getPredPLS(plsr.X43Ca, NCOMP=ncompOneSigma(plsr.X43Ca), PREDTYPE="predict", PREDSET=data))
    pls.predictions12 <- cbind(data$sample_id, pred)
    names(pls.predictions12) <- c("sample_id", "X43Ca.PLS")
    
  }
  
  ###### X56Fe ######
  
  if(PROP=="ALL" | PROP=="X56Fe"){
    
    load("Models/plsr.X56Fe.RData")
    
    pred <- as.data.frame(getPredPLS(plsr.X56Fe, NCOMP=ncompOneSigma(plsr.X56Fe), PREDTYPE="predict", PREDSET=data))
    pls.predictions13 <- cbind(data$sample_id, pred)
    names(pls.predictions13) <- c("sample_id", "X56Fe.PLS")
    
  }
  
  ###### X60Ni ######
  
  if(PROP=="ALL" | PROP=="X60Ni"){
    
    load("Models/plsr.X60Ni.RData")
    
    pred <- as.data.frame(getPredPLS(plsr.X60Ni, NCOMP=ncompOneSigma(plsr.X60Ni), PREDTYPE="predict", PREDSET=data))
    pls.predictions14 <- cbind(data$sample_id, pred)
    names(pls.predictions14) <- c("sample_id", "X60Ni.PLS")
    
  }
  
  ###### X66Zn ######
  
  if(PROP=="ALL" | PROP=="X66Zn"){
    
    load("Models/plsr.X66Zn.RData")
    
    pred <- as.data.frame(getPredPLS(plsr.X66Zn, NCOMP=ncompOneSigma(plsr.X66Zn), PREDTYPE="predict", PREDSET=data))
    pls.predictions15 <- cbind(data$sample_id, pred)
    names(pls.predictions15) <- c("sample_id", "X66Zn.PLS")
    
  }
  
  
  ##### Merge + Save #####
  
  # Identify + Merge objects created in this session
  objects <- objects[objects %in% ls()]
  object <- mget(objects)
  pls.predictions <- do.call(cbind, object)
  
  # Remove duplicate sample_id columns
  names(pls.predictions) <- substring(names(pls.predictions),18)
  if(ncol(pls.predictions) > 18){
  names(pls.predictions)[19:ncol(pls.predictions)] <- substring(names(pls.predictions)[19:30],2)
  }
  pls.predictions <- pls.predictions[, !duplicated(colnames(pls.predictions))]

  write.csv(pls.predictions,file=paste0("Veritec/Predictions/", SAVENAME, ".csv"))
  
  return(pls.predictions)
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
# Base Offset
library(matrixStats)

base_offset <- function(x){
  row_mins <- rowMins(x)
  return(spectra$spc-row_mins)
}






