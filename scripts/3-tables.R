# Project Name : EHR-STI survey
# Script Name  : 3-table1.R
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


# START of 3-table1.R  ----------------------------------------------------


## Status ------------------------------------------------------------------

tab <- df %>% 
  dplyr::select(idcountry, status, date_creation, date_modif)

tab_status <- flextable::flextable(tab) %>%  
  flextable::set_header_labels(idcountry = "Site",
                               status = "Survey status",
                               date_creation = "Creation date",
                               date_modif = "Last modification date") %>% 
  flexECDCStyle() %>% 
  flextable::autofit()


## Existing EHR/EMR systems -----------------------------------------------

# Selecting key variables
tab <- df %>% 
  dplyr::select(idcountry, specialistservices, hospital, phpc, private, onlineservices, lab, other)

header_main <- codebook %>% 
  dplyr::filter(Variable %in% colnames(tab)) %>%
  dplyr::rename(col_keys = Variable) %>% 
  dplyr::select(key, col_keys, Label) %>% 
  dplyr::mutate(Label = str_replace(Label, "(\\(|,|\\band\\b).*", "")) %>%  # Remove everything after '(', ',', or 'and'
  dplyr::mutate(Label = str_sub(Label, 5)) %>%  # Remove the first 4 characters
  dplyr::mutate(Label = str_trim(Label)) %>%  # Remove any trailing space
  dplyr::bind_rows(tibble(col_keys = "idcountry", Label = "Site"))

tab_main <- flextable::flextable(tab) %>%  
  flextable::set_header_df(mapping = header_main[, -1], key = "col_keys") %>% 
  flexECDCStyle()


tab <- df %>% 
  dplyr::select(idcountry, hospitalspecify, labspecify, otherpecify) %>% 
  dplyr::rename(Site = idcountry,
                "Hospital services contributing" = hospitalspecify,
                "Type of laboratories" = labspecify,
                "Other specify" = otherpecify)

tab_mainspespe <- flextable::flextable(tab) %>% 
  flexECDCStyle()  %>% 
  flextable::width(j = 2:4, width = c(4, 4, 1.5))


## Using these systems for the project -------------------------------------

tab_use <- buildTable(df,
                      codebook, 
                      header_main,
                      pattern = "use")



## 1. Extraction frequency ----------------------------------------------------

tab_freq <- buildTable(df,
                       codebook,
                       header_main, 
                       pattern = "freq")



## 2. Coverage ----------------------------------------------------------------

codebook %>% 
  dplyr::filter(str_detect(Variable, "coverage$"))
tab_cov <- buildTable(df,
                      codebook, 
                      pattern = "coverage$",
                      header_main)

codebook %>% 
  dplyr::filter(str_detect(Variable, "coveragemore$"))
tab_covm <- buildTable(df,
                       codebook, 
                       pattern = "coveragemore$",
                       header_main)

tab_covmi <- buildTable(df,
                        codebook, 
                        pattern = "coveragemoreinter",
                        header_main)


## 3. Proportion --------------------------------------------------------------

codebook %>% 
  dplyr::filter(str_detect(Variable, "portion$"))
tab_prop <- buildTable(df,
                       codebook, 
                       pattern = "portion$",
                       header_main)



## 4. Variables ---------------------------------------------------------------

codebook %>% 
  dplyr::filter(str_detect(Variable, "agesex$"))
tab_agesex <- buildTable(df,
                         codebook, 
                         pattern = "agesex$",
                         header_main)

codebook %>% 
  dplyr::filter(str_detect(Variable, "agesexcomp$"))
tab_agesexcomp <- buildTable(df,
                             codebook, 
                             pattern = "agesexcomp$",
                             header_main)

codebook %>% 
  dplyr::filter(str_detect(Variable, "symptoms$"))
tab_symptoms <- buildTable(df,
                           codebook, 
                           pattern = "symptoms$",
                           header_main)

codebook %>% 
  dplyr::filter(str_detect(Variable, "symptomscomp$"))
tab_symptomscomp <- buildTable(df,
                               codebook, 
                               pattern = "symptomscomp$",
                               header_main)

