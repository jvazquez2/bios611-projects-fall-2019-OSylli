#---Load Necessary Packages---
library(tidyverse)
library(ggplot2)
install.packages("data.table",dependencies = TRUE,repos='http://cran.us.r-project.org')
library(data.table)

#---Question 1: The trend of the number of entry to UMD over time and the possible seasonal characteristics of the number of entry---
#---Date read in & Format of the recording of dates changed---
EntryExit<-read.delim(url("https://raw.githubusercontent.com/datasci611/bios611-projects-fall-2019-OSylli/master/project_3/data/ENTRY_EXIT_191102.tsv"))
EntryExit$Entry.Date<-as.Date(EntryExit$Entry.Date,format="%m/%d/%Y")
EntryExit$Exit.Date<-as.Date(EntryExit$Exit.Date,format="%m/%d/%Y")

#---Data wrangling---
Entry_Date<-as.data.frame(EntryExit) %>%
  filter(Entry.Date>="2014-07-01") %>%      # Drop imcomplete records and only keep the records after "2014-07-01"
  select("Entry.Date") %>%                  # Focus on the date of entry
  mutate(year=year(Entry.Date)) %>%         # Add new column "year" to see the trend of the number of entry to UMD over time
  mutate(month=month(Entry.Date))           # Add new column "month" to see the possible seasonal characteristics of the number of entry

#---Define a new data frame with columns "year", "month" and "count"---
EntryTrend<-Entry_Date %>%
  group_by(year,month) %>%
  summarise(count=n()) 

#---Build a time series and make a time series plot, in order to figure out its trend over time---
TS_EntryTrend<-ts(EntryTrend$count,frequency=12,start=c(2014,7))
TS_EntryTrend
ts.plot(TS_EntryTrend,ylab="Occurence")
points(TS_EntryTrend)
title("Time Series Plot: Trend of Entry to UMD from Jul 2014 to Oct 2019")

#---Build another data frame which focus on the number of entry in different months---
MonthlyEntry<-Entry_Date %>%
  group_by(month) %>%
  summarise(count=n())
MonthlyEntry$month<-as.factor(MonthlyEntry$month)

#---Visualization with ggplot---
ggplot(MonthlyEntry,aes(x=month,y=count))+
  geom_bar(stat="identity",width=0.8,colour="black",fill="dark blue")+
  theme_minimal()+
  labs(x="Month",
       y="Occuerence",
       title="Occurence of Entry in Different Months")



# Question 2: The relationship between duration of stay at UMD and clients' gender and race
# This question is done wih Python. For more information, please refer to the .ipynb Script in "/bios611-projects-fall-2019-OSylli/project_3/scripts/".



#---Question 3: The relationship between duration of stay at UMD and clients' age, live condition and Housing status at the time of entry---
#---Data read in---
CLIENT<-read.delim(url("https://raw.githubusercontent.com/datasci611/bios611-projects-fall-2019-OSylli/master/project_3/data/CLIENT_191102.tsv"))
QUESTION<-read.delim(url("https://raw.githubusercontent.com/datasci611/bios611-projects-fall-2019-OSylli/master/project_3/data/EE_UDES_191102.tsv"))

#---Since the column "Client ID" in the three tables "CLIENT", "QUESTION" and "EntryExit" are already matched, we can use rbind() directly to combine the datasets---
record<-cbind(CLIENT,QUESTION,EntryExit)
record<-record[,-c(11,13,14,15,32,33,34,35)]    # Drop the repeated columns

#---Basic wrangling---
record<-record %>%
  # Add new column to calculate the duration of stay at UMD
  mutate(duration=Exit.Date-Entry.Date) %>%
  # Select columns of interest and rename with simpler label
  select(Client.ID, Client.Age.at.Entry, Prior.Living.Situation.43., Housing.Status.2703., Does.the.client.have.a.disabling.condition..1935., duration) %>%
  rename(ID="Client.ID",age="Client.Age.at.Entry",LiveCondition="Prior.Living.Situation.43.",Housing="Housing.Status.2703.",DISABLE="Does.the.client.have.a.disabling.condition..1935.")

#---Part 1: Relationship between duration of stay at UMD and clients' age---
# Data wrangling
age_duration<-record %>%
  drop_na() %>%
  group_by(age) %>%
  summarise(Count=n(),AVE_Dur=mean(duration))

# Visualization with ggplot
ggplot(age_duration,aes(x=age,y=AVE_Dur))+
  geom_point()+
  geom_smooth()+
  labs(x="age",
       y="Average time of staying in UMD (Days)",
       title="The relationship between duration of stay and clients' age")+
  theme_minimal()


