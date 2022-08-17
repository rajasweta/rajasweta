# Reformated to produce a list of URLs to download, in an html file, rather than downloading 

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
website<-"https://podaac-opendap.jpl.nasa.gov/opendap/allData/cygnss/L1/v2.1/"

#defining year of interest
year<-c("2020")

#start and end data
start_JD<-201
end_JD<-300
days<-seq(start_JD,end_JD,1)

# setting working directory and folder in which files will be saved
setwd("Z:/DATA_RAW/CYGNSS/LV_2.1/2020/")
write("<!DOCTYPE html><html><body>", file = "filelist.html")
data_download <- data.frame(matrix(ncol=5,nrow=0, dimnames=list(NULL, c("year", "day", "filename", "url", "dir"))))

for (i in 1:length(year))
{
  message("year = ", i)
  
  for (d in 1: length(days))
  {
    message("days = ", d)
    # sprintf("%.5d", 3)
    # making sure the days are in right format like 001 010 100
    if (days[d]<10)
    {
      date<-paste0("/00",as.character(days[d]),"/contents.html")
    }    else if (days[d]<100 & days[d]>9)
    {
      date<-paste0("/0",as.character(days[d]),"/contents.html")  
    }    else if (days[d]<=366 & days[d]>99) 
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
    url_needed
    
    if (days[d]<10)
    {
      day<-paste0("00",as.character(days[d]))
    }    else if (days[d]<100 & days[d]>9)
    {
      day<-paste0("0",as.character(days[d]))  
    }    else if (days[d]<367 & days[d]>99)
    {
      day<-paste0(as.character(days[d])) 
    }
    
    #create a folder for each day
    dir_name<-paste0(year[1],"_Day_L1V2_",day)
    # dir.create(dir_name)
    
    download_link <- paste0(substr(url,1,nchar(url)-13),url_needed)
    
    
    write(paste0("<p><a href=\"",download_link,"\">",download_link,"</a></p>"), file = "filelist.html", append = TRUE)
    
    # Save info to a dataframe for later use
    data_download <- rbind(data_download,
          data.frame("year" = i, "day" = d, "filename" = url_needed, "url" = download_link, "dir" = dir_name))
    
    
    # for( k in 1:length(url_needed))
    # {
    #   download_link <- paste0(substr(url,1,nchar(url)-13),url_needed[k])
    #   # require(downloader)
    #   # download(download_link,paste0("Z:/DATA_RAW/CYGNSS/LV_2.1/2021/",dir_name,"/",basename(download_link)), mode="wb")
    #   download.file(download_link ,destfile = paste0("R:/DATA_RAW/CYGNSS/LV_2.1/2020/",dir_name,"/",basename(download_link)), method="curl", extra="-k")
    #   # download.file(download_link ,destfile = paste0("R:/DATA_RAW/CYGNSS/LV_2.1/2020/",dir_name,"/",basename(download_link)), method="wininet")
    # }
    
  }  
  
}

write("</body></html>", file = "filelist.html", append = TRUE)
write.csv(data_download, file = "filelist.csv", row.names = FALSE)
save(data_download, file = "filelist.RData")
