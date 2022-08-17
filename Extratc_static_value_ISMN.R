rm(list = ls())
#calling all library needed
library(sf)
library(raster)
library(rgdal)
library(spData)
point_file<-st_read("Z:/PROCESS/ISMN/STATION_SHAPE/ISMN_STATIONS_final_GCS_84.gpkg")




#folder of data to extract
setwd("Z:/DATA_RAW/GLAD_UMD_forest_height/")
files<-list.files(pattern = ".tif$",full.names=TRUE, recursive = TRUE)
rasValue=NULL
point_file2<-st_transform(point_file, crs = st_crs(raster(files[1])))
  
  
for (i in 1:length(files))
{ 
  data<-raster(files[i])
  ext<-extract(data, point_file2)
  rasValue=cbind(rasValue,ext)
  print(paste0(i,"out of ",length(files),".............done"))
  
}

mean_values<-rowMeans(rasValue, na.rm=TRUE)
point_file2$GLAD<-mean_values
print("GLAD EXTRACT COMPLETE !!!!!!!!!!")




#folder of data to extract
setwd("Z:/DATA_RAW/Global_Hydrologic_Soil_Group_1566/Global_Hydrologic_Soil_Group_1566/data/")
files<-list.files(pattern = ".tif$",full.names=TRUE, recursive = TRUE)
rasValue=NULL
point_file2<-st_transform(point_file2, crs = st_crs(raster(files[1])))


for (i in 1:length(files))
{ 
  data<-raster(files[i])
  ext<-extract(data, point_file2)
  rasValue=cbind(rasValue,ext)
  print(paste0(i,"out of ",length(files),".............done"))
  
}

mean_values<-rowMeans(rasValue, na.rm=TRUE)
point_file2$GHSG<-mean_values
print("GHSG EXTRACT COMPLETE !!!!!!!!!!")



#folder of data to extract
setwd("Z:/DATA_RAW/KSAT_MAPS_GLOBAL/")
files<-list.files(pattern = ".tif$",full.names=TRUE, recursive = TRUE)
rasValue=NULL
point_file2<-st_transform(point_file2, crs = st_crs(raster(files[1])))


for (i in 1:length(files))
{ 
  data<-raster(files[i])
  ext<-extract(data, point_file2)
  rasValue=cbind(rasValue,ext)
  print(paste0(i,"out of ",length(files),".............done"))
  
}

mean_values<-rowMeans(rasValue, na.rm=TRUE)
point_file2$KSAT<-mean_values
print("KSAT EXTRACT COMPLETE !!!!!!!!!!")



#folder of data to extract
setwd("Z:/DATA_RAW/MERIT_Hydro/ADJUSTED_ELEVATION/")
files<-list.files(pattern = ".tif$",full.names=TRUE, recursive = TRUE)
rasValue=NULL
point_file2<-st_transform(point_file2, crs = st_crs(raster(files[1])))


for (i in 1:length(files))
{ 
  data<-raster(files[i])
  ext<-extract(data, point_file2)
  rasValue=cbind(rasValue,ext)
  print(paste0(i,"out of ",length(files),".............done"))
  
}

mean_values<-rowMeans(rasValue, na.rm=TRUE)
point_file2$ADJ_ELEV<-mean_values
print("ELEVATION EXTRACT COMPLETE !!!!!!!!!!")




#folder of data to extract
setwd("Z:/DATA_RAW/MERIT_Hydro/FLOW_DIRECTION/")
files<-list.files(pattern = ".tif$",full.names=TRUE, recursive = TRUE)
rasValue=NULL
point_file2<-st_transform(point_file2, crs = st_crs(raster(files[1])))


for (i in 1:length(files))
{ 
  data<-raster(files[i])
  ext<-extract(data, point_file2)
  rasValue=cbind(rasValue,ext)
  print(paste0(i,"out of ",length(files),".............done"))
  
}

mean_values<-rowMeans(rasValue, na.rm=TRUE)
point_file2$FLOW_DIREC<-mean_values
print("FLOW_DIRECTION EXTRACT COMPLETE !!!!!!!!!!")




#folder of data to extract
setwd("Z:/DATA_RAW/MERIT_Hydro/HEIGHT_ABOVE_DRAINAGE/")
files<-list.files(pattern = ".tif$",full.names=TRUE, recursive = TRUE)
rasValue=NULL
point_file2<-st_transform(point_file2, crs = st_crs(raster(files[1])))


for (i in 1:length(files))
{ 
  data<-raster(files[i])
  ext<-extract(data, point_file2)
  rasValue=cbind(rasValue,ext)
  print(paste0(i,"out of ",length(files),".............done"))
  
}

mean_values<-rowMeans(rasValue, na.rm=TRUE)
point_file2$HGT_ABV_DRAING<-mean_values
print("HEIGHT_ABOVE_DRAINAGE EXTRACT COMPLETE !!!!!!!!!!")





#folder of data to extract
setwd("Z:/DATA_RAW/MERIT_Hydro/RIVER_WIDTH/")
files<-list.files(pattern = ".tif$",full.names=TRUE, recursive = TRUE)
rasValue=NULL
point_file2<-st_transform(point_file2, crs = st_crs(raster(files[1])))


for (i in 1:length(files))
{ 
  data<-raster(files[i])
  ext<-extract(data, point_file2)
  rasValue=cbind(rasValue,ext)
  print(paste0(i,"out of ",length(files),".............done"))
  
}

mean_values<-rowMeans(rasValue, na.rm=TRUE)
point_file2$RIVER_WDTH<-mean_values
print("RIVER_WIDTH EXTRACT COMPLETE !!!!!!!!!!")




#folder of data to extract
setwd("Z:/DATA_RAW/MERIT_Hydro/UPSTREAM_DRAINAGE_AREA/")
files<-list.files(pattern = ".tif$",full.names=TRUE, recursive = TRUE)
rasValue=NULL
point_file2<-st_transform(point_file2, crs = st_crs(raster(files[1])))


for (i in 1:length(files))
{ 
  data<-raster(files[i])
  ext<-extract(data, point_file2)
  rasValue=cbind(rasValue,ext)
  print(paste0(i,"out of ",length(files),".............done"))
  
}

mean_values<-rowMeans(rasValue, na.rm=TRUE)
point_file2$UPSTRM_DRAING_AREA<-mean_values
print("UPSTREAM_DRAINAGE_AREA EXTRACT COMPLETE !!!!!!!!!!")




# #folder of data to extract ISRIC
# setwd("Z:/DATA_RAW/ISRIC/")
# files<-list.files(pattern = ".vrt$",full.names=TRUE, recursive = TRUE)
# for (i in 1:length(files))
# { 
#   point_file2<-st_transform(point_file2, crs = st_crs(raster(files[1])))
#   data<-raster(files[i])
#   ext<-extract(data, point_file2)
# }
# mean_values<-rowMeans(rasValue, na.rm=TRUE)
# point_file2$UPSTRM_DRAING_AREA<-mean_values
# print("UPSTREAM_DRAINAGE_AREA EXTRACT COMPLETE !!!!!!!!!!")


point_file2<-st_transform(point_file2, crs = st_crs(point_file))

st_write(point_file2,"Z:/PROCESS/ISMN/STATION_SHAPE/ISMN_STATIONS_final_GCS_84_with_static_value.gpkg")
write.csv(point_file2,"Z:/PROCESS/ISMN/STATION_SHAPE/ISMN_STATIONS_final_GCS_84_with_static_value.csv")
save(point_file2,file="Z:/PROCESS/ISMN/STATION_SHAPE/ISMN_STATIONS_final_GCS_84_with_static_value.RData")
