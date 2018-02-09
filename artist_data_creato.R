ls()
library(googlesheets)
gs_ls()
sheets <- "Artist Data for Segmentation"
sheets
sheets_list <- list()
sheets_list <- lapply(
sheets, 
        function(i) gs_ws_ls(gs_title(i))
        )
