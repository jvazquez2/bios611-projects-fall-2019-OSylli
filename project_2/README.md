**Bios 611 Project 2** (Yilun Li)
===

## Background Information and Data Source

Urban Ministries of Durham (UMD) is an organization that connects with the community to end homelessness and fight poverty. Here, we've got a dataset from the organization which has recorded the assistance to those in need, including food support, clothing items assistance, financial support and so on. We will perform some analysis on the dataset so that we could have a better view of the data and provide the stuffs of UMD with more useful inforamtion.

## Project Aim and Project Audience

This project is intended for the stuffs in UMD. Specifically, first we're going to perform a regression analysis of "Food Pounds" on the column "Food Provided for", hoping to figure out the relationship between the two variables. In this way, we can make an assessment of the proper food assistance we need to provide based on the amount of people in the case. Also, we are going to perform a cluster analysis based on the variables "Food Pounds" and "Clothing Items", so that wo could make a preliminary inference of the customers' need for one item based on another, which may help to provide timely and proper help. Finally, a shiny APP would be produce to help see the distribution of peoples' need for assistance in food and clothings in order to build a clearer view of people's need.

## Methods of Data Analysis

Generally speaking, in the project, techniques for linear regression and cluster analysis with *R Studio* will be primarily used. And of course, basic wrangling and visualization of data are needed, and functions from package "tidyverse" and "ggplot2" would be frequently applied. Results will be presented with the assistance of figures, such as cluster plot and histogram, in addition to necessary code.

Also, users can view part of the results with the shiny APP based on their need and requirements.