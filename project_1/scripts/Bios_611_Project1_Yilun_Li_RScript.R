library(data.table)
library(tidyverse)
library(ggplot2)



#---Data Read in and Basic Preparation---
setwd("C:/Users/85091/Documents/GitHub/bios611-projects-fall-2019-OSylli/project_1/data")
data<-fread("UMD_Services_Provided_20190719.tsv")
data$Date<-as.Date(data$Date,format="%m/%d/%Y")
data<-data %>%
  arrange(Date) %>%                # Arrange the data by "Date" in the descending order
  filter(Date<"2019-07-19")        # Remove wrong record of date



#---Problem 1: Tendency of Occurence of Clothing Assitance over years/ Seasonal Characteristics of Average Clothing Items by month---
# Select columns "Date" and "Clothing Items", and then define two new variables "year" and "month" based on variable "Date"
data_cloth<-data %>%
  select("Date","Clothing Items") %>%
  drop_na() %>%
  mutate(year=year(Date),month=month(Date))

# Calculating:
# 1) the number of cloth assistance per year (column "count")
# 2) Yearly Average of Clothing Items Assistance normalized by the times of cloth assistance per year (column "ave")
data_cloth_year<-data_cloth %>%
  group_by(year) %>%
  summarise(count=n(),ave=mean(`Clothing Items`))

# Generating the Result with figures, and see how the variable "count" and "ave" change over years
# Since most records before 1997 are missing and 2019 is still ongoing, we only consider the quantity from 1997 to 2018
# Figure 1: Occurence of Clothing Assistance per Year (1997-2018)
ggplot(filter(data_cloth_year,year>=1997&year<=2018),aes(x=year,y=count))+
  geom_point()+
  geom_smooth()+
  labs(x="Year",
       y="Occuerence",
       title="Occurence of Assistance in Clothing by Year (1997-2018)")+
  theme_minimal()

# Figure 2: Yearly Average of Clothing Items Assistance (normalized by the times of cloth assistance per year)
ggplot(filter(data_cloth_year,year>=1997&year<=2018),aes(x=year,y=ave))+
  geom_point()+
  geom_smooth()+
  labs(x="Year",
       y="Average Clothing Items",
       title="Average of Clothing Items normalized by Occurence of Assistance in Clothing (1997-2018)")+
  theme_minimal()


# Next we try to fighre out whether there exists some seasonal characteristics in the variable "Clothing Items"
# calculate 
# 1) the number of cloth assistance in each month 
# 2) Average of Clothing Items Assistance normalized by the times of cloth assistance in each month
data_cloth_month<-data_cloth %>%
  group_by(month) %>%
  summarise(count=n(),ave=mean(`Clothing Items`))
data_cloth_month$month<-as.factor(data_cloth_month$month)

# Generating the Result with figures, and see how the variable "count" and "ave" behave in different months
# Figure 3: Occurence of Assistance in Clothing by Month
ggplot(data_cloth_month,aes(x=month,y=count))+
  geom_bar(stat="identity",width=0.8,colour="black",fill="dark blue")+
  theme_minimal()+
  labs(x="Month",
       y="Occuerence",
       title="Occurence of Assistance in Clothing by Month")

# Figure 4: Average of Clothing Items normalized by Occurence of Assistance in Clothing by Month
ggplot(data_cloth_month,aes(x=month,y=ave))+
  geom_bar(stat="identity",width=0.8,colour="black",fill="dark blue")+
  theme_minimal()+
  labs(x="Month",
       y="Average Clothing Items",
       title="Average of Clothing Items normalized by Occurence of Assistance in Clothing by Month")



#---Problem 2: Relationship between Food Pounds and Clothing Items---
data_new<-data %>%
  select(c("Date","Food Pounds","Clothing Items")) %>%
  drop_na()

# Add new columns indicating the quantile of "Food Pounds" and "Clothing Items" for each record
data_new<-cbind(data_new,
      Food=cut(data_new$`Food Pounds`,right=FALSE,breaks=c(quantile(data_new$`Food Pounds`,c(0,0.3,0.6,0.9)),max(data_new$`Food Pounds`)+1),labels=c("0-30%","30%-60%","60%-90%","90%-100%")),
      Cloth=cut(data_new$`Clothing Items`,right=FALSE,breaks=c(quantile(data_new$`Clothing Items`,c(0,0.3,0.6,0.9)),max(data_new$`Clothing Items`)+1),labels=c("0-30%","30%-60%","60%-90%","90%-100%")))

# Generating the result with a table
xtabs(~data_new$Food+data_new$Cloth)

# Generating the result with a figure
# Figure 5: Relationship between the value of Food Pounds and Clothing Items in individual assistance case
ggplot(data_new,aes(x=Food,y=Cloth))+
  geom_bin2d()+
  labs(x="Food Pounds",
       y="Clothing Items",
       title="Relationship between Food Pounds and Clothing Items in individual assistance case")+
  theme_minimal()
