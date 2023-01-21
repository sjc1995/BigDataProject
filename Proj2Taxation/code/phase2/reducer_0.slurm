#!/bin/bash
#
#SBATCH --job-name=project_test
#SBATCH --ntasks-per-node=28
#SBATCH --nodes=1
#SBATCH --time=60:00
#SBATCH -p debug-28core

module load R/3.6.2
/gpfs/home/sjiecheng/project2/phase2/reducer_0.R
