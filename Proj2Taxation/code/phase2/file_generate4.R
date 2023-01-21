#! /gpfs/software/R-3.6.0/lib64/R/bin/Rscript --vanilla

scripts <- paste0("#! /gpfs/software/R-3.6.0/lib64/R/bin/Rscript --vanilla

library(jsonlite)

mapper0 <- fromJSON('/gpfs/scratch/sjiecheng/project2/mapper_0.json')[",(0:9)*1000000+1,":",(1:10)*1000000,"]
mapper1 <- fromJSON('/gpfs/scratch/sjiecheng/project2/mapper_1.json')[",(0:9)*1000000+1,":",(1:10)*1000000,"]
mapper2 <- fromJSON('/gpfs/scratch/sjiecheng/project2/mapper_2.json')[",(0:9)*1000000+1,":",(1:10)*1000000,"]
mapper3 <- fromJSON('/gpfs/scratch/sjiecheng/project2/mapper_3.json')[",(0:9)*1000000+1,":",(1:10)*1000000,"]
mapper4 <- fromJSON('/gpfs/scratch/sjiecheng/project2/mapper_4.json')[",(0:9)*1000000+1,":",(1:10)*1000000,"]
mapper5 <- fromJSON('/gpfs/scratch/sjiecheng/project2/mapper_5.json')[",(0:9)*1000000+1,":",(1:10)*1000000,"]
mapper6 <- fromJSON('/gpfs/scratch/sjiecheng/project2/mapper_6.json')[",(0:9)*1000000+1,":",(1:10)*1000000,"]
mapper7 <- fromJSON('/gpfs/scratch/sjiecheng/project2/mapper_7.json')[",(0:9)*1000000+1,":",(1:10)*1000000,"]
mapper8 <- fromJSON('/gpfs/scratch/sjiecheng/project2/mapper_8.json')[",(0:9)*1000000+1,":",(1:10)*1000000,"]
mapper9 <- fromJSON('/gpfs/scratch/sjiecheng/project2/mapper_9.json')[",(0:9)*1000000+1,":",(1:10)*1000000,"]

update_weight <- 0.1*(1/1e7)+0.9*sapply(1:1000000, function(x){mapper0[[x]] + mapper1[[x]] + mapper2[[x]] + mapper3[[x]] + mapper4[[x]] + mapper5[[x]] + mapper6[[x]] + mapper7[[x]] + mapper8[[x]] + mapper9[[x]]})
weight <- data.frame(url = ",(0:9)*1000000+1,":",(1:10)*1000000,", weight = update_weight)
write.csv(weight, '/gpfs/scratch/sjiecheng/project2/update_weight_",0:9,".csv', row.names = F)
")

slurm_scripts <- paste0("#!/bin/bash
#
#SBATCH --job-name=project_test
#SBATCH --ntasks-per-node=28
#SBATCH --nodes=1
#SBATCH --time=60:00
#SBATCH -p debug-28core

module load R/3.6.2
/gpfs/home/sjiecheng/project2/phase2/reducer_", 0:9, ".R")

for(i in 0:9){
  write(scripts[i+1], paste0('reducer_',i,'.R'))
  write(slurm_scripts[i+1], paste0('reducer_',i,'.slurm'))
}

