#
# Project Name : EHR-STI
# Script Name  : config.R
# Summary      : Global and functions definition
# Date created : 2024-05-16
# Author       : Lore Merdrignac
# Date reviewed:
# Reviewed by  :

# Description -------------------------------------------------------------
# Config file to setup global option and PATH 
# Define global variables 
# Define common function by calling epifunction
# Check correct environment
# 

# Change Log --------------------------------------------------------------


# START of config ---------------------------------------------------------


# Library Epiuf -----------------------------------------------------------
library("epiuf")

# Loading the Library -----------------------------------------------------

.nodisplay <- lapply(c("dplyr"      
                       , "readr"     
                       , "EpiReport"          # for ECDC style outputs
                       , "stringr"            # string manipulation
                       , "rmarkdown"
), loadLib) 


# Other global macros used throughout the files ---------------------------

global <- list()



# PATH TO FILES -----------------------------------------------------------
# use file.path(PATH_SOURCES, source_name) to obtain full name of sources file

# Local drive
# default to working directory (usually project directory)
# can be changed if different 
setPath("ROOT" , getwd())

# Others paths derived from root 
setPath("SCRIPTS" , pathToFile("ROOT", "scripts"))
setPath("FUNCTIONS", pathToFile("SCRIPTS", "functions"))
setPath("DATA" , pathToFile("ROOT","data"))
setPath("OUTPUTS", pathToFile("ROOT","outputs"))



# FUNCTIONS ---------------------------------------------------------------

sourceFile("FUNCTIONS", "flexECDCStyle.R")
sourceFile("FUNCTIONS", "buildTable.R")


# MORE PATH TO FILES ------------------------------------------------------

# Network Drive
# default to working directory but can be anywhere
# but for specifics installation use local.config.R instead
sourceFile("FUNCTIONS", "findDrive.R")
setPath("DRIVE", findDrive())
# Path DRIVE defined in the local.config
setPath("DRIVE_DATA" , pathToFile("DRIVE","1_EPI/Epidemio (en cours)/03. Epi Projects/2022 - Epidemio - ECDC EHR e-SURE/EHR specific contract 4 STI y1/5. Technical documents/2.Generic protocol/1.Survey/exports"))


# Ensure that language is North-American for date format and month label in plots ----------------------------
Sys.setlocale("LC_TIME", "C")


if (! file.exists(pathToFile("ROOT","config.R"))) {
  stop("Verify paths in your config.R files or set your working directory to config.R location")
}


# END of config ----------------------------------------------------------




