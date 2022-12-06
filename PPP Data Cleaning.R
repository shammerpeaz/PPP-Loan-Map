#Project
#DATA 824
#Sara Hammersmith Peaslee

####Data Cleaning Code####

library(dplyr)
library(tidygeocoder)
library(tidyr)
library(lubridate)

#Import Data downloaded from 
#https://data.colorado.gov/Business/Paycheck-Protection-Program-Loans-in-Colorado/73ay-2ues
pploans<-read.csv("Paycheck_Protection_Program_Loans_in_Colorado.csv",sep=",",dec=".")

#Data prep for Zip Code 81001
p81001<-pploans[pploans$Zip=='81001',] #Selecting Zip Code 81001 rows

#Uniting Address columns for geocode prep
p81001.u<-unite(p81001,col='Address',c('Address','City','State','Zip'),sep=",")

t1<-p81001.u[1:27,] #Selecting rows with listed addresses

t1$DateApproved<-mdy(t1$DateApproved) #Changing date to correct format

t1.g<- t1 %>%   #Adding on latitude/longitude columns for leaflet application
  geocode(Address)

#Same process as above for Zip Code 81003
p81003<-pploans[pploans$Zip=='81003',]
p81003.u<-unite(p81003,col='Address',c('Address','City','State','Zip'),sep=",")
t3<-p81003.u[1:49,]
t3$DateApproved<-mdy(t3$DateApproved)
t3.g<- t3 %>%
  geocode(Address)

#Same process as above for Zip Code 81004
p81004<-pploans[pploans$Zip=='81004',]
p81004.u<-unite(p81004,col='Address',c('Address','City','State','Zip'),sep=",")
t4<-p81004.u[1:17,]
t4$DateApproved<-mdy(t4$DateApproved)
t4.g<- t4 %>%
  geocode(Address)

#Same process as above for Zip Code 81005
p81005<-pploans[pploans$Zip=='81005',]
p81005.u<-unite(p81005,col='Address',c('Address','City','State','Zip'),sep=",")
t5<-p81005.u[1:22,]
t5$DateApproved<-mdy(t5$DateApproved)
t5.g<- t5 %>%
  geocode(Address)

#Same process as above for Zip Code 81007
p81007<-pploans[pploans$Zip=='81007',]
p81007.u<-unite(p81007,col='Address',c('Address','City','State','Zip'),sep=",")
t7<-p81007.u[1:16,]
t7$DateApproved<-mdy(t7$DateApproved)
t7.g<- t7 %>%
  geocode(Address)

#Combining Pueblo Zip Code Data frames into one
pueblo<-rbind(t1.g,t3.g,t4.g,t5.g,t7.g)
View(pueblo)

#Selecting rows with NA in Latitude/Longitude for manual search by address
pueblo.na<-pueblo[is.na(pueblo$lat),]
View(pueblo.na)

#Replacing NA latitude/longitude with values from manual search
#Also Replacing two addresses with incorrect latitude/longitude from geocode
pueblo[1,15]<-38.30659
pueblo[1,16]<--104.59774
pueblo[4,15]<-38.25580
pueblo[4,16]<--104.58504
pueblo[7,15]<-38.28099
pueblo[7,16]<--104.48978
pueblo[12,15]<-38.24577
pueblo[12,16]<--104.56131
pueblo[15,15]<-38.27620
pueblo[15,16]<--104.55104
pueblo[20,15]<-38.27151
pueblo[20,16]<--104.52227
pueblo[21,15]<-38.27302
pueblo[21,16]<--104.52861
pueblo[26,15]<-38.27472
pueblo[26,16]<--104.51575
pueblo[29,15]<-38.27993
pueblo[29,16]<--104.63435
pueblo[35,15]<-38.26511
pueblo[35,16]<--104.61446
pueblo[37,15]<-38.28270
pueblo[37,16]<--104.61373
pueblo[45,15]<-38.26517
pueblo[45,16]<--104.60913
pueblo[57,15]<-38.27233
pueblo[57,16]<--104.60938
pueblo[59,15]<-38.28260
pueblo[59,16]<--104.61374
pueblo[62,15]<-38.28225
pueblo[62,16]<--104.61132
pueblo[68,15]<-38.27701
pueblo[68,16]<--104.67013
pueblo[70,15]<-38.27230
pueblo[70,16]<--104.60943
pueblo[74,15]<-38.27327
pueblo[74,16]<--104.60501
pueblo[76,15]<-38.28221
pueblo[76,16]<--104.61095
pueblo[86,15]<-38.23412
pueblo[86,16]<--104.62123
pueblo[92,15]<-37.93105
pueblo[92,16]<--104.87864
pueblo[93,15]<-38.25598
pueblo[93,16]<--104.62687
pueblo[95,15]<-38.25530
pueblo[95,16]<--104.97102
pueblo[101,15]<-38.22178
pueblo[101,16]<--104.64299
pueblo[116,15]<-38.33136
pueblo[116,16]<--104.70844
pueblo[119,15]<-38.33142
pueblo[119,16]<--104.80473
pueblo[120,15]<-38.30171
pueblo[120,16]<--104.81693
pueblo[125,15]<-38.32924
pueblo[125,16]<--104.71243
pueblo[127,15]<-38.32453
pueblo[127,16]<--104.72730
pueblo[131,15]<-38.33191
pueblo[131,16]<--104.71022

#Deleting 96th row - Colorado Springs address given wrong Zip Code
pueblo<-pueblo[-96,]

View(pueblo)

#Saving File
save(pueblo,file="puebloppp.RData")
write.csv(pueblo,"puebloppp.csv")
