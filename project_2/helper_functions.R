library(tidyverse)
library(ggplot2)
library(data.table)
library(shiny)



#--- Data Import ---
data<-read_tsv(url("https://raw.githubusercontent.com/datasci611/bios611-projects-fall-2019-OSylli/master/project_2/data/UMD_Services_Provided_20190719.tsv"))          # Data Import
data$Date<-as.Date(data$Date,format="%m/%d/%Y")            # Correct the format for date record
data<-data %>%
  arrange(Date) %>%                # Arrange the data by "Date" in the ascending order
  filter(Date>="1983-01-01") %>%   # Since UMD is founded in 1983
  filter(Date<"2019-07-19")        # Remove wrong record of date



#--- Part 1: The trend of different variables ("Food Pounds", "Clothing Items", "Diapers", "School Kits", "Hygiene Kits", "Financial Support") since 1997 ---
# Data Preparation function
Data_preparetion<-function(x_variable){
  data_selected<-data %>%
    # Pick up selected variables
    select("Date",matches(x_variable)) %>%
    # drop useless records
    filter(is.na(get(x_variable))==FALSE & get(x_variable)>0) %>%
    # Generate a new column "year"
    mutate(year=year(Date))
  # Drop abnormal record in column "Food Pounds" and "Diapers"
  if(x_variable=="Food Pounds")
    data_selected<-filter(data_selected,`Food Pounds`<=1000)
  if(x_variable=="Diapers")
    data_selected<-filter(data_selected,`Diapers`<=100)
    # Calculating:
    # 1) the number of cloth assistance per year (column "count")
    # 2) Yearly Average of Clothing Items Assistance normalized by the times of cloth assistance per year (column "ave")
  data_selected<-data_selected %>%
    group_by(year) %>%
    summarise(count=n(),ave=mean(get(x_variable)))
  return(data_selected)
}

# Figure 1: Occurence of Assistance per Year (1997-2018)
Trend_plot_count<-function(x_variable){
  # Data Preparation
  data_selected<-Data_preparetion(x_variable)
  # Plot Result
  ggplot(filter(data_selected,year>=1997&year<=2018),aes(x=year,y=count))+
    geom_point()+
    geom_smooth()+
    labs(x="Year",
         y="Occuerence",
         title=paste("Occurence of Assistance in", x_variable, "by Year (1997-2018)"))+
    theme_minimal()
}

# Figure 2: Average amount of assistance in selected item per Year (1997-2018)
Trend_plot_ave<-function(x_variable){
  # Data Preparation
  data_selected<-Data_preparetion(x_variable)
  # Plot Result
  ggplot(filter(data_selected,year>=1997&year<=2018),aes(x=year,y=ave))+
    geom_point()+
    geom_smooth()+
    labs(x="Year",
         y="Average",
         title=paste("Average amount of assistance in", x_variable, "by Year (1997-2018)"))+
    theme_minimal()
}

  

#--- Part 2: Linear Regression of Different Variables (Food Pounds, Clothing Items, Hygiene Kits) on the Column "Food Provided for" ---
Reg_plot<-function(y_variable){
  # Data preparations: Pick up the right columns and drop useless records
  data_reg<-data %>%
    select(matches(y_variable),`Food Provided for`) %>%
    filter(`Food Provided for`>0 & get(y_variable)>0) %>%
    drop_na()
  # Drop abnormal record in column "Food Pounds" and "Diapers"
  if(y_variable=="Food Pounds")
    data_reg<-filter(data_reg,`Food Pounds`<=1000)
  if(y_variable=="Diapers")
    data_reg<-filter(data_reg,Diapers<=100)
  # Call linear fit
  fit<-summary(lm(get(y_variable)~`Food Provided for`,data=data_reg))
  # Plot Results
  ggplot(data_reg,aes(x=`Food Provided for`,y=get(y_variable)))+
    geom_point()+
    geom_abline(slope=fit$coef[2,1],intercept=fit$coef[1,1],col='blue',lwd=1.5)+
    labs(x="Number of people in the Family",
         y=paste(y_variable),
         title=paste("Linear Regression of", y_variable, "on the number of people in the family"))+
    theme_minimal()
}

Reg_Table<-function(y_variable){
  # Data preparations: Pick up the right columns and drop useless records
  data_reg<-data %>%
    select(matches(y_variable),`Food Provided for`) %>%
    filter(`Food Provided for`>0 & get(y_variable)>0) %>%
    drop_na()
  # Drop abnormal record in column "Food Pounds" and "Diapers"
  if(y_variable=="Food Pounds")
    data_reg<-filter(data_reg,`Food Pounds`<=1000)
  if(y_variable=="Diapers")
    data_reg<-filter(data_reg,Diapers<=100)
  # Call linear fit
  fit<-summary(lm(get(y_variable)~`Food Provided for`,data=data_reg))
  if(fit$coefficients[1,4]<5*10^-8)
    fit$coefficients[1,4]<-"<5*10^-8"
  if(fit$coefficients[2,4]<5*10^-8)
    fit$coefficients[2,4]<-"<5*10^-8"
  cbind(Item=c("Intercept","Slope"),fit$coefficients)
}



#--- Part 3: Cluster Analysis of Selected Variables (chosen among "Food Pounds", "Clothing Items" and "Diapers") ---
Cluster_plot<-function(x_variable,y_variable,num){
  # Data Preparations:  Pick up the right columns and drop useless records
  data_clus<-data %>%
    select(matches(x_variable),matches(y_variable)) %>%
    filter(get(x_variable)>0 & get(y_variable)>0) %>%
    drop_na()
  # Drop abnormal record in column "Food Pounds" and "Diapers"
  if(x_variable=="Food Pounds"|y_variable=="Food Pounds")
    data_clus<-filter(data_clus,`Food Pounds`<=1000)
  if(x_variable=="Diapers"|y_variable=="Diapers")
    data_clus<-filter(data_clus,`Diapers`<=100)
  # Perform K-means Clustering
  fit<-kmeans(data_clus,num)
  # Append cluster assignment
  data_clus$cluster = as.factor(fit$cluster)
  # Plot results
  ggplot(data_clus, aes(get(x_variable), get(y_variable), group=cluster)) +
    geom_point(size=2, alpha=0.75, aes(color=cluster))+
    labs(x=paste(x_variable),
         y=paste(y_variable),
         title=paste("Cluster analysis of", x_variable, "and", y_variable))+
    theme_minimal()
}
