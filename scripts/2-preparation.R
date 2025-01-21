# Project Name : EHR-STI survey
# Script Name  : 2-preparation.R
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


# START of 2-preparation.R  -----------------------------------------------

## Adding idcountry -------------------------------------------------------

# Importing correspondance table
idusername <- readr::read_delim(file.path(getPath("DATA"), "idcountry_username.csv"), show_col_types = FALSE)

# Merging
df <- idusername %>% 
  dplyr::left_join(df, by = join_by(username))

# Fixing encoding WEPI issue
df <- df %>%
  mutate(across(where(is.character), ~ str_replace_all(., "&lt;", "<"))) %>%
  mutate(across(where(is.character), ~ str_replace_all(., "&gt;", ">")))


# Codebook ----------------------------------------------------------------

codebook <- readr::read_delim(file.path(getPath("DATA"), "codebook.csv"), show_col_types = FALSE)

# Adding key prefix column
codebook <- codebook %>% 
  dplyr::mutate(key = substr(Variable, 1, 2))


# END of 2-preparation.R --------------------------------------------------


