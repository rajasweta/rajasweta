rm(list = ls())
#calling all library needed
library(sf)
library(raster)
library(rgdal)
library(spData)
point_file<-st_read("Z:/PROCESS/CYGNSS_ISMN_datapoints/2021/TIER2_CYGNSS_2021_ALLpointswithSMguage_withSM.gpkg")

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
files<-"Z:/DATA_RAW/KSAT_MAPS_GLOBAL/Global_Ksat_1Km_s0....0cm_v1.0.tif"
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




#extratcing ISRIC values


#ISRIC<-raster("V:/bdod/bdod_0-5cm_mean.vrt")
sand<-raster("Z:/PROCESS/ISRIC/SAND.vrt")
silt<-raster("Z:/PROCESS/ISRIC/SILT.vrt")
OCD<-raster("Z:/PROCESS/ISRIC/OCD.vrt")
clay<-raster("Z:/PROCESS/ISRIC/CLAY.vrt")

#SAND
point_file2<-st_transform(point_file2, crs = st_crs(sand))
ext<-extract(sand, point_file2)
point_file2$SAND<-ext

#SILT
point_file_2<-st_transform(point_file2, crs = st_crs(silt))
ext<-extract(silt, point_file2)
point_file2$SILT<-ext

#OCD
point_file2<-st_transform(point_file2, crs = st_crs(OCD))
ext<-extract(OCD, point_file2)
point_file2$OCD<-ext

#CLAY
point_file2<-st_transform(point_file2, crs = st_crs(clay))
ext<-extract(clay, point_file2)
point_file2$CLAY<-ext



point_file2<-st_transform(point_file2, crs = st_crs(point_file))

st_write(point_file2,"Z:/PROCESS/CYGNSS_ISMN_datapoints/2021/TIER3_CYGNSS_2021_ALLpointswithSMguage_withSM_&_staticvalues.gpkg")
write.csv(point_file2,"Z:/PROCESS/CYGNSS_ISMN_datapoints/2021/TIER3_CYGNSS_2021_ALLpointswithSMguage_withSM_&_staticvalues.csv")
save(point_file2,file="Z:/PROCESS/CYGNSS_ISMN_datapoints/2021/TIER3_CYGNSS_2021_ALLpointswithSMguage_withSM_&_staticvalues.RData")
