# Project Name : EHR-STI survey
# Script Name  : 1-import.R
# GitHub repo  : 
# Summary      : Survey results
# Date created : 2024-05-17
# Author       : Lore Merdrignac
# Date reviewed:
# Reviewed by  :

# Description -------------------------------------------------------------

# Analysis of survey results
#   
#   


# START of 1-import.R  ---------------------------------------------------


# Importing source data
# source_df <- read.csv(file.path(getPath("DRIVE_DATA"), "EHR-STI_SU.csv"))
source_df <- readr::read_csv(file.path(getPath("DRIVE_DATA"), "EHR-STI_SU.csv"))


# Creating working dataset
df <- source_df


# END of 1-import.R ---------------------------------------------------------


