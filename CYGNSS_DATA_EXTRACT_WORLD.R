rm(list = ls())
library(ncdf4)
library(raster)
library(rgdal)
library(tidyverse)
library(sf)
library(dplyr)

raster_file<-raster("X:/CALADONIA/ERA5_CSV/TEMP_MAX_002307.tif")
#list daily folders in the directory
data_folder<-("Z:/DATA_RAW/CYGNSS/LV_2.1/2020/")
dir_list<-dir(path = data_folder, pattern = NULL, all.files = FALSE,
              full.names = FALSE, recursive = FALSE,
              ignore.case = FALSE, include.dirs = FALSE, no.. = FALSE)

for (z in 1: length(dir_list))
{
  setwd(paste0(data_folder,dir_list[z]))
  filelist<-list.files(path = ".", pattern = ".nc$", all.files = FALSE,
                       full.names = FALSE, recursive = FALSE,
                       ignore.case = FALSE, include.dirs = FALSE, no.. = FALSE)
  lon=NULL
  lat=NULL
  inc_angle=NULL
  sp_rx_gain=NULL
  rx_to_sp_range=NULL
  tx_to_sp_range=NULL
  ddm_snr=NULL
  #fresnel_coeff=NULL
  power_max=NULL
  noise_median=NULL
  noise_mean=NULL
  gps_eirp=NULL
  #tx_clk_bias=NULL
  TIME_ALL=NULL
  
  for(y in 1:length(filelist))
  {
    ncin <- nc_open(filelist[y])
    lon<-  c(lon,as.vector(ncvar_get(ncin,"sp_lon")))
    lat <- c(lat,as.vector(ncvar_get(ncin,"sp_lat")))
    inc_angle<-c(inc_angle,as.vector(ncvar_get(ncin,"sp_inc_angle")))
    sp_rx_gain<-c(sp_rx_gain,as.vector(ncvar_get(ncin,"sp_rx_gain")))
    rx_to_sp_range<-c(rx_to_sp_range,as.vector(ncvar_get(ncin,"rx_to_sp_range")))
    tx_to_sp_range<-c(tx_to_sp_range,as.vector(ncvar_get(ncin,"tx_to_sp_range")))
    ddm_snr<-c(ddm_snr,as.vector(ncvar_get(ncin,"ddm_snr")))
    #fresnel_coeff<-c(fresnel_coeff,as.vector(ncvar_get(ncin,"fresnel_coeff")))
    gps_eirp<-c(gps_eirp,as.vector(ncvar_get(ncin,"gps_eirp")))
    #tx_clk_bias<-c(tx_clk_bias,as.vector(ncvar_get(ncin,"tx_clk_bias")))
    
    a<-dim((ncvar_get(ncin,"sp_lon")))
    power_max1<-matrix(NA,nrow=a[1],ncol=a[2])
    noise_median1<-matrix(NA,nrow=a[1],ncol=a[2])
    noise_mean1<-matrix(NA,nrow=a[1],ncol=a[2])
    power<-ncvar_get(ncin,"power_analog")
    dim1=a[1]
    dim2=a[2]
    
    for (a in 1:dim1)
    {
      for (b in 1:dim2)
      {
        data<-power[,,a,b]
        PMAX<-max(data, na.rm = FALSE)
        NMED<-median(data[1,], na.rm = FALSE)
        NMEAN<-mean(data[1,],na.rm=TRUE)
        power_max1[a,b]=PMAX
        noise_median1[a,b]=NMED
        noise_mean1[a,b]=NMEAN
      }
    }
    
    power_max<-c(power_max,as.vector(power_max1))
    noise_median<-c(noise_median,as.vector(noise_median1))
    noise_mean<-c(noise_mean,as.vector(noise_mean1))
    
    #fixingthetime
    time<-ncatt_get(ncin,"ddm_timestamp_utc","units")
    time<-str_sub(time$value,-29)
    time<-str_sub(time,1,-11)
    time<-as.POSIXct(time,tz="UTC")
    time_step<-ncvar_get(ncin,"ddm_timestamp_utc")
    time_step<-time_step+time
    time_step<-as.character(time_step)
    time_step_all<-c(time_step,time_step,time_step,time_step)
    TIME_ALL<-c(TIME_ALL,time_step_all) 

  }

  preff<-power_max-noise_median+((rx_to_sp_range+tx_to_sp_range)^2)-sp_rx_gain+(cos(inc_angle)^2)
  tow<-{((4*3.14)^2)*(power_max-noise_mean)*((rx_to_sp_range+tx_to_sp_range)^2)}/{(0.16*0.16*(gps_eirp)*(sp_rx_gain))}
  
  #fixingthetime
  database<-data.frame(LAT=lat,
                       LON=lon-180,
                       INC_ANG=inc_angle,
                       SP_RX_GAIN=sp_rx_gain,
                       RX_TO_SP_RANGE=rx_to_sp_range,
                       TX_TO_SP_RANGE=tx_to_sp_range,
                       DDM_SNR=ddm_snr,
                       #FRESNEL_COEFF=fresnel_coeff,
                       GPS_EIRP=gps_eirp,
                       #TX_CLK_BIAS=tx_clk_bias,
                       POWER_MAX=power_max,
                       NOISE_MEDIAN=noise_median,
                       NOISE_MEAN=noise_mean,
                       PREFF=preff,
                       TOW=tow,
                       TIME=TIME_ALL)
  
  database2<-filter(database,!(is.na(LAT)))
  point<- st_as_sf(database2, coords = c("LON", "LAT"), crs = crs(raster_file))
  outname<-paste0("Z:/PROCESS/CYGNSS/gpkg/WORLD/data_2020/CYGNSS_",dir_list[z],".gpkg")
  st_write(point,outname)
  print(dir_list[z])
}
