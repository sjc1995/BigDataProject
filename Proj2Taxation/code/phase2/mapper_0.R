#! /gpfs/software/R-3.6.0/lib64/R/bin/Rscript --vanilla
library(jsonlite)

weight <- read.csv('/gpfs/scratch/sjiecheng/project2/current_weight.csv')[1:1e+06,]
url_list <- fromJSON('/gpfs/scratch/sjiecheng/project2/url_list_0.json')

v <- list()
for(i in 1:1e7){
  v[[i]] <- 0
}

value <- function(i){
  x <- url_list[[i]]
  w <- weight[i,2]
  if(is.null(x)){
    return(0)
  }else{
    n <- length(x)
    for(y in x){
      v[y] <<- v[[y]] + w/n
    }
  }
}

lapply(1:1e6, value)

write(toJSON(v), '/gpfs/scratch/sjiecheng/project2/mapper_0.json')
