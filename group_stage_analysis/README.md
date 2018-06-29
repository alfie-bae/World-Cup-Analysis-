This R project is the data processing unit within a larger world cup
group stage analysis. 

The source code, source data, presentation and images 
can be found at https://github.com/alfie-bae/World-Cup-Analysis-

This project is publically readable. You will need to 
submit a push request to commit to the source code. 

This project uses the ProjectTemplate format of running 
the config scripts first, then data and finally the munge scripts.

Each script is run in the order of their name.
munge/001_groupstage_processing.R is run before 
munge/002_placement_processing.R. 

Project workflow - 

1. load data from flat file (data/001_load_data.R)
2. process group stage totals for each team (munge/001_groupstage_processing.R)
3. write markdown documentation for step 2 (munge/001_groupstage_processing.R )
4. process team cup placements for each cup (munge/002_placement_processing.R)
5. write markdown documentation for step 4 (munge/002_placement_processing.R)
6. save data to flat files for Tableau to pick up (munge/003_save_data.R)



