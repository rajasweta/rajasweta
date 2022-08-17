rm(list = ls())
#calling all library needed

library(raster)
library(rgdal)
library(gdalUtils)
library(sp)
library(sf)
library(raster)
library(lubridate)
library(stringr)
basefolder<-"Z:/DATA_RAW/GPM/2021"
files<-list.files(basefolder,pattern = "30min.tif$",full.names=TRUE, recursive = TRUE)
dates<-substr(files,53,68)
dates<-paste0(substr(dates,1,4),"/",substr(dates,5,6),"/",substr(dates,7,8)," ", substr(dates,11,12),":",substr(dates,13,14),":",substr(dates,15,16))
date_num<-as.POSIXct(dates, tz="UTC")
GPM_DF<- data.frame(PATH=files,DATE=dates,DATE_NUM=date_num)

#importing CYGNSS_data
data<-st_read("Z:/PROCESS/CYGNSS_ISMN_datapoints/2021/TIER3_CYGNSS_2021_ALLpointswithSMguage_withSM_&_staticvalues.gpkg")
data$TIME_NUM<-as.POSIXct(data$TIME, tz="UTC")
data$GPM<-NA

for (i in 1:nrow(data))
{
  #finding the nearest date to the vector from NDVI dates
  loc<-which(abs(GPM_DF$DATE_NUM-data$TIME_NUM[i]) == min(abs(GPM_DF$DATE_NUM - data$TIME_NUM[i])))
  file<-raster(GPM_DF$PATH[loc[1]])
  point<-st_as_sf(data$geom[i])
  point<-st_transform(point, crs = st_crs(file))
  value<- raster::extract(file,point,fun=max) 
  data$GPM[i]<-value
  print(paste0("working on GPM...line.....",i,"of.....",nrow(data),"...........done"))
  
}

st_write(st_as_sf(data),"Z:/PROCESS/CYGNSS_ISMN_datapoints/2021/test1_TIER4_CYGNSS_2021_ALLpointswithSMguage_withSM_&_staticvalues_&_GPM_NDVI_EVI.gpkg")
write.csv(data,"Z:/PROCESS/CYGNSS_ISMN_datapoints/2021/test1_TIER4_CYGNSS_2021_ALLpointswithSMguage_withSM_&_staticvalues_&_GPM_NDVI_EVI.csv")
save(data,file="Z:/PROCESS/CYGNSS_ISMN_datapoints/2021/test1_TIER4_CYGNSS_2021_ALLpointswithSMguage_withSM_&_staticvalues_&_GPM_NDVI_EVI.RData") 

rm(list=setdiff(ls(), "data"))
basefolder<-"Z:/DATA_RAW/MODIS/NDVI/2021/"
files<-list.files(basefolder,pattern = ".vrt$",full.names=TRUE, recursive = FALSE)
dates<-substr(files,34,43)
dates<-str_replace_all( dates,"_", "/")
date_num<-as.POSIXct(dates, tz="UTC")
NDVI_DF<- data.frame(PATH=files,DATE=dates,DATE_NUM=date_num)
data$NDVI<-NA

for (i in 1:nrow(data))
{
  #finding the nearest date to the vector from NDVI dates
  loc<-which(abs(NDVI_DF$DATE_NUM-data$TIME_NUM[i]) == min(abs(NDVI_DF$DATE_NUM - data$TIME_NUM[i])))
  file<-raster(NDVI_DF$PATH[loc[1]])
  point<-st_as_sf(data$geom[i])
  point<-st_transform(point, crs = st_crs(file))
  value<- raster::extract(file,point,fun=max) 
  data$NDVI[i]<-value
  print(paste0("working on NDVI...line.....",i,"of.....",nrow(data),"...........done"))
  
}

st_write(st_as_sf(data),"Z:/PROCESS/CYGNSS_ISMN_datapoints/2021/test2_TIER4_CYGNSS_2021_ALLpointswithSMguage_withSM_&_staticvalues_&_GPM_NDVI_EVI.gpkg")
write.csv(data,"Z:/PROCESS/CYGNSS_ISMN_datapoints/2021/test2_TIER4_CYGNSS_2021_ALLpointswithSMguage_withSM_&_staticvalues_&_GPM_NDVI_EVI.csv")
save(data,file="Z:/PROCESS/CYGNSS_ISMN_datapoints/2021/test2_TIER4_CYGNSS_2021_ALLpointswithSMguage_withSM_&_staticvalues_&_GPM_NDVI_EVI.RData") 


rm(list=setdiff(ls(), "data"))
basefolder<-"Z:/DATA_RAW/MODIS/EVI/2021/"
files<-list.files(basefolder,pattern = ".vrt$",full.names=TRUE, recursive = FALSE)
dates<-substr(files,34,43)
dates<-str_replace_all( dates,"_", "/")
date_num<-as.POSIXct(dates, tz="UTC")
EVI_DF<- data.frame(PATH=files,DATE=dates,DATE_NUM=date_num)
data$EVI<-NA

for (i in 1:nrow(data))
{
  #finding the nearest date to the vector from NDVI dates
  loc<-which(abs(EVI_DF$DATE_NUM-data$TIME_NUM[i]) == min(abs(EVI_DF$DATE_NUM - data$TIME_NUM[i])))
  file<-raster(EVI_DF$PATH[loc[1]])
  point<-st_as_sf(data$geom[i])
  point<-st_transform(point, crs = st_crs(file))
  value<- raster::extract(file,point,fun=max) 
  data$EVI[i]<-value
  print(paste0("working on EVI...line.....",i,"of.....",nrow(data),"...........done"))
  
}

st_write(st_as_sf(data),"Z:/PROCESS/CYGNSS_ISMN_datapoints/2021/TIER4_CYGNSS_2021_ALLpointswithSMguage_withSM_&_staticvalues_&_GPM_NDVI_EVI.gpkg")
write.csv(data,"Z:/PROCESS/CYGNSS_ISMN_datapoints/2021/TIER4_CYGNSS_2021_ALLpointswithSMguage_withSM_&_staticvalues_&_GPM_NDVI_EVI.csv")
save(data,file="Z:/PROCESS/CYGNSS_ISMN_datapoints/2021/TIER4_CYGNSS_2021_ALLpointswithSMguage_withSM_&_staticvalues_&_GPM_NDVI_EVI.RData")