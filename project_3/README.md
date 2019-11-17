**Bios 611 Project 3** (Yilun Li)
===

## Background Information and Data Source

[Urban Ministries of Durham](http://www.umdurham.org/) (UMD) is an organization that connects with the community to end homelessness and fight poverty. Here, we've got a couple of datasets from the organization which has recorded the assistance to those in need. We will perform some basic analysis on the datasets so that we could have a better view of the data and provide the stuffs of UMD with more useful information.

Here are a list of the datasets that would be primarily used in the project, all of them can be found in the folder */project_3/data*:   
  * **CLIENT_191102.tsv**: Personal information of the clients, such as ID, age, gender, race, veteran status.   
  * **EE_UDES_191102.tsv**: Basic information of the client, such as living situation, housing status and disabling condition, etc.
  * **ENTRY_EXIT_191102.tsv**: Record of clients' entry to UMD and exit from UMD, such as the relevant dates, destination and reason for exits, etc.   
  
## Project Aim and Project Audience

This project is intended for the staffs in UMD and its cooperators. We hope to provide them with more profound conclusions and facts behind the data, and offer more useful suggestions to them based on the results, so that they could make better preparations and dicisions in daily management.

Specifically, we're going to work on the following problems:   
1) The trend of the number of entry to UMD over years and the possible seasonal characteristics of the number of entry.   
2) The relationship between duration of stay at UMD and clients' gender and race   
3) The relationship between duration of stay at UMD and clients' age, live condition and Housing status at the time of entry.

While Part2 and Part3 look similar, the former one will be completed with *Python* and the latter part with *R*.

## Methods for Data Analysis and Results Presentation

In this project, we will use both package "tidyverse" from *R Studio* and "pandas" from *Python* to do data wrangling and visualization. Results will be presented with the assistance of figures like histograms. Also, we will apply *Make* in this project as a workflow manager, and *Dockerfile* to define execution environments. All the scripts would be saved to the folder */project_3/scripts*. An HTML will be generated as a final project.