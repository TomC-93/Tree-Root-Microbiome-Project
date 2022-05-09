FTIR SOP
================
Thomas Carlin
01/03/2022

## Guide to Predict Soil Properties in R

This document provides the background information, with demonstration,
of how to take soil spectroscopy data from the lab to producing
stakeholder-results with a partial least squared regression model.

## 1) Save Spectra files in correct location

When you have run your soil samples through the FTIR machine and have
produced spectra results, you must save these files in the correct
folder so R knows where to find them.

We will be running all code from the Network drive, therefore I would
recommend saving them here:

Network//scionscience/ftir-hts/SoilSpectra/Veritec/Spectra

You can create multiple folders within this to help keep spectra files
from different projects/dates separate. Remember to keep the file naming
convention consistent, as R will look for patterns in the filenames to
know how to load them in correctly.

## 2) Preparing R for data processing

Before we can run use our PLSR model to generate predictions for our
spectra results, we have a few tasks to complete.

First, we need to set our working directory. Our working directory is
the folder in which R will look for any files that we want to load into
R, and also where R will save our results.

``` r
setwd("//scionscience/ftir-hts/SoilSpectra")
```

Next, we need to make sure we have installed the required packages
necessary to run this code, and “sourced” the required functions.
(Sourced functions are saved in the “Functions” folder)

NB: Installing packages is only required the first time you run this
code. If you have already installed them you do not need to install them
again, but ensure the functions are still sourced.

``` r
install.packages("stringr")      # processing spectra
install.packages("foreach")      # processing spectra
install.packages("prospectr")    # processing spectral set
install.packages("clhs")         # processing large sets
install.packages("matrixStats")  # preprocessing baseline transformation
install.packages("pls")          # pls models
install.packages("plot3D") 
install.packages("hexView")      # TC - Also required
```

``` r
source("PLSR_Models/Functions/preprocess_functions.R")
source("PLSR_Models/Functions/outlier_functions.R")
source("PLSR_Models/Functions/plsr_functions.R")
source("PLSR_Models/Functions/perform_functions.R")
source("PLSR_Models/Functions/predict_functions.R")
```

Now we’re ready to produce our model predictions.

## 3) Load spectra data into R

We can easily load spectra data into R using the following code. Please
be patient, as large sample sizes may take a few minutes. If you want to
save the spectra file as Rdata (a file that will load into R much faster
in the future) you can specify this by writing a filename after the
“SAVENAME=” argument - it is recommended to use an identifier such as
the date it was produced.

NB: The “\<-” here is assigning the results of the function to an
object. So this line of code creates an object called “predset”

``` r
predSet <- load_dat(SPECPATH="/Veritec/Spectra/example_21Mar22", SAVENAME="Spec_210322")
```

## 4) Predict soil properties with the PLSR models

Now we simply have to use our pre-produced models to predict the soil
properties from our spectra.

This step will also check for outliers, and remove them automatically -
leaving us with only data that will be predicted well by our model. If
any outliers are detected they will be listed at this step.

``` r
results <- FTIRpred(predSet, SAVENAME="example_01032022")
View(results)
```

