#!/bin/bash

#SBATCH --job-name="Sbatch Example"
#SBATCH --output=job_%j.out
#SBATCH --mail-type=ALL
#SBATCH --mail-user=student@msoe.edu
#SBATCH --partition=teaching
#SBATCH --nodes=1
#SBATCH --gres=gpu:t4:1
#SBATCH --cpus-per-gpu=4

SCRIPT_NAME="Rosie Job Script"
CONTAINER="/data/containers/msoe-tensorflow.sif"
SCRIPT_PATH=""
SCRIPT_ARGS=""

## SCRIPT
echo "SBATCH SCRIPT: ${SCRIPT_NAME}"
srun hostname; pwd; date;
srun singularity exec --nv -B /data:/data ${CONTAINER} python3 ${SCRIPT_PATH} ${SCRIPT_ARGS}
echo "END: " $SCRIPT_NAME
