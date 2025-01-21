#' findDrive
#' 
#' Quick way to find the path to the root Shared Drive (e.g., "G:/Shared drive"). 
#' It will identify the letter associated to the Drive (e.g., D:, G:, etc) 
#' and then the name of the root folder (i.e., "Shared drive" or "Drive partagés").
#' Indeed, depending on the user language, it could be labelled in english or French.
#' Only these tow languages are implemented so far.
#' 
#' @param message boolean to print information messages or not
#' @returns path to the shared drive
#' @export
#' @author STRAP team \email{strap@epiconcept.fr}
#' @examples
#' setPath("DRIVE", findDrive())
#' getPath("DRIVE")
#' 

findDrive <- function(message = FALSE) {
  
  # Get the list of drives
  drives <- system("wmic logicaldisk get caption,description", intern = TRUE)
  
  # Remove the header line
  drives <- drives[-1]
  
  # Split the drive information into columns
  drives_data <- strsplit(drives, "\\s+")
  drives_data <- lapply(drives_data, function(x) x[x != ""])
  drives_data <- do.call(rbind, drives_data)
  
  # Extract the drive letters and names
  drive_letters <- drives_data[, 1]
  drive_names <- drives_data[, 2]
  
  # Initialising the result to return
  result <- NULL

  # Searching among the drives if Shared drive or Drive partagés exist and store it
  for (i in seq_along(drive_letters)) {
    
    # Add 'Shared drives' to the drive letter and list files
    shared_drives_path <- file.path(drive_letters[i], "Shared drives")
    
    if (dir.exists(shared_drives_path)) {
      result <- shared_drives_path
      if (message == TRUE) message(paste("Shared drive found here:", result))
      
    } else {
      
      # Add 'Shared drives' to the drive letter and list files
      shared_drives_path <- file.path(drive_letters[i], "Drive partagés")
      
      if (dir.exists(shared_drives_path)) {
        result <- shared_drives_path
        if (message == TRUE) message(paste("Shared drive found here:", result))
      }
    }
  }
  
  return(result)
  
}

