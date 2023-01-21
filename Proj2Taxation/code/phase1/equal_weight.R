#! /gpfs/software/R-3.6.0/lib64/R/bin/Rscript --vanilla

# equal init weights
weight <- data.frame(url = 1:10000000, weight = 1/10000000)
write.csv(weight, '/gpfs/scratch/sjiecheng/project2/current_weight.csv', row.names = F)
