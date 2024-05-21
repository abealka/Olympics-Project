# Olympic Medal Project
## Project Overview
1.	Purpose
2.	Sources
3.	Data Cleaning
4.	Next Steps
## Purpose
With the Paris 2024 Summer Olympics approaching, I wanted to explore data that is available from the past with the intent to offer some possible projections for medal outcomes for 2024. 
## Sources
I’ve used an amazing dataset from [PETRO on Kaggle](https://www.kaggle.com/datasets/piterfm/olympic-games-medals-19862018/data). The data is derived from [The Olympic Website](https://olympics.com). PETRO the original creator of the dataset has performed an analysis with Python, and created a visual with Tableau. As with my Tornado Project, I understand that this kind of visualization is already available. However, the data uploading, cleaning, analysis, and visualization for this project is all my own work.  To emphasize the original datasets can be found [here](https://www.kaggle.com/datasets/piterfm/olympic-games-medals-19862018/data).
## Data Cleaning
### Issues
#### Record Keeping
The main issue with the dataset is cases of missing data. These records start in 1896, it should be noted that record keeping and digitizing errors could have occurred over the past 126 years. 
#### Political and Geographic Changes
The geographic political landscape has changed several times since 1896. This will be noted throughout the data cleaning process, and in some cases for analysis purposes, certain countries will be combined to represent that geographic area as best as possible. For example, countries in Eastern Europe have changed several times, but it will be noted when these countries are combined. 
 #### Team vs. Individual Medals 
The results and medal datasets have an issue where team events have combined athlete data, or it is missing all together. Moving forward, web scraping or back checking could fix this issue, but for the purpose of this project, I will be proceeding without backfilling missing data. 
### Process Queries 
#### Uploading Data
#### Checking For Duplicates
#### Standardizing Data
## Next Steps
I’m currently working on my analysis in MySQL and creating projections through Tableau. This will be updated upon completion. 
