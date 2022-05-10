Accessing Environmental Data
================
Thomas Carlin
04/10/2021

## Introduction

This guide is intended to help access data on soil properties for any
given set of coordinates. Data and necessary R scripts must first be
downloaded using the “data_download.R” script.

If you instead are looking for global climate/elevation data, and/or
soil types only see the functions
<https://github.com/TomC-93/Tree-Root-Microbiome-Project/tree/main/Data-Acquisition>

## Preparing your R script

You should begin by setting your working directory. Your working
directory is the folder that R will look in for any data you read into R
and is the location R will save files to.

For the purpose of this guide I will work from the Q drive, however you
will probably want to set this as a folder dedicated for your own work.

``` r
setwd("Q:/Tree Root Microbiome/RA 3  Characterising the soil environment/Projects/Envirotyping data/Global Soil Data/R_scripts")
```

We also need to make sure we have all necessary packages installed. The
functions in this guide for collecting soil data only require one
package:“raster”. The first time we use this package we need to install
it (if you already have it installed you can skip this step). I already
have this installed so these lines have been commented out by placing \#
at the beginning. Code after a \# is considered a comment, and hence
isn’t run by R.

``` r
# install.packages("raster")
```

Next, we need to tell R where to find the new function is that we’re
going to be using. We can do this by “sourcing” the “functions.R” file
found in our working directory. (Note that we can also source files by
opening them and clicking the “Source” button at the top of the R
script)

There is only one function in this “functions.R” file: soildat().
soildat() provides information on a range of soil properties for any
coordinate. More information on these soil properties can be found here:
<https://soilgrids.org/>

``` r
source('Q:/Tree Root Microbiome/RA 3  Characterising the soil environment/Projects/Envirotyping data/Global Soil Data/R_scripts/functions.R')
```

## Reading in data

Now we have everything set up we just need to read in our coordinate
data. We can easily read in excel files that are saved as “csv”. We need
to remember to assign our data to an object in R by using “\<-”.

``` r
data <- read.csv("testdat.csv")
head(data)
```

    ##           lon       lat
    ## 1   15.542568  17.84254
    ## 2    6.291199  48.44701
    ## 3   -1.557997  51.77953
    ## 4   -3.425749  55.60933
    ## 5  -57.005361 -16.06610
    ## 6 -114.908060  53.24772

This data has 2 columns - longitude, and latitude. These need to be in
the correct order. These need to be in the coordinate projection WGS8

## Using the soildat() function to get soil data.

Now that we have our data, we simply need to input it into the soildat()
funtion. This will return a dataframe with your original coordinates,
along with the relevant soil properties data. Remember to assign the new
soil data to an object using “\<-”. This can be the same object as
before (df) or a new one like below. (We will break this function down
into its components later)

Note: Below I’m using data\[2,\] to just select one row (the 2nd row),
so that the resulting dataframe isn’t too messy when we view it in this
example.

``` r
data2 <- soildat(data[2,])
data2
```

    ##         lon      lat Soilclass ocs un_ocs   depth bdod  cec cfvo clay nitrogen
    ## 2  6.291199 48.44701 Cambisols  57     20     0-5 1.22 27.5 11.9 29.4     1.22
    ## 21 6.291199 48.44701 Cambisols  57     20    5-15 1.28 19.0   NA 30.6     1.28
    ## 22 6.291199 48.44701 Cambisols  57     20   15-30 1.33 15.7 13.2 35.7     1.33
    ## 23 6.291199 48.44701 Cambisols  57     20   30-60 1.49 15.1 13.5 35.4     1.49
    ## 24 6.291199 48.44701 Cambisols  57     20  60-100 1.52 14.7 12.9 37.3     1.52
    ## 25 6.291199 48.44701 Cambisols  57     20 100-200 1.55 14.6 14.9 37.3     1.55
    ##     ocd phh2o sand silt  soc
    ## 2  46.5   6.5 19.6 50.9 78.6
    ## 21 30.9   6.9 17.3 52.0 28.1
    ## 22 24.8   6.9 21.0 43.2 18.1
    ## 23  8.9   6.9 21.9 42.7 11.4
    ## 24  4.8   6.9 21.9 40.8  8.6
    ## 25  3.7   6.8 22.2 40.6  7.9

Above we can see the full dataframe produced. Note that we have 6 rows
for each coordinate as there are 6 depth increments available.

## Save data to use outside R

We can easily save this file as a csv, and either keep it in R or open
it in excel or other software.

``` r
write.csv(data2,"soil_data.csv")
```

## Uncertainty Values