#---Part 2: Relationship between duration of stay at UMD and clients' living condition---
# Data wrangling
livecon_duration<-record %>%
  drop_na() %>%
  filter(LiveCondition!=""&LiveCondition!="Client doesn't know (HUD)"&LiveCondition!="Client refused (HUD)"&LiveCondition!="Data not collected (HUD)") %>%
  group_by(LiveCondition) %>%
  summarise(Count=n(),AVE_Dur=mean(duration))

# Visualization with a histogram
ggplot(livecon_duration,aes(x=LiveCondition,y=AVE_Dur))+
  geom_histogram(stat="identity",colour="black",fill="dark blue")+
  labs(x="Live Condition",
       y="Average time of staying in UMD (Days)",
       title="The relationship between duration of stay and clients' live condition")+
  scale_x_discrete(label=c("Emergency shelter,",
                           "Foster care (group) home",
                           "Hospital or residential non-psychiatric medical facility",
                           "Hotel/motel paid for without emergency shelter voucher",
                           "Interim Housing",
                           "Jail, prison or juvenile detention facility",
                           "Long-term care facility or nursing home",
                           "Other",
                           "Owned by client, no ongoing housing subsidy",
                           "Owned by client, with ongoing housing subsidy",
                           "Permanent housing for formerly homeless persons",
                           "Place not meant for habitation",
                           "Psychiatric hospital or other psychiatric facility",
                           "Rental by client, no ongoing housing subsidy",
                           "Rental by client, with GPD TIP housing subsidy",
                           "Rental by client, with other ongoing housing subsidy",
                           "Rental by client, with VASH housing subsidy",
                           "Residential project or halfway house with no homeless criteria",
                           "Safe Haven",
                           "Staying in a family member's house",
                           "Staying in a friend's house",
                           "Substance abuse treatment facility or detox center",
                           "Transitional housing for homeless persons"))+
  theme(axis.text.x = element_text(angle = 90, hjust = 1))

# Generate another histogram to help to see the relationship between the number of the entry and clients' living condition
ggplot(livecon_duration,aes(x=LiveCondition,y=Count))+
  geom_histogram(stat="identity",colour="black",fill="dark blue")+
  labs(x="Live Condition",
       y="Total times of Entry of the kind of Clients",
       title="The relationship between the total times of Entry of the kind of Clients\n and clients' live condition")+
  scale_x_discrete(label=c("Emergency shelter,",
                           "Foster care (group) home",
                           "Hospital or residential non-psychiatric medical facility",
                           "Hotel/motel paid for without emergency shelter voucher",
                           "Interim Housing",
                           "Jail, prison or juvenile detention facility",
                           "Long-term care facility or nursing home",
                           "Other",
                           "Owned by client, no ongoing housing subsidy",
                           "Owned by client, with ongoing housing subsidy",
                           "Permanent housing for formerly homeless persons",
                           "Place not meant for habitation",
                           "Psychiatric hospital or other psychiatric facility",
                           "Rental by client, no ongoing housing subsidy",
                           "Rental by client, with GPD TIP housing subsidy",
                           "Rental by client, with other ongoing housing subsidy",
                           "Rental by client, with VASH housing subsidy",
                           "Residential project or halfway house with no homeless criteria",
                           "Safe Haven",
                           "Staying in a family member's house",
                           "Staying in a friend's house",
                           "Substance abuse treatment facility or detox center",
                           "Transitional housing for homeless persons"))+
  theme(axis.text.x = element_text(angle = 90, hjust = 1))


#---Part 3: Relationship between duration of stay at UMD and clients' housing status---
# Data wrangling
housing_duration<-record %>%
  drop_na() %>%
  filter(Housing!=""&Housing!="Client doesn't know (HUD)"&Housing!="Client refused (HUD)") %>%
  group_by(Housing) %>%
  summarise(Count=n(),AVE_Dur=mean(duration))

# Visualization with a histogram
ggplot(housing_duration,aes(x=Housing,y=AVE_Dur))+
  geom_histogram(stat="identity",colour="black",fill="dark blue")+
  theme_minimal()+
  labs(x="Housing Status",
       y="Average time of staying in UMD (Days)",
       title="The relationship between duration of stay and clients' housing status")+
  scale_x_discrete(label=c("At risk\n of\n Homeless",
                           "Homeless","At imminent risk\n of\n losing housing",
                           "Homeless\n only under other\n federal statutes",
                           "Stably Housed"))
