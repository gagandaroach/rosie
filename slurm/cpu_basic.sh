#!/bin/bash

#SBATCH --job-name="Sbatch Example"
#SBATCH --output=cpu_job_%j.out
#SBATCH --mail-type=ALL
#SBATCH --mail-user=student@msoe.edu
#SBATCH --partition=teaching
#SBATCH --nodes=1
#SBATCH --cpus-per-task=2
#SBATCH --mem=2GB

## SCRIPT START

srun echo "Hello from the executing node!"
srun hostname
srun python --version

## SCRIPT END