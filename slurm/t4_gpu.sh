#!/bin/bash

#SBATCH --job-name="Sbatch Example"
#SBATCH --output=job_%j.out
#SBATCH --mail-type=ALL
#SBATCH --mail-user=student@msoe.edu
#SBATCH --partition=teaching
#SBATCH --nodes=1
#SBATCH --gres=gpu:t4:1
#SBATCH --cpus-per-gpu=4

## SCRIPT START

srun echo "Hello from the executing node!"
srun hostname
srun python --version
srun nvidia-smi

## SCRIPT END