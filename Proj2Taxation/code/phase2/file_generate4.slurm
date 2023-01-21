#!/bin/bash
#
#SBATCH --job-name=project_test
#SBATCH --ntasks-per-node=20
#SBATCH --nodes=1
#SBATCH --time=10:00
#SBATCH -p debug-28core

module load R/3.6.2
/gpfs/home/sjiecheng/project2/phase2/file_generate4.R