Given that these data are the results of a complex global model (no-one
has sampled the whole worlds soil properties yet!), there is a certain
level of uncertainty around each result. This uncertainty is greater in
areas of the world where less soil surveys have been completed. If we
use this data in a global analysis we will have to account for this
uncertainty. To obtain the uncertainty values, simply use the
“uncertainty=T” argument in the soildat() function

``` r
data3 <- soildat(data[2,], uncertainty=T)
data3
```

    ##         lon      lat Soilclass ocs un_ocs   depth bdod cec cfvo clay nitrogen
    ## 2  6.291199 48.44701 Cambisols  57     20     0-5  122 275  119  294      627
    ## 21 6.291199 48.44701 Cambisols  57     20    5-15  128 190   NA  306      228
    ## 22 6.291199 48.44701 Cambisols  57     20   15-30  133 157  132  357      174
    ## 23 6.291199 48.44701 Cambisols  57     20   30-60  149 151  135  354      137
    ## 24 6.291199 48.44701 Cambisols  57     20  60-100  152 147  129  373      108
    ## 25 6.291199 48.44701 Cambisols  57     20 100-200  155 146  149  373      101
    ##    ocd phh2o sand silt soc un_bdod un_cec un_cfvo un_clay un_nitrogen un_ocd
    ## 2  465    65  196  509 786       8     31      38      38          53     19
    ## 21 309    69  173  520 281       7     33      NA      37          18     19
    ## 22 248    69  210  432 181       6     30      43      30          40     35
    ## 23  89    69  219  427 114       4     29      43      35          59     44
    ## 24  48    69  219  408  86       4     27      71      31          54     24
    ## 25  37    68  222  406  79       4     27      65      31          57     26
    ##    un_phh2o un_sand un_silt un_soc
    ## 2         5      37      17     95
    ## 21        4      34      16     19
    ## 22        4      45      22     34
    ## 23        4      45      23     34
    ## 24        5      44      NA     61
    ## 25        5      45      23     56

