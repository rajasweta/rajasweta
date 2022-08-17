rm(list = ls())
#calling all library needed
library(sf)
library(raster)
library(rgdal)
library(spData)

point_file<-st_read("Z:/PROCESS/ISMN/STATION_SHAPE/ISMN_finalGCS84_staticvalue_TIER2.gpkg")

#ISRIC<-raster("V:/bdod/bdod_0-5cm_mean.vrt")
sand<-raster("Z:/PROCESS/ISRIC/SAND.vrt")
silt<-raster("Z:/PROCESS/ISRIC/SILT.vrt")
OCD<-raster("Z:/PROCESS/ISRIC/OCD.vrt")
clay<-raster("Z:/PROCESS/ISRIC/CLAY.vrt")

#SAND
point_file_newproj<-st_transform(point_file, crs = st_crs(sand))
ext<-extract(sand, point_file_newproj)
point_file_newproj$SAND<-ext

#SILT
point_file_newproj<-st_transform(point_file_newproj, crs = st_crs(silt))
ext<-extract(silt, point_file_newproj)
point_file_newproj$SILT<-ext

#OCD
point_file_newproj<-st_transform(point_file_newproj, crs = st_crs(OCD))
ext<-extract(OCD, point_file_newproj)
point_file_newproj$OCD<-ext

#CLAY
point_file_newproj<-st_transform(point_file_newproj, crs = st_crs(clay))
ext<-extract(clay, point_file_newproj)
point_file_newproj$CLAY<-ext

point_file_newproj<-st_transform(point_file_newproj, crs = st_crs(point_file))



st_write(point_file_newproj,"Z:/PROCESS/ISMN/STATION_SHAPE/ISMN_finalGCS84_staticvalue_TIER3.gpkg")
write.csv(point_file_newproj,"Z:/PROCESS/ISMN/STATION_SHAPE/ISMN_finalGCS84_staticvalue_TIER3.csv")
save(point_file_newproj,file="Z:/PROCESS/ISMN/STATION_SHAPE/ISMN_finalGCS84_staticvalue_TIER3.RData")