codebook %>% 
  dplyr::filter(str_detect(Variable, "siteinfection$"))
tab_siteinfection <- buildTable(df,
                                codebook, 
                                pattern = "siteinfection$",
                                header_main)

codebook %>% 
  dplyr::filter(str_detect(Variable, "siteinfectioncomp$"))
tab_siteinfectioncomp <- buildTable(df,
                                    codebook, 
                                    pattern = "siteinfectioncomp$",
                                    header_main)

codebook %>% 
  dplyr::filter(str_detect(Variable, "labconf$"))
tab_labconf <- buildTable(df,
                          codebook, 
                          pattern = "labconf$",
                          header_main)

codebook %>% 
  dplyr::filter(str_detect(Variable, "abconfcomp$"))
tab_labconfcomp <- buildTable(df,
                              codebook, 
                              pattern = "abconfcomp$",
                              header_main)

codebook %>% 
  dplyr::filter(str_detect(Variable, "amr$"))
tab_amr <- buildTable(df,
                      codebook, 
                      pattern = "amr$",
                      header_main)

codebook %>% 
  dplyr::filter(str_detect(Variable, "amrcomp$"))
tab_amrcomp <- buildTable(df,
                          codebook, 
                          pattern = "amrcomp$",
                          header_main)

codebook %>% 
  dplyr::filter(str_detect(Variable, "transmission$"))
tab_transmission <- buildTable(df,
                               codebook, 
                               pattern = "transmission$",
                               header_main)

codebook %>% 
  dplyr::filter(str_detect(Variable, "transmissioncomp$"))
tab_transmissioncomp <- buildTable(df,
                                   codebook, 
                                   pattern = "transmissioncomp$",
                                   header_main)

codebook %>% 
  dplyr::filter(str_detect(Variable, "hiv$"))
tab_hiv <- buildTable(df,
                      codebook, 
                      pattern = "hiv$",
                      header_main)

codebook %>% 
  dplyr::filter(str_detect(Variable, "hivcomp$"))
tab_hivcomp <- buildTable(df,
                          codebook, 
                          pattern = "hivcomp$",
                          header_main)

codebook %>% 
  dplyr::filter(str_detect(Variable, "pregnancy$"))
tab_pregnancy <- buildTable(df,
                            codebook, 
                            pattern = "pregnancy$",
                            header_main)

codebook %>% 
  dplyr::filter(str_detect(Variable, "pregnancycomp$"))
tab_pregnancycomp <- buildTable(df,
                                codebook, 
                                pattern = "pregnancycomp$",
                                header_main)



## 5. Link clinical-lab -------------------------------------------------------

codebook %>% 
  dplyr::filter(str_detect(Variable, "clinlab$"))
tab_clinlab <- buildTable(df,
                          codebook, 
                          pattern = "clinlab$",
                          header_main)



## 6. Obstacles assessing -----------------------------------------------------

codebook %>% 
  dplyr::filter(str_detect(Variable, "assessing$"))
# tab_assess <- buildTable(df,
#                          codebook, 
#                          pattern = "assessing$",
#                          header_main)

# Build one table per data source
tab_speobstacleassessing <- buildTable(df,
                                       codebook, 
                                       pattern = "^speobstacleassessing$",
                                       header_main) %>% 
  flextable::width(j = 2, width = 9)

tab_hosobstacleassessing <- buildTable(df,
                                       codebook, 
                                       pattern = "^hosobstacleassessing$",
                                       header_main) %>% 
  flextable::width(j = 2, width = 9)

tab_phobstacleassessing <- buildTable(df,
                                      codebook, 
                                      pattern = "^phobstacleassessing$",
                                      header_main) %>% 
  flextable::width(j = 2, width = 9)

tab_privobstacleassessing <- buildTable(df,
                                        codebook, 
                                        pattern = "^privobstacleassessing$",
                                        header_main) %>% 
  flextable::width(j = 2, width = 9)

tab_onlobstacleassessing <- buildTable(df,
                                       codebook, 
                                       pattern = "^onlobstacleassessing$",
                                       header_main) %>% 
  flextable::width(j = 2, width = 9)

tab_labobstacleassessing <- buildTable(df,
                                       codebook, 
                                       pattern = "^labobstacleassessing$",
                                       header_main) %>% 
  flextable::width(j = 2, width = 9)

tab_othobstacleassessing <- buildTable(df,
                                       codebook, 
                                       pattern = "^othobstacleassessing$",
                                       header_main) %>% 
  flextable::width(j = 2, width = 9)




## 7.Obstacles reporting -----------------------------------------------------

codebook %>% 
  dplyr::filter(str_detect(Variable, "reporting$"))
# tab_report <- buildTable(df,
#                          codebook, 
#                          pattern = "reporting$",
#                          header_main)

# Build one table per data source
tab_speobstaclereporting <- buildTable(df,
                                       codebook, 
                                       pattern = "^speobstaclereporting$",
                                       header_main) %>% 
  flextable::width(j = 2, width = 9)

tab_hosobstaclereporting <- buildTable(df,
                                       codebook, 
                                       pattern = "^hosobstaclereporting$",
                                       header_main) %>% 
  flextable::width(j = 2, width = 9)

tab_phobstaclereporting <- buildTable(df,
                                      codebook, 
                                      pattern = "^phobstaclereporting$",
                                      header_main) %>% 
  flextable::width(j = 2, width = 9)

tab_privobstaclereporting <- buildTable(df,
                                        codebook, 
                                        pattern = "^privobstaclereporting$",
                                        header_main) %>% 
  flextable::width(j = 2, width = 9)

tab_onlobstaclereporting <- buildTable(df,
                                       codebook, 
                                       pattern = "^onlobstaclereporting$",
                                       header_main) %>% 
  flextable::width(j = 2, width = 9)

tab_labobstaclereporting <- buildTable(df,
                                       codebook, 
                                       pattern = "^labobstaclereporting$",
                                       header_main) %>% 
  flextable::width(j = 2, width = 9)

tab_othobstaclereporting <- buildTable(df,
                                       codebook, 
                                       pattern = "^othobstaclereporting$",
                                       header_main) %>% 
  flextable::width(j = 2, width = 9)



## Data source comment -----------------------------------------------------

codebook %>% 
  dplyr::filter(str_detect(Variable, ".+comment$"))
# tab_comment <- buildTable(df,
#                          codebook, 
#                          pattern = ".+comment$",
#                          header_main)

# Build one table per data source
tab_specomment <- buildTable(df,
                             codebook, 
                             pattern = "^specomment$",
                             header_main) %>% 
  flextable::width(j = 2, width = 9)

tab_hoscomment <- buildTable(df,
                             codebook, 
                             pattern = "^hoscomment$",
                             header_main) %>% 
  flextable::width(j = 2, width = 9)

tab_phcomment <- buildTable(df,
                            codebook, 
                            pattern = "^phcomment$",
                            header_main) %>% 
  flextable::width(j = 2, width = 9)

tab_privcomment <- buildTable(df,
                              codebook, 
                              pattern = "^privcomment$",
                              header_main) %>% 
  flextable::width(j = 2, width = 9)

tab_onlcomment <- buildTable(df,
                             codebook, 
                             pattern = "^onlcomment$",
                             header_main) %>% 
  flextable::width(j = 2, width = 9)

tab_labcomment <- buildTable(df,
                             codebook, 
                             pattern = "^labcomment$",
                             header_main) %>% 
  flextable::width(j = 2, width = 9)

tab_othcomment <- buildTable(df,
                             codebook, 
                             pattern = "^othcomment$",
                             header_main) %>% 
  flextable::width(j = 2, width = 9)



## Final comment -----------------------------------------------------------

codebook %>% 
  dplyr::filter(str_detect(Variable, "^comment$"))

tab <- df %>% 
  dplyr::select(c("idcountry", "comment")) %>% 
  dplyr::rename(Site = idcountry,
                Comment = comment)

tab_final <- flextable::flextable(tab) %>% 
  flexECDCStyle()  %>% 
  flextable::width(j = 2, width = 9)


# Clean -------------------------------------------------------------------

rm(tab)

# END of 3-table1.R --------------------------------------------------


