#! /gpfs/software/R-3.6.0/lib64/R/bin/Rscript --vanilla

scripts <- paste0("#! /gpfs/software/R-3.6.0/lib64/R/bin/Rscript --vanilla

library(jsonlite)
mapper0 <- fromJSON('/gpfs/scratch/sjiecheng/project2/phase1_0.json')[",(0:9)*1000000+1,":",(1:10)*1000000,"]
mapper1 <- fromJSON('/gpfs/scratch/sjiecheng/project2/phase1_1.json')[",(0:9)*1000000+1,":",(1:10)*1000000,"]
mapper2 <- fromJSON('/gpfs/scratch/sjiecheng/project2/phase1_2.json')[",(0:9)*1000000+1,":",(1:10)*1000000,"]
mapper3 <- fromJSON('/gpfs/scratch/sjiecheng/project2/phase1_3.json')[",(0:9)*1000000+1,":",(1:10)*1000000,"]
mapper4 <- fromJSON('/gpfs/scratch/sjiecheng/project2/phase1_4.json')[",(0:9)*1000000+1,":",(1:10)*1000000,"]
mapper5 <- fromJSON('/gpfs/scratch/sjiecheng/project2/phase1_5.json')[",(0:9)*1000000+1,":",(1:10)*1000000,"]
mapper6 <- fromJSON('/gpfs/scratch/sjiecheng/project2/phase1_6.json')[",(0:9)*1000000+1,":",(1:10)*1000000,"]
mapper7 <- fromJSON('/gpfs/scratch/sjiecheng/project2/phase1_7.json')[",(0:9)*1000000+1,":",(1:10)*1000000,"]
mapper8 <- fromJSON('/gpfs/scratch/sjiecheng/project2/phase1_8.json')[",(0:9)*1000000+1,":",(1:10)*1000000,"]
mapper9 <- fromJSON('/gpfs/scratch/sjiecheng/project2/phase1_9.json')[",(0:9)*1000000+1,":",(1:10)*1000000,"]

url_list <- lapply(1:1000000, function(x){c(mapper0[[x]],mapper1[[x]],mapper2[[x]],mapper3[[x]],mapper4[[x]],mapper5[[x]],mapper6[[x]],mapper7[[x]],mapper8[[x]],mapper9[[x]])})
write(toJSON(url_list, null = 'null'), '/gpfs/scratch/sjiecheng/project2/url_list_",0:9,".json')
")

slurm_scripts <- paste0("#!/bin/bash
#
#SBATCH --job-name=project_test
#SBATCH --ntasks-per-node=40
#SBATCH --nodes=2
#SBATCH --time=60:00
#SBATCH -p short-40core

module load R/3.6.2
/gpfs/home/sjiecheng/project2/phase1/url_list_", 0:9, ".R")

for(j in 0:9){
  write(scripts[j+1], paste0('/gpfs/home/sjiecheng/project2/phase1/url_list_', j, '.R'))
  write(slurm_scripts[j+1], paste0('/gpfs/home/sjiecheng/project2/phase1/url_list_', j, '.slurm'))
}
