ls()
library(googlesheets)
gs_ls()
sheets <- "Artist Data for Segmentation"

sheets_list <- list()
sheets_list <- lapply(
        sheets,
        function(i) gs_ws_ls(gs_title(i))
        )

data_list <- list()
count <- 1
for(i in 1:length(sheets)){
        for(j in 1:length(sheets_list[[i]])){
                data_list[[count]] <- as.data.frame(
                        gs_read(
                                gs_title(sheets[i]),
                                ws = j
                        )
                )
                names(data_list)[count] <- paste0(sheets[[i]], "_", j)
                count <- count + 1
        }
}

data <- rbind(
        data_list[[1]],
        data_list[[4]]
)

data <- unique(data)

data1 <- data[,c(2,4,5,7:11,13:14)]

data1[,1] <- gsub(data1[,1], pattern = "http://www.", replacement = "https://www.")
data1[,2] <- gsub(data1[,2], pattern = "http://www.", replacement = "https://www.")
data1[,9] <- gsub(data1[,9], pattern = "http://www.", replacement = "https://www.")
data1[,10] <- gsub(data1[,10], pattern = "http://www.", replacement = "https://www.")

data1[,1] <- paste0(data1[,1], "/")
data1[,2] <- paste0(data1[,2], "/")
data1[,9] <- paste0(data1[,9], "/")
data1[,10] <- paste0(data1[,10], "/")


