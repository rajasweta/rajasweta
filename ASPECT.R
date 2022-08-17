rm(list = ls())
library(raster)
library(rgdal)
library(gdalUtils)
library(sp)
library(sf)
library(raster)
library(Rfast)
library(dplyr)

setwd("Z:/DATA_RAW/MERIT_Hydro/ADJUSTED_ELEVATION/")
files<-list.files(pattern = ".tif$",full.names=TRUE, recursive = TRUE)
for ( i in 1:length(files))
{
  data_raster<-raster(files[i])
  terrain(data_raster, opt="aspect", unit="degrees", neighbors=8, filename=paste0("Z:/DATA_RAW/MERIT_Hydro/ASPECT/aspect_",basename(files[i])))
  print(paste0("files   ",i,"   out of  ", length(files),"............completed"))
}
