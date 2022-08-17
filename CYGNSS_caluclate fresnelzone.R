rm(list = ls())
library(sf)
library(raster)
library(rgdal)
library(spData)
library(ggplot2)

setwd('Z:/PROCESS/CYGNSS/gpkg/WORLD/2017_18/')
filelist<-list.files(path = ".", pattern = ".gpkg$", all.files = FALSE,
                     full.names = FALSE, recursive = FALSE,
                     ignore.case = FALSE, include.dirs = FALSE, no.. = FALSE)

world_data<-st_read(filelist[1])

world_data$INC_ANG[world_data$INC_ANG<0]<-NA
world_data$INC_ANG[world_data$INC_ANG>180]<-NA
max(world_data$INC_ANG, na.rm=TRUE)
min(world_data$INC_ANG, na.rm=TRUE)


plot(data)
length(data)
hist(data)


1798348-1065632
732716

#calculate a and b major and minor axis
# RX_TO_SP_RANGE
# TX_TO_SP_RANG
# INC_ANG 
world_data$RX_TO_SP_RANGE[world_data$RX_TO_SP_RANGE==9999999]<-NA
world_data$TX_TO_SP_RANGE[world_data$TX_TO_SP_RANGE==9999999]<-NA


