#! /gpfs/software/R-3.6.0/lib64/R/bin/Rscript --vanilla

library(jsonlite)
data <- read.csv('/gpfs/scratch/sjiecheng/project2/project2_data_part_00', header = F)

n <- nrow(data)
print(n)
# generate a empty list
res <- list()
res[[10000001]] <- 0
res[[10000001]] <- NULL

for(i in 1:n){
  res[[data[i,1]]] <- c(res[[data[i,1]]], data[i,2])
  if(i %% 1000000 == 0) print(i)
}

write(toJSON(res, null = 'null'), '/gpfs/scratch/sjiecheng/project2/phase1_0.json')
