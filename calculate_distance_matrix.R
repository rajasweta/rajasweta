dist_matrix<-pointDistance(data2,test,  lonlat=TRUE, allpairs=TRUE)
locs<-colMins(dist_matrix, value = FALSE)
test$ISWN_NAMES<-data2$NAME[locs[1:length(locs)]]
test$TIME[1:length(test$ISWN_NAMES)]<-"2017-04-18 13:00:00"
test$SM[1:length(test$ISWN_NAMES)]<-NA
load("Z:/PROCESS/ISMN/ISMN_data_2017_2018.RData")
database$DATE_TIME_NUM<-as.numeric(as.POSIXct(database$DATE_TIME))
TIME_NUM<-as.numeric(as.POSIXct(test$TIME))
for (i in 1:length(TIME_NUM))
{#check time in list and get location
  a<-which(TIME_NUM[i]==database$DATE_TIME_NUM )
  coloumn<-database[test$ISWN_NAMES[i]]
  test$SM[i]<-coloumn[[1]][a]
}
######################################################################################################