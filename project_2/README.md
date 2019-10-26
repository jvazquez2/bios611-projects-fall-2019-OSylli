**Bios 611 Project 2** (Yilun Li)
===

## Background Information and Data Source

Urban Ministries of Durham (UMD) is an organization that connects with the community to end homelessness and fight poverty. Here, we've got a dataset from the organization which has recorded the assistance to those in need. We will perform some analysis on the dataset so that we could have a better view of the data and provide the stuffs of UMD with more useful information.

The dataset contains a collection of data with 79838 observations from 1990¡¯s to 2019. Variables listed below are primarily recorded for each case:    
  * **Date**: Date when the case occurred  
  * **Client File Number**: Identity of the clients  
  * **Bus Tickets (Number of)**: Number of bus tickets that each individual or family received  
  * **Food Provided for**:  Number of people in the family for which food was provided   
  * **Food Pounds**: Number of pounds of food that each individual or family received when shopping at UMD food pantry  
  * **Clothing Items**: Number of clothing items received per family or individual  
  * **Diapers**: Number of packs of diapers received (on aver age they are receiving packs of an average of 22 diapers, and 2 packs per child.)  
  * **School Kits**: Number of school kits received in the case  
  * **Hygiene Kits**: Number of hygiene kits received per individual or family.   
  * **Financial Support**: Money provided.  

## Project Aim and Project Audience

This project is intended for the stuffs in UMD. 

Specifically, as is mentioned in the part "Future Analysis Plan" for my project 1, first we'll explore the trend of different kinds of assistance (including *Food Pounds*, *Clothing Items*, *Diapers*, *School Kits*, *Hygiene Kits*, *Financial Support*), and see how the number of assistance change over the years, hoping to help the stuffs in making better preparations.

Next, we're going to perform a regression analysis of different variables (including *Food Pounds*, *Clothing Items*, *Hygiene Kits*) on the number of people in the family, which can be obtained from the column *Food Provided for*, hoping to figure out the relationship between the two selected variables. In this way, we can make an assessment of the proper assistance we need to provide based on the amount of people in the case. 

In addition, in order to make a preliminary inference of the customers' need for one item based on another so that proper and timely help could be provided, we will perform a cluster analysis pairwisely among *Food Pounds*, *Clothing Items* and *Diapers*. These variables are selected based on their sample size. 

A shiny APP would be produced for viewers to see all these results.

## Methods of Data Analysis

Generally speaking, in the project, techniques for linear regression and cluster analysis with *R Studio* will be primarily used. And of course, basic wrangling and visualization of data are needed, and functions from package "tidyverse" and "ggplot2" would be frequently applied. Results will be presented with the assistance of figures. You can view all the results with the shiny APP through the link provided based on your need and requirements.

## Link to the Shiny APP

You can click into the following link to view the project results: https://osylli.shinyapps.io/project_2/