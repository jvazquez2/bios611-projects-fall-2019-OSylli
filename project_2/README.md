**Bios 611 Project 2** (Yilun Li)
===

## Background Information and Data Source

Urban Ministries of Durham (UMD) is an organization that connects with the community to end homelessness and fight poverty. Here, we've got a dataset from the organization which has recorded the assistance to those in need, including food support, clothing items assistance, financial support and so on. We will perform some analysis on the dataset so that we could have a better view of the data and provide the stuffs of UMD with more useful information.

## Project Aim and Project Audience

This project is intended for the stuffs in UMD. 

Specifically, as is mentioned in the part "Future Analysis Plan" for my project 1, first we'll explore the trend of different kinds of assistance (including *Food Pounds*, *Clothing Items*, *Diapers*, *School Kits*, *Hygiene Kits*, *Financial Support*), and see how the number of assistance change over the years, hoping to help the stuffs in making better preparations.

Next, we're going to perform a regression analysis of different variables (including *Food Pounds*, *Clothing Items*, *Hygiene Kits*) on the column "Food Provided for", hoping to figure out the relationship between the two selected variables. In this way, we can make an assessment of the proper food assistance we need to provide based on the amount of people in the case. 

In addition, in order to make a preliminary inference of the customers' need for one item based on another so that proper and timely help could be provided, we will perform a cluster analysis pairwisely among *Food Pounds*, *Clothing Items* and *Financial Support*. These variables are chosen based on their sample size. 

A shiny APP would be produced for viewers to see all these results.

## Methods of Data Analysis

Generally speaking, in the project, techniques for linear regression and cluster analysis with *R Studio* will be primarily used. And of course, basic wrangling and visualization of data are needed, and functions from package "tidyverse" and "ggplot2" would be frequently applied. Results will be presented with the assistance of figures. You can view all the results with the shiny APP through the link provided based on your need and requirements.

## Link to the Shiny APP

You can click into the following link to view the project results: https://osylli.shinyapps.io/project_2/