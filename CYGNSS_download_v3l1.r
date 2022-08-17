
rm(list = ls())
#calling all library needed
library(sf)
library(raster)
library(rgdal)
library(spData)
library(tidyverse)
#adding scraplink fucntion extension
source("E:/RAJASWETA/CYGNSS_data/progs/scraplinks.R")

#cygnss website
website<-"https://podaac-opendap.jpl.nasa.gov/opendap/allData/cygnss/L1/v3.0/"

#defining year of interest
year<-c("2021")

#start and end data
start_JD<-1
end_JD<-150
days<-seq(start_JD,end_JD,1)

# setting working directory and folder in which files will be saved
setwd("E:/RAJASWETA/CYGNSS_data/raw_data/")

for (i in 1:length(year))
{
  for (d in 1: length(days))
  {
    # making sure the days are in right format like 001 010 100
    if (days[d]<10)
    {
      date<-paste0("/00",as.character(days[d]),"/contents.html")
    }    else if (days[d]<100 & days[d]>9)
    {
      date<-paste0("/0",as.character(days[d]),"/contents.html")  
    }    else if (days[d]<366 & days[d]>99) 
    {
      date<-paste0("/",as.character(days[d]),"/contents.html") 
    }
    
    #preparing the link of the page with the files
    url<-paste0(website,year[1],date)
    data<-scraplinks(url)
    
    #selecting only the files that are needed
    url_needed<-data$url
    url_needed<-grep('.nc$', url_needed, value=TRUE)
    n_last <- 69      
    url_needed<-substr(url_needed, nchar(url_needed) - n_last + 1, nchar(url_needed)) 
    url_needed#create a folder for each day
if (days[d]<10)
    {
      day<-paste0("00",as.character(days[d]))
    }    else if (days[d]<100 & days[d]>9)
    {
      day<-paste0("0",as.character(days[d]))  
    }    else if (days[d]<366 & days[d]>99)
    {
      day<-paste0(as.character(days[d])) 
    }
    dir_name<-paste0("Day_",day)
    dir.create(dir_name)
    # downloading the files in the list
    for( k in 1:length(url_needed))
    {
      download_link <- paste0(substr(url,1,nchar(url)-13),url_needed[k],".nc")
      download.file(download_link , destfile=paste0("E:/RAJASWETA/CYGNSS_data/raw_data/",dir_name,"/",basename(download_link)), method="curl", extra="-k")
      
    }
    
  }  
  
}