Above we can see the full dataframe produced. Note that uncertainty
columns come after the soil data, and can be identified by the “un\_”
before the soil property code. (property codes are available here:
<https://www.isric.org/explore/soilgrids/faq-soilgrids#What_do_the_filename_codes_mean>)

## Depth Increments

We may only be interested in one or a few depth increments. If so, we
can specify the depth increment we want data for using the “depth=”
argument. Possible depths are “0-5”, “5-10”, “15-30”, “30-60”, “60-100”,
and “100-200”.

``` r
data4 <- soildat(data[2,], depth="30-60")
data4
```

    ##        lon      lat Soilclass ocs un_ocs depth bdod cec cfvo clay nitrogen ocd
    ## 2 6.291199 48.44701 Cambisols  57     20 30-60  149 151  135  354      137  89
    ##   phh2o sand silt soc
    ## 2    69  219  427 114

If we are interested in more than one depth increment, but not all of
them, we can run soildat() twice and then combine our dataframes
together using rbind() (row bind)

``` r
data5 <- soildat(data[2,], depth="15-30")
soil_15_60 <- rbind(data4,data5)
soil_15_60
```

    ##         lon      lat Soilclass ocs un_ocs depth bdod cec cfvo clay nitrogen ocd
    ## 2  6.291199 48.44701 Cambisols  57     20 30-60  149 151  135  354      137  89
    ## 21 6.291199 48.44701 Cambisols  57     20 15-30  133 157  132  357      174 248
    ##    phh2o sand silt soc
    ## 2     69  219  427 114
    ## 21    69  210  432 181

Here we now have a dataframe that contains both 15-30cm and 30-60cm
depth increments.

## NA values for some environments

The International Soil Reference and Information Centre (ISRIC - where
the data are from) does not provide predictions for areas of: high
urbanisation, inland water, glaciers, or permanent ice. Predictions are
only provided for soils with or without vegetation cover. These areas
are defined by the European Space Agency (ESA) Land Cover Map (2015).
More information on this can be found here:
<https://www.isric.org/explore/soilgrids/faq-soilgrids#Which_soil_mask_map_was_used>

If you provide soildat() with coordinates for these areas, your
resulting dataframe will return “NA” values.

Note: the below code also shows how to convert a “names” column into
rownames for your coordinates

``` r
data <- read.csv("urbandata.csv")
df <- data[,2:3]
rownames(df) <- data[,1]
head(df)
```

    ##                       Longitude  Latitude
    ## Kaingaroa forest, NZ 176.635752 -38.38309
    ## Edinburgh, UK         -3.215699  55.96547
    ## Frankfurt, Germany     8.593298  50.07091

Here we have a dataframe with 3 coordinates, 1 of which is in an urban
environment. The urban environment (Edinburgh) returns NA values.

``` r
df <- soildat(df)
df
```

    ##                        Longitude  Latitude Soilclass ocs un_ocs   depth bdod
    ## Kaingaroa forest, NZ  176.635752 -38.38309  Andosols 104     28     0-5 0.89
    ## Edinburgh, UK          -3.215699  55.96547 Cambisols  NA     NA     0-5   NA
    ## Frankfurt, Germany      8.593298  50.07091 Cambisols  54     18     0-5 1.20
    ## Kaingaroa forest, NZ1 176.635752 -38.38309  Andosols 104     28    5-15 0.91
    ## Edinburgh, UK1         -3.215699  55.96547 Cambisols  NA     NA    5-15   NA
    ## Frankfurt, Germany1     8.593298  50.07091 Cambisols  54     18    5-15 1.30
    ## Kaingaroa forest, NZ2 176.635752 -38.38309  Andosols 104     28   15-30 0.98
    ## Edinburgh, UK2         -3.215699  55.96547 Cambisols  NA     NA   15-30   NA
    ## Frankfurt, Germany2     8.593298  50.07091 Cambisols  54     18   15-30 1.36
    ## Kaingaroa forest, NZ3 176.635752 -38.38309  Andosols 104     28   30-60 1.05
    ## Edinburgh, UK3         -3.215699  55.96547 Cambisols  NA     NA   30-60   NA
    ## Frankfurt, Germany3     8.593298  50.07091 Cambisols  54     18   30-60 1.50
    ## Kaingaroa forest, NZ4 176.635752 -38.38309  Andosols 104     28  60-100 1.13
    ## Edinburgh, UK4         -3.215699  55.96547 Cambisols  NA     NA  60-100   NA
    ## Frankfurt, Germany4     8.593298  50.07091 Cambisols  54     18  60-100 1.53
    ## Kaingaroa forest, NZ5 176.635752 -38.38309  Andosols 104     28 100-200 1.15
    ## Edinburgh, UK5         -3.215699  55.96547 Cambisols  NA     NA 100-200   NA
    ## Frankfurt, Germany5     8.593298  50.07091 Cambisols  54     18 100-200 1.54
    ##                        cec cfvo clay nitrogen  ocd phh2o sand silt   soc
    ## Kaingaroa forest, NZ  29.8 12.3 31.6     0.89 71.1   5.2 36.5 31.9 132.9
    ## Edinburgh, UK           NA   NA   NA       NA   NA    NA   NA   NA    NA
    ## Frankfurt, Germany    30.8  8.6 27.3     1.20 41.6   5.2 20.7 52.0  67.6
    ## Kaingaroa forest, NZ1 27.1   NA 32.4     0.91 61.9   5.2 37.4 30.2  83.7
    ## Edinburgh, UK1          NA   NA   NA       NA   NA    NA   NA   NA    NA
    ## Frankfurt, Germany1   19.8   NA 29.1     1.30 26.1   5.3 19.9 51.0  29.1
    ## Kaingaroa forest, NZ2 25.2 14.2 33.8     0.98 57.5   5.3   NA 30.5  64.9
    ## Edinburgh, UK2          NA   NA   NA       NA   NA    NA   NA   NA    NA
    ## Frankfurt, Germany2   16.7  8.9 28.6     1.36 18.2   5.6 20.9 50.5  15.2
    ## Kaingaroa forest, NZ3 24.0 16.6 37.4     1.05 41.2   5.4 33.3 29.2  48.8
    ## Edinburgh, UK3          NA   NA   NA       NA   NA    NA   NA   NA    NA
    ## Frankfurt, Germany3   16.4  9.2 28.8     1.50  9.7   5.9 20.2 51.0   6.3
    ## Kaingaroa forest, NZ4 22.8 16.0 38.4     1.13 44.9   5.4 32.5 29.0  48.2
    ## Edinburgh, UK4          NA   NA   NA       NA   NA    NA   NA   NA    NA
    ## Frankfurt, Germany4   17.3  9.5 28.9     1.53  6.3   6.1 20.5 50.6   4.4
    ## Kaingaroa forest, NZ5 22.7 17.8 37.7     1.15 43.2   5.4 34.3   NA  48.7
    ## Edinburgh, UK5          NA   NA   NA       NA   NA    NA   NA   NA    NA
    ## Frankfurt, Germany5   15.9 11.4 29.4     1.54  4.1   6.3 21.9 48.7   3.1
