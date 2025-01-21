#' Apply ECDC Styling to a Flextable
#'
#' This function customizes a flextable object to conform to the ECDC 
#' (European Centre for Disease Prevention and Control) styling guidelines. 
#' It applies bold and colored styling to the header, adds borders, 
#' and optionally merges cells horizontally and vertically.
#'
#' @param table_ft A flextable object that needs to be styled.
#' @param merge_v A logical value indicating whether to merge cells vertically in the header. Defaults to TRUE.
#' @param merge_h A logical value indicating whether to merge cells horizontally in the header. Defaults to TRUE.
#' 
#' @return A flextable object with ECDC styling applied.
#'
#' @examples
#' # Assuming `data_frame` is a pre-existing dataframe
#' table_ft <- flextable::qflextable(data_frame)
#' styled_table <- flexECDCStyle(table_ft, merge_v = TRUE, merge_h = TRUE)
#' 
#' # Display the styled table
#' print(styled_table)
#' 
flexECDCStyle <- function(table_ft, 
                          merge_v = TRUE,
                          merge_h = TRUE) {
  
  # Adapting the flextable for ECDC style tables
  table_ft <- table_ft %>%
    # Bold header
    flextable::bold(part = "header") %>%
    # Color header
    flextable::bg(part = "header",
                  bg = "#65B32E") %>%
    flextable::color(color = "white",
                     part = "header") %>% 
    # Border
    flextable::border_remove() %>% 
    flextable::hline(border = officer::fp_border(color = "#C7C7C7"))
  
  # Merging horizontally
  if(merge_h == TRUE) {
    table_ft <- table_ft %>% 
      flextable::merge_h(part = "header")
  }
  
  # Merging vertically
  if(merge_v == TRUE) {
    table_ft <- table_ft %>% 
      flextable::merge_v(part = "header") 
  }
  
  # Column Size
  if (ncol(table_ft$body$dataset) > 2) {
  table_ft <- table_ft %>%
    flextable::width(j = 1, width = 0.5) %>% 
    flextable::width(j = 2:ncol(table_ft$body$dataset), width = 1.3)
  } else if (ncol(table_ft$body$dataset) == 2){
    table_ft <- table_ft %>%
      flextable::width(j = 1, width = 0.5) %>% 
      flextable::width(j = 2, width = 9)
  } else {
    table_ft <- table_ft %>%
      flextable::width(j = 1, width = 10) 
  }
  
  
  return(table_ft)
  
}