# Data Acquisition

## Folder Contents

This folder contains a series of function used by the TRMP when collecting data at coarse scales for soil properties, elevation, slope, aspect, and climate.

## Referencing this Work

These functions rely heavily on the hard work of other GitHub users, scientists, and working groups, the details of which can be found below, and should be fully cited in any publications that have used these functions:

#### raster package

All of the data acquisition functions rely heavily on the downloading + manipulation of rasters, made possible by the "raster" package in R:

Robert J. Hijmans & Jacob van Etten (2012). raster: Geographic analysis and modeling with raster data. R package version 2.0-12. http://CRAN.R-project.org/package=raster
https://github.com/rspatial/raster

### Climate data

#### worldclim
Fick, S.E. and R.J. Hijmans, 2017. WorldClim 2: new 1km spatial resolution climate surfaces for global land areas

### Elevation data

Elevation data is collected via the use of the "elevatr" R package (see below) which accesses Amazon Web Services Terrain Tiles <https://registry.opendata.aws/terrain-tiles/>, the Open Topography Global Datasets API <https://opentopography.org/developers/>, and the USGS Elevation Point Query Service <https://nationalmap.gov/epqs/>.

#### elevatr

Hollister J, Shah T, Robitaille A, Beck M, Johnson M (2021). elevatr: Access Elevation Data from Various APIs. doi: 10.5281/zenodo.5809645, R package version 0.4.2, https://github.com/jhollist/elevatr/.

### Soil data

Soil data was collected from the World Soil Information Service (WoSIS) which is maintained by the International Soil Reference and Information Centre (ISRIC). SoilGrids (https://soilgrids.org/) provides a digital mapping service of this data, and we downloaded data using the "soil_tif.R" script from here: https://www.isric.org/explore/soilgrids

Batjes NH, Ribeiro E, van Oostrum A, Leenaars J, Hengl T and Mendes de Jesus J (2017). WoSIS: providing standardised soil profile data for the world.  Earth Syst. Sci. Data 9, 1-14.  doi:10.5194/essd-9-1-2017

Batjes NH, Ribeiro E, and van Oostrum Ad (2020). Standardised soil profile data to support global mapping and modelling (WoSIS snapshot 2019). Earth System Science Data doi: 10.5194/essd-12-299-2020

#### rgdal

The "soil_tif.R" script relies on the "rgdal" package, and as such relies on the broader "gdal" project:

Roger Bivand, Tim Keitt and Barry Rowlingson (2021). rgdal: Bindings for the 'Geospatial' Data Abstraction Library. R package version 1.5-28. https://CRAN.R-project.org/package=rgdal
https://github.com/cran/rgdal

GDAL/OGR contributors (2022). GDAL/OGR Geospatial Data Abstraction software Library. Open Source Geospatial Foundation. URL https://gdal.org DOI: 10.5281/zenodo.5884351

### Disclaimer

These functions are provided by Scion to facilitate quick and easy data acquisition around the world. While we have made reasonable endeavours to ensure its accuracy, these functions are under constant development and have not yet been fully validated. In addition, the R packages on which these functions rely may change or cease working leading to the accuracy of the provided functions being affected. Accordingly, these functions are provided without warranties of any kind including accuracy, timeliness or fitness for any particular purpose. To the fullest extent permitted by law, Scion excludes liability for any loss, damage or expense, direct or indirect resulting from any person or organisation's use of or reliance on these functions.

Shield: [![CC BY-SA 4.0][cc-by-sa-shield]][cc-by-sa]

This work is licensed under a
[Creative Commons Attribution-ShareAlike 4.0 International License][cc-by-sa].

[![CC BY-SA 4.0][cc-by-sa-image]][cc-by-sa]

[cc-by-sa]: http://creativecommons.org/licenses/by-sa/4.0/
[cc-by-sa-image]: https://licensebuttons.net/l/by-sa/4.0/88x31.png
[cc-by-sa-shield]: https://img.shields.io/badge/License-CC%20BY--SA%204.0-lightgrey.svg
