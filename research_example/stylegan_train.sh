#!/bin/bash

#SBATCH --partition=dgx
#SBATCH --nodes=1
#SBATCH --gpus=8
#SBATCH --cpus-per-gpu=8
##SBATCH --time=13-1:0
# format: <days>-<hours>:<minutes>

SCRIPT_NAME="StyleGAN Train Script - MSOE MCW Research"
WORKSPACE=/data/mcw_research
SCRIPT_PATH=$WORKSPACE/stylegan/src/train.py
CONTAINER="/data/containers/msoe-tensorflow.sif"

## START SCRIPT
echo "starting sbatch script: ${SCRIPT_NAME}"
date

echo Training Dataset: "$TRAINING_DATASET"
echo Using Container: "$SCRIPT_PATH"
echo Python Executable: "${COMMAND}"

srun singularity exec --nv -B /data:/data ${CONTAINER} python "${SCRIPT_PATH}"

## END SCRIPT
echo "END " $SCRIPT_NAME
date