| sample_id |    TC.PLS |   pH.PLS |    TN.PLS |    TP.PLS | M3_CEC_calc.PLS | M3_BS_calc.PLS | M3_Al.PLS |    M3_Ca.PLS |  X24Mg.PLS |    X27Al.PLS | X39K.PLS |  X43Ca.PLS |  X56Fe.PLS | X60Ni.PLS | X66Zn.PLS |
|:----------|----------:|---------:|----------:|----------:|----------------:|---------------:|----------:|-------------:|-----------:|-------------:|---------:|-----------:|-----------:|----------:|----------:|
| S10847    | 1.3657493 | 5.452316 | 0.0866076 | 212.24131 |        15.07433 |      14.449625 |  958.1997 |  279.8233563 | 884.910472 |  2235.416272 | 263.4434 |  285.60254 | 1261.74062 | 0.4572218 | 12.629226 |
| S10850    | 3.6350218 | 5.069953 | 0.2162206 | 327.50694 |        17.60341 |      16.647385 | 1288.6705 |  298.3821097 | 793.276455 |  8754.898068 | 372.6157 |  524.73825 | 7226.46606 | 2.2892202 | 18.238222 |
| S10859    | 0.2697310 | 5.866887 | 0.0277880 | 156.58242 |        12.59124 |      10.729260 |  694.0832 |  245.6679661 | 731.620846 |     6.526464 | 154.4933 |   79.78889 |  217.93358 | 0.1024305 |  7.258174 |
| S10866    | 0.5041330 | 5.749896 | 0.0400923 | 155.80650 |        12.25250 |      12.959315 |  711.2819 |  295.2002769 | 698.605033 |    11.055455 | 138.6430 |  117.52267 |  150.83902 | 0.0942996 |  7.940705 |
| S31369    | 0.1426293 | 5.614092 | 0.0202580 |  70.95208 |        14.70992 |       2.646099 | 1070.9582 |    0.2562636 |  52.171546 |  1362.517317 | 245.7644 |   80.33663 |   97.88743 | 0.0034416 | 10.421848 |
| S31370    | 3.6946483 | 5.047754 | 0.2141111 | 307.81849 |        17.45852 |      19.206008 | 1242.2296 |  342.9004677 | 770.474983 |  8519.787463 | 367.2787 |  599.08994 | 8046.90429 | 2.3681092 | 18.630700 |
| S35691    | 5.8571732 | 4.955787 | 0.3170816 | 323.44582 |        23.36092 |      14.306254 | 1705.5326 |  366.4021328 | 357.430793 |  8795.669649 | 287.4883 |  549.09958 | 3510.90411 | 1.1332999 | 18.196950 |
| S36293    | 6.3701402 | 4.438801 | 0.3689608 | 250.43462 |        10.96840 |      77.414272 |  532.9596 | 1507.7922311 |  76.799592 |  3895.596123 | 560.4542 | 1737.84643 | 5093.40087 | 2.2272168 | 26.093860 |
| S36294    | 5.4296750 | 4.637275 | 0.3103337 | 277.62788 |        19.66489 |      13.354206 | 1538.2958 |  304.9317939 |  23.244772 |  2179.605798 | 141.7749 |  114.20094 |  188.37425 | 0.0060670 |  8.283154 |
| S37248    | 4.2737913 | 5.330505 | 0.2550930 | 208.99768 |        25.07723 |       5.008581 | 2129.9764 |  163.6980836 |   2.767900 | 23067.355576 | 185.4736 |  112.49044 | 5927.80719 | 0.0482393 | 15.362933 |
| S37249    | 5.9969774 | 5.349790 | 0.3545055 | 241.23235 |        21.59423 |      13.872097 | 2171.5092 |  188.5783357 |  65.317549 | 26543.274954 | 151.9585 |  207.43706 | 7762.89164 | 0.0001319 | 20.389055 |
| S37250    | 5.2967218 | 5.321972 | 0.3218788 | 222.66369 |        28.46400 |       3.506798 | 2428.5325 |  180.5412774 |   4.996701 | 29620.904906 | 161.5787 |  113.46721 | 7486.05979 | 0.0743747 | 15.216132 |
| S41176    | 4.3930277 | 5.027963 | 0.2605377 | 254.32654 |        26.86048 |       3.009300 | 2226.0412 |  149.0697623 |  50.810557 | 13514.889902 | 236.2455 |  328.78757 | 2093.29780 | 1.0106176 | 12.868837 |
| S41177    | 2.0196680 | 5.231288 | 0.1186175 | 186.84083 |        22.02710 |       6.459098 | 1734.6657 |  132.1104671 | 225.860822 |  7612.368876 | 304.8546 |  206.48799 | 2901.91405 | 0.7233909 | 13.947726 |

PLSR Predictions

## 5) Open + save results outside of R

As long as we specify the “SAVENAME” argument in step 4, our model
predictions are automatically saved into a csv file. This file is
located in
Network//scionscience/ftir-hts/SoilSpectra/Veritec/Predictions
