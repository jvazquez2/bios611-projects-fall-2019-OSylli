library(tidyverse)

# Question 1: The trend of the number of entry to UMD over years and the possible seasonal characteristics of the number of entry.
EntryExit<-read.delim(url("https://raw.githubusercontent.com/datasci611/bios611-projects-fall-2019-OSylli/master/project_3/data/ENTRY_EXIT_191102.tsv"))
EntryExit$Entry.Date<-as.Date(EntryExit$Entry.Date,format="%m/%d/%Y")
EntryExit$Exit.Date<-as.Date(EntryExit$Exit.Date,format="%m/%d/%Y")
Entry_Date<-as.data.frame(EntryExit) %>%
  filter(Entry.Date>="2014-07-01") %>%
  select("Entry.Date") %>%
  mutate(year=year(Entry.Date)) %>%
  mutate(month=month(Entry.Date))

EntryTrend<-Entry_Date %>%
  group_by(year,month) %>%
  summarise(count=n()) 

TS_EntryTrend<-ts(EntryTrend$count,frequency=12,start=c(2014,7))
TS_EntryTrend
ts.plot(TS_EntryTrend,ylab="Occurence")
points(TS_EntryTrend)
title("Time Series Plot: Trend of Entry to UMD from Jul 2014 to Oct 2019")

MonthlyEntry<-Entry_Date %>%
  group_by(month) %>%
  summarise(count=n())
MonthlyEntry$month<-as.factor(MonthlyEntry$month)

ggplot(MonthlyEntry,aes(x=month,y=count))+
  geom_bar(stat="identity",width=0.8,colour="black",fill="dark blue")+
  theme_minimal()+
  labs(x="Month",
       y="Occuerence",
       title="Occurence of Entry in Different Months")



# Question 2: The relationship between duration of stay at UMD and clients' gender and race
# This question is done wih Python. For more information, please refer to the .ipynb Script in "/bios611-projects-fall-2019-OSylli/project_3/scripts/".



# Question 3: The relationship between duration of stay at UMD and clients' age, live condition and Housing status at the time of entry.
CLIENT<-read.delim(url("https://raw.githubusercontent.com/datasci611/bios611-projects-fall-2019-OSylli/master/project_3/data/CLIENT_191102.tsv"))
QUESTION<-read.delim(url("https://raw.githubusercontent.com/datasci611/bios611-projects-fall-2019-OSylli/master/project_3/data/EE_UDES_191102.tsv"))

# Since the column "Client ID" in the three tables "CLIENT", "QUESTION" and "EntryExit" are already matched, we can use rbind() directly to combine the datasets
record<-cbind(CLIENT,QUESTION,EntryExit)
record<-record[,-c(11,13,14,15,32,33,34,35)]
record<-record %>%
  mutate(duration=Exit.Date-Entry.Date) %>%
  select(Client.ID, Client.Age.at.Entry, Prior.Living.Situation.43., Housing.Status.2703., Does.the.client.have.a.disabling.condition..1935., duration) %>%
  rename(ID="Client.ID",age="Client.Age.at.Entry",LiveCondition="Prior.Living.Situation.43.",Housing="Housing.Status.2703.",DISABLE="Does.the.client.have.a.disabling.condition..1935.")

age_duration<-record %>%
  drop_na() %>%
  group_by(age) %>%
  summarise(Count=n(),AVE_Dur=mean(duration))

ggplot(age_duration,aes(x=age,y=AVE_Dur))+
  geom_point()+
  geom_smooth()+
  labs(x="age",
       y="Average time of staying in UMD (Days)",
       title="The relationship between duration of stay and clients' age")+
  theme_minimal()

livecon_duration<-record %>%
  drop_na() %>%
  filter(LiveCondition!=""&LiveCondition!="Client doesn't know (HUD)"&LiveCondition!="Client refused (HUD)"&LiveCondition!="Data not collected (HUD)") %>%
  group_by(LiveCondition) %>%
  summarise(Count=n(),AVE_Dur=mean(duration))

