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

temp <- unique(data1[,c(2,5:7)])
temp <- temp[order(temp[,c(1:2)]),]
min(which(temp[1:896,1] != unique(temp[,1])))

data1[
        data1[,2] == temp[min(which(temp[1:896,1] != unique(temp[,1]))), 1],
        4
] <- max(temp[min(which(temp[1:896,1] != unique(temp[,1]))), 3])

length(unique(temp[,1]))
length(temp[,1])

for(j in 1:900){
        temp <- unique(data[,c(1:2,5:7)])
        temp$new_id <- sapply(
                1:nrow(temp),
                function(i) paste(
                        temp[i,1], 
                        temp[i,2], 
                        temp[i,3], 
                        sep = "_")
                )
        temp <- temp[order(temp[,1], temp[,2], temp[,3]),]
        i <- min(which(temp[1:5049,6] != unique(temp[,6])))
        data[data[,1] == temp[i,1] & 
             data[,2] == temp[i,2] & 
             data[,5] == temp[i,3], 6] <- min(data[
                data[,1] == temp[i,1] & 
                data[,2] == temp[i,2] & 
                data[,5] == temp[i,3], 
                6])
        
        data[data[,1] == temp[i,1] & 
             data[,2] == temp[i,2] & 
             data[,5] == temp[i,3], 
             7] <- max(data[
                data[,1] == temp[i,1] & 
                data[,2] == temp[i,2] & 
                data[,5] == temp[i,3], 
                7])
        
        print(j)
}

dim(unique(data))
length(unique(temp[,6]))



