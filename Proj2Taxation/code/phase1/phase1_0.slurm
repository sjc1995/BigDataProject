#!/bin/bash
#
#SBATCH --job-name=project_test
#SBATCH --ntasks-per-node=40
#SBATCH --nodes=2
#SBATCH --time=60:00
#SBATCH -p short-40core

module load R/3.6.2
/gpfs/home/sjiecheng/project2/phase1/phase1_0.R
