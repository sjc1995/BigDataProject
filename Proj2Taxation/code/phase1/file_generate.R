#! /gpfs/software/R-3.6.0/lib64/R/bin/Rscript --vanilla

scripts <- paste0("#! /gpfs/software/R-3.6.0/lib64/R/bin/Rscript --vanilla

library(jsonlite)
data <- read.csv('/gpfs/scratch/sjiecheng/project2/project2_data_part_0",0:9,"', header = F)

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

write(toJSON(res, null = 'null'), '/gpfs/scratch/sjiecheng/project2/phase1_",0:9,".json')")

slurm_scripts <- paste0("#!/bin/bash
#
#SBATCH --job-name=project_test
#SBATCH --ntasks-per-node=40
#SBATCH --nodes=2
#SBATCH --time=60:00
#SBATCH -p short-40core

module load R/3.6.2
/gpfs/home/sjiecheng/project2/phase1/phase1_", 0:9, ".R")

for(j in 0:9){
  write(scripts[j+1], paste0('phase1_',j,'.R'))
  write(slurm_scripts[j+1], paste0('phase1_',j,'.slurm'))
}

