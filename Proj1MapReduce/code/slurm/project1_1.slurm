#!/bin/bash
#
#SBATCH --job-name=project_test
#SBATCH --ntasks-per-node=40
#SBATCH --nodes=1
#SBATCH --time=10:00
#SBATCH -p short-40core

module load R/3.6.2
/gpfs/home/sjiecheng/project1/project1_rcode1.R
