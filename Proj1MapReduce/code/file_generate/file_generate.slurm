#!/bin/bash
#
#SBATCH --job-name=project_test
#SBATCH --output=test1.txt
#SBATCH --ntasks-per-node=40
#SBATCH --nodes=2
#SBATCH --time=10:00
#SBATCH -p short-40core


module load R/3.6.2
/gpfs/home/sjiecheng/project1/file_generate.R
