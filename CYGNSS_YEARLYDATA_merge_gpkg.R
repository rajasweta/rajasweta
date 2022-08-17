
rm(list = ls())
#calling all library needed
library(sf)
library(raster)
library(rgdal)
library(spData)
library(tidyverse)

setwd("Z:/PROCESS/CYGNSS/gpkg/NZ/")
filelist<-list.files(pattern = ".gpkg", all.files = FALSE,
           full.names = FALSE, recursive = FALSE,
           ignore.case = FALSE, include.dirs = FALSE, no.. = FALSE)

data<-st_read(filelist[1])

for( i in 2:length(filelist))
{
  data <- union(data, st_read(filelist[i]))
  
}

st_write(data,"Z:/PROCESS/CYGNSS/gpkg/NZ_2017_18_merged.gpkg")
