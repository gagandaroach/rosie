#!/bin/bash

#SBATCH --job-name="DGX 8 GPU"
#SBATCH --output=train_%N_%j.out
#SBATCH --mail-type=ALL
#SBATCH --mail-user=researcher@msoe.edu
#SBATCH --partition=dgx
#SBATCH --nodes=1
#SBATCH --gres=gpu:v100:8
#SBATCH --cpus-per-gpu=8

SCRIPT_NAME="Rosie DGX Script"
CONTAINER="/data/containers/msoe-tensorflow.sif"
SCRIPT_PATH=""
SCRIPT_ARGS=""

## SCRIPT
echo "SBATCH SCRIPT: ${SCRIPT_NAME}"
srun hostname; pwd; date;
srun singularity exec --nv -B /data:/data ${CONTAINER} python3 ${SCRIPT_PATH} ${SCRIPT_ARGS}
echo "END: " $SCRIPT_NAME
