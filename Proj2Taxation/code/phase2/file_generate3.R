#! /gpfs/software/R-3.6.0/lib64/R/bin/Rscript --vanilla

scripts <- paste0("#! /gpfs/software/R-3.6.0/lib64/R/bin/Rscript --vanilla
library(jsonlite)

weight <- read.csv('/gpfs/scratch/sjiecheng/project2/current_weight.csv')[",((0:9)*1e6+1),":",(1:10)*1e6,",]
url_list <- fromJSON('/gpfs/scratch/sjiecheng/project2/url_list_",0:9,".json')

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

write(toJSON(v), '/gpfs/scratch/sjiecheng/project2/mapper_",0:9,".json')")

slurm_scripts <- paste0("#!/bin/bash
#
#SBATCH --job-name=project_test
#SBATCH --ntasks-per-node=28
#SBATCH --nodes=1
#SBATCH --time=60:00
#SBATCH -p debug-28core

module load R/3.6.2
/gpfs/home/sjiecheng/project2/phase2/mapper_", 0:9, ".R")


for(i in 0:9){
  write(scripts[i+1], paste0('mapper_',i,'.R'))
  write(slurm_scripts[i+1], paste0('mapper_',i,'.slurm'))
}