ggplot(livecon_duration,aes(x=LiveCondition,y=AVE_Dur))+
  geom_histogram(stat="identity",colour="black",fill="dark blue")+
  theme_minimal()+
  labs(x="Live Condition",
       y="Average time of staying in UMD (Days)",
       title="The relationship between duration of stay and clients' live condition")+
  scale_x_discrete(label=c("Emergency\n shelter,",
                           "Foster\n care\n (group)\n home",
                           "Hospital\n or\n residential\n non-\npsychiatric\n medical\n facility",
                           "Hotel/motel\n paid for\n without\n emergency\n shelter\n voucher",
                           "Interim\n Housing",
                           "Jail, prison\n or\n juvenile\n detention\n facility",
                           "Long-term\n care\n facility\n or\n nursing\n home",
                           "Other",
                           "Owned by\n client,\n no ongoing\n housing\n subsidy",
                           "Owned by\n client,\n with ongoing\n housing\n subsidy",
                           "Permanent\n housing\n for\n formerly\n homeless\n persons",
                           "Place\n not\n meant for\n habitation",
                           "Psychiatric\n hospital\n or\n other\n psychiatric\n facility",
                           "Rental by\n client,\n no\n ongoing\n housing\n subsidy",
                           "Rental by\n client,\n with\n GPD\n TIP\n housing\n subsidy",
                           "Rental by\n client,\n with\n other\n ongoing\n housing\n subsidy",
                           "Rental by\n client,\n with\n VASH\n housing\n subsidy",
                           "Residential\n project\n or\n halfway\n house\n with\n no\n homeless\n criteria",
                           "Safe\n Haven",
                           "Staying\n in a\n family\n member's\n house",
                           "Staying\n in a\n friend's\n house",
                           "Substance\n abuse\n treatment\n facility\n or\n detox center",
                           "Transitional\n housing\n for\n homeless\n persons"))

ggplot(livecon_duration,aes(x=LiveCondition,y=Count))+
  geom_histogram(stat="identity",colour="black",fill="dark blue")+
  theme_minimal()+
  labs(x="Live Condition",
       y="Total times of Entry of the kind of Clients",
       title="The relationship between the total times of Entry of the kind of Clients and clients' live condition")+
  scale_x_discrete(label=c("Emergency\n shelter,",
                           "Foster\n care\n (group)\n home",
                           "Hospital\n or\n residential\n non-\npsychiatric\n medical\n facility",
                           "Hotel/motel\n paid for\n without\n emergency\n shelter\n voucher",
                           "Interim\n Housing",
                           "Jail, prison\n or\n juvenile\n detention\n facility",
                           "Long-term\n care\n facility\n or\n nursing\n home",
                           "Other",
                           "Owned by\n client,\n no ongoing\n housing\n subsidy",
                           "Owned by\n client,\n with ongoing\n housing\n subsidy",
                           "Permanent\n housing\n for\n formerly\n homeless\n persons",
                           "Place\n not\n meant for\n habitation",
                           "Psychiatric\n hospital\n or\n other\n psychiatric\n facility",
                           "Rental by\n client,\n no\n ongoing\n housing\n subsidy",
                           "Rental by\n client,\n with\n GPD\n TIP\n housing\n subsidy",
                           "Rental by\n client,\n with\n other\n ongoing\n housing\n subsidy",
                           "Rental by\n client,\n with\n VASH\n housing\n subsidy",
                           "Residential\n project\n or\n halfway\n house\n with\n no\n homeless\n criteria",
                           "Safe\n Haven",
                           "Staying\n in a\n family\n member's\n house",
                           "Staying\n in a\n friend's\n house",
                           "Substance\n abuse\n treatment\n facility\n or\n detox center",
                           "Transitional\n housing\n for\n homeless\n persons"))

housing_duration<-record %>%
  drop_na() %>%
  filter(Housing!=""&Housing!="Client doesn't know (HUD)"&Housing!="Client refused (HUD)") %>%
  group_by(Housing) %>%
  summarise(Count=n(),AVE_Dur=mean(duration))

ggplot(housing_duration,aes(x=Housing,y=AVE_Dur))+
  geom_histogram(stat="identity",colour="black",fill="dark blue")+
  theme_minimal()+
  labs(x="Housing Status",
       y="Average time of staying in UMD (Days)",
       title="The relationship between duration of stay and clients' housing status")+
  scale_x_discrete(label=c("At risk\n of\n Homeless","Homeless","At imminent risk\n of\n losing housing","Homeless\n only under other\n federal statutes","Stably Housed"))
