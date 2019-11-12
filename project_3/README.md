**Bios 611 Project 3** (Yilun Li)
===

## Background Information and Data Source

Urban Ministries of Durham (UMD) is an organization that connects with the community to end homelessness and fight poverty. Here, we've got a couple of datasets from the organization which has recorded the assistance to those in need. We will perform some basic analysis on the datasets so that we could have a better view of the data and provide the stuffs of UMD with more useful information.

Here are a list of the datasets that would be primarily used in the project, all of them can be found in the folder */project_3/data*:   
  * **CLIENT_191102.tsv**: Personal information of the clients, such as ID, age, gender, race, veteran status.   
  * **DISABILITY_ENTRY_191102.tsv**: Record of disability information of the clients at the time of entry.   
  * **ENTRY_EXIT_191102.tsv**: Record of clients' entry to UMD and exit from UMD, such as the relevant dates, destination and reason for exits, etc.   
  * **HEALTH_INS_ENTRY_191102.tsv**:  Record of health insurance information of the clients at the time of entry.   
  * **INCOME_ENTRY_191102.tsv**: Record of income information of the clients at the time of entry.   
  * **NONCASH_ENTRY_191102.tsv**: Record of non-cash benefit information of the clients at the time of entry.   

## Project Aim and Project Audience

This project is intended for the staffs in UMD and its cooperators. We hope to provide them with more profound conclusions and facts behind the data, and offer more useful suggestions to them based on the results, so that they could make better preparations and dicisions in daily management.

Specifically, we're going to work on the following problems:   
1) The trend of the number of entry to UMD over years and the possible seasonal characteristics of the number of entry.   
2) The relationship between the duration of stay and the income, disability type, health insurance information and non-cash benefits at the time of entry.   
3) The relationship between number of visits of clients and the income, disability type, health insurance information and non-cash benefits at the time of first entry.   

## Methods for Data Analysis and Results Presentation

In this project, we will use both package "tidyverse" from *R Studio* and "pandas" from *Python* to do data wrangling and visualization. Results will be presented with the assistance of figures. Also, we will apply *Make* in this project as a workflow manager, and *Dockerfile* to define execution environments. All the scripts would be saved to the folder */project_3/scripts*. An HTML will be generated as a final project.