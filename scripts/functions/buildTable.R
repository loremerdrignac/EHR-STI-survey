buildTable <- function(df,
                       codebook,
                       header_main,
                       pattern,
                       key_var) {
  
  if(!is.null(pattern)) {
    key_var <- codebook %>% 
      dplyr::filter(str_detect(Variable, pattern)) %>% 
      dplyr::pull(Variable)
  } else {
    key_var
  }

  
  # Selecting key variables
  tab <- df %>% 
    dplyr::select(idcountry, all_of(key_var))
  
  header <- codebook %>% 
    dplyr::filter(Variable %in% colnames(tab)) %>%
    dplyr::rename(subLabel = Label,
                  col_keys = Variable) %>% 
    dplyr::select(key, col_keys, subLabel) %>% 
    dplyr::left_join(header_main %>% dplyr::select(-col_keys),
                     by = join_by(key)) %>% 
    dplyr::bind_rows(tibble(col_keys = "idcountry", Label = "Site", subLabel = "Site"))

  tab_flex <- flextable::flextable(tab) %>% 
    flextable::set_header_df(mapping = header[-1], key = "col_keys")  %>% 
    flexECDCStyle()
  
  return(tab_flex)
}
