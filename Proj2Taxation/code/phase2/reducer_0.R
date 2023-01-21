#! /gpfs/software/R-3.6.0/lib64/R/bin/Rscript --vanilla

library(jsonlite)

mapper0 <- fromJSON('/gpfs/scratch/sjiecheng/project2/mapper_0.json')[1:1e+06]
mapper1 <- fromJSON('/gpfs/scratch/sjiecheng/project2/mapper_1.json')[1:1e+06]
mapper2 <- fromJSON('/gpfs/scratch/sjiecheng/project2/mapper_2.json')[1:1e+06]
mapper3 <- fromJSON('/gpfs/scratch/sjiecheng/project2/mapper_3.json')[1:1e+06]
mapper4 <- fromJSON('/gpfs/scratch/sjiecheng/project2/mapper_4.json')[1:1e+06]
mapper5 <- fromJSON('/gpfs/scratch/sjiecheng/project2/mapper_5.json')[1:1e+06]
mapper6 <- fromJSON('/gpfs/scratch/sjiecheng/project2/mapper_6.json')[1:1e+06]
mapper7 <- fromJSON('/gpfs/scratch/sjiecheng/project2/mapper_7.json')[1:1e+06]
mapper8 <- fromJSON('/gpfs/scratch/sjiecheng/project2/mapper_8.json')[1:1e+06]
mapper9 <- fromJSON('/gpfs/scratch/sjiecheng/project2/mapper_9.json')[1:1e+06]

update_weight <- 0.1*(1/1e7)+0.9*sapply(1:1000000, function(x){mapper0[[x]] + mapper1[[x]] + mapper2[[x]] + mapper3[[x]] + mapper4[[x]] + mapper5[[x]] + mapper6[[x]] + mapper7[[x]] + mapper8[[x]] + mapper9[[x]]})
weight <- data.frame(url = 1:1e+06, weight = update_weight)
write.csv(weight, '/gpfs/scratch/sjiecheng/project2/update_weight_0.csv', row.names = F)

