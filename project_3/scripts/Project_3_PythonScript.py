#!/usr/bin/env python
# coding: utf-8

# In[1]:


# Question 2: The relationship between duration of stay at UMD and clients' gender and race
# Data read in
import pandas as pd
client = pd.read_csv('https://raw.githubusercontent.com/datasci611/bios611-projects-fall-2019-OSylli/master/project_3/data/CLIENT_191102.tsv',sep='\t')
client = client.loc[:,['Client ID', 'Client Gender', 'Client Primary Race']]
client.head()


# In[2]:


# Data read in
import pandas as pd
entry_exit = pd.read_csv('https://raw.githubusercontent.com/datasci611/bios611-projects-fall-2019-OSylli/master/project_3/data/ENTRY_EXIT_191102.tsv',sep='\t')
entry_exit = entry_exit.loc[:,['Client ID', 'Entry Date', 'Exit Date']]
entry_exit.head()


# In[3]:


# Load necessary packages
import pandas as pd

# Since the column "Client ID" are matched in the two datasets, we directly combine them together
record=pd.concat([client, entry_exit],axis=1)

# Change the format of date record and calculate the duration of stay at UMD of each item
record['Entry Date'] = pd.to_datetime(record['Entry Date'],format='%m/%d/%Y')
record['Exit Date'] = pd.to_datetime(record['Exit Date'],format='%m/%d/%Y')
record['Duration (Days)'] = record['Exit Date']-record['Entry Date']
record['Duration (Days)'] = record['Duration (Days)'].map(lambda x: x.days)

# Drop imcomplete record
record = record.dropna(axis = 0, how ='any')

# Output
record.head()


# In[4]:


# Question 2 Part 1: Relationship between the duration of stay at UMD and Client Gender
gender_record = {'Gender':[], 'Count':[], 'AVE_duration':[]}

# Data wrangling to calculate the number and average time of stay at UMD for different gender
for value, sub_df in record.groupby('Client Gender'):
    tmp_ave = sub_df['Duration (Days)'].mean()
    gender_record['Gender'].append(value)
    gender_record['Count'].append(sub_df['Duration (Days)'].count())
    gender_record['AVE_duration'].append(tmp_ave)
    
# Change the dictionary in to a dataframe and print it out
gender_record = pd.DataFrame(gender_record)
gender_record


# In[12]:


# Load necessary packages for visualization
import matplotlib.pyplot as plt
from matplotlib.pyplot import savefig

# Generate a barplot to show relationship between the total number of entry and client gender
plt.bar(gender_record['Gender'],gender_record['Count'])
plt.title('Relationship between the total number of entry and client gender')
savefig("Q2_Relationship between the total number of entry and client gender.png", bbox_inches = 'tight')


# In[13]:


# Load necessary packages for visualization
import matplotlib.pyplot as plt
from matplotlib.pyplot import savefig

# Generate a barplot to show the relationship between the average time of stay at UMD and client gender
plt.bar(gender_record['Gender'],gender_record['AVE_duration'])
plt.title('Relationship between the average time of stay at UMD and client gender')
savefig("Q2_Relationship between the average time of stay at UMD and client gender.png", bbox_inches = 'tight')


# In[9]:


# Part 2: Relationship between the duration of stay at UMD and Client Race
race_record = {'Race':[], 'Count':[], 'AVE_duration':[], 'Number':[]}

# Data wrangling
for value, sub_df in record.groupby('Client Primary Race'):
    tmp_ave = sub_df['Duration (Days)'].mean()
    race_record['Race'].append(value)
    race_record['Count'].append(sub_df['Duration (Days)'].count())
    race_record['AVE_duration'].append(tmp_ave)
    
# Drop unnecessary summarized statistics    
race_record["Number"] = [0,1,2,3,4,5,6,7]
race_record = pd.DataFrame(race_record)
race_record = race_record.drop(5,axis=0) # drop the row in which "Data not collected" is recorded
race_record = race_record.drop(4,axis=0) # drop the row in which "Client refused" is recorded
race_record = race_record.drop(3,axis=0) # drop the row in which "Client doesn't know" is recorded

# Output
race_record


# In[10]:


# Load necessary Packages
import matplotlib.pyplot as plt
from matplotlib.pyplot import savefig

# Visualization with a barplot, shwoing the relationship between the total number of entry and client race
LABELS = ["American Indian or Alaska Native","Asian","Black or African American","Native Hawaiian or Other Pacific Islander","White"]

plt.bar(race_record['Number'],race_record['Count'])
plt.title('Relationship between the total number of entry and clients\' race')
plt.xticks(race_record['Number'],LABELS,rotation=90)

savefig("Q2_Relationship between the total number of entry and clients\' race.png", bbox_inches = 'tight')


# In[11]:


# Load necessary packages
import matplotlib.pyplot as plt
from matplotlib.pyplot import savefig

# Visualization with a barplot, showing the relationship between the average time of stay at UMD and client race
LABELS = ["American Indian or Alaska Native","Asian","Black or African American","Native Hawaiian or Other Pacific Islander","White"]


plt.bar(race_record['Number'],race_record['AVE_duration'])
plt.title('Relationship between the average time of stay at UMD and clients\' race')
plt.xticks(race_record['Number'],LABELS,rotation=90)

savefig("Q2_Relationship between the average time of stay at UMD and clients\' race.png", bbox_inches = 'tight')


# In[ ]:




