#!/bin/bash

#SBATCH --partition=teaching
#SBATCH --nodes=1
#SBATCH --gpus=1
#SBATCH --cpus-per-gpu=8
#SBATCH --job-name=T4_NN_TRAIN
#SBATCH --mail-user=daroachgb@msoe.edu
#SBATCH --mail-type=ALL

SCRIPT_NAME="Basic Sbatch test script."

## SCRIPT
echo "SBATCH LOAD: ${SCRIPT_NAME}"
date

srun hostname
srun nvidia-smi
srun hostname
srun id

## END SCRIPT
echo "END: " $SCRIPT_NAME
date
