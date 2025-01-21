# Project Name : EHR-STI survey
# Script Name  : main.R
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


# START of main.R  --------------------------------------------------------

# Cleaning environment
rm(list = ls())


# Include config.R file ---------------------------------------------------

if (! file.exists("config.R")) {
  stop("main.R script should be run from root directory")
}

source("config.R")


# 1-Importing data --------------------------------------------------------

sourceFile("SCRIPTS", "1-import.R")



# 2-Preparing data --------------------------------------------------------

sourceFile("SCRIPTS", "2-preparation.R")



# 3- Tables ---------------------------------------------------------------

sourceFile("SCRIPTS", "3-tables.R")



# 4-Report ----------------------------------------------------------------

rmarkdown::render(input = pathToFile("SCRIPTS", "survey_report.Rmd"),
                  output_dir = getPath("OUTPUTS"))


# 5- Country-tables ---------------------------------------------------------------

df_full <- df

for (C in df$idcountry) {
  df <- df_full %>% dplyr::filter(idcountry == C)
  sourceFile("SCRIPTS", "3-tables.R")
  
  rmarkdown::render(input = pathToFile("SCRIPTS", "survey_report_country.Rmd"),
                    output_dir = getPath("OUTPUTS"),
                    output_file = paste0(C, "_survey_report.docx"))
}



# END of main.R -----------------------------------------------------------


