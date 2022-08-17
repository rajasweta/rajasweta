rm(list = ls())
#calling all library needed
library(sf)
library(raster)
library(rgdal)
library(spData)
library(tidyverse)
#adding scraplink fucntion extension
source("Z:/PROGS/scraplinks.R")

#cygnss website
website<-"https://podaac-opendap.jpl.nasa.gov/opendap/allData/cygnss/L3/soil_moisture/v1.0/"

#defining year of interest
year<-c("2017")

#start and end data
start_JD<-77
end_JD<-365
days<-seq(start_JD,end_JD,1)

# setting working directory and folder in which files will be saved
setwd("Z:/DATA_RAW/CYGNSS/SM_products/V1/")

for (i in 1:length(year))
{
  dir_name<-paste0("CYGNSS_SM_DATA_",year[1])
  dir.create(dir_name)
  
  for (d in 1: length(days))
  {
    # making sure the days are in right format like 001 010 100
    if (days[d]<10)
    {
      date<-paste0("/00",as.character(days[d]),"/ucar_cu_cygnss_sm_v1_",year,"_00",as.character(days[d]),".nc")
    }    else if (days[d]<100 & days[d]>9)
    {
      date<-paste0("/0",as.character(days[d]),"/ucar_cu_cygnss_sm_v1_",year,"_0",as.character(days[d]),".nc")
    }    else if (days[d]<366 & days[d]>99) 
    {
      date<-paste0("/",as.character(days[d]),"/ucar_cu_cygnss_sm_v1_",year,"_",as.character(days[d]),".nc")
    }
    
    #preparing the link of the page with the files
    url<-paste0(website,year[1],date)
    filename<- paste0("Z:/DATA_RAW/CYGNSS/SM_products/V1/",dir_name,"/",basename(url))
    download.file(url ,destfile = filename, method="curl", extra="-k")
    
    
  }  
  
}



