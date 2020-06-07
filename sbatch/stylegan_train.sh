#!/bin/bash

#SBATCH --partition=dgx
#SBATCH --nodes=1
#SBATCH --gpus=8
#SBATCH --cpus-per-gpu=8
##SBATCH --time=13-1:0
# format: <days>-<hours>:<minutes>

SCRIPT_NAME="StyleGAN Train Script - MSOE MCW Research"
MCW_RESEARCH=/data/mcw_research

SCRIPT_PATH=$MCW_RESEARCH/stylegan/src/train.py

CONTAINER="/data/containers/msoe-tensorflow.sif"

#COMMAND="python $SCRIPT_PATH $SCRIPT_ARGS"

## SCRIPT
echo "starting sbatch script: ${SCRIPT_NAME}"
date

echo Training Dataset: "$TRAINING_DATASET"
echo Using Container: "$CONTAINER"
echo Executing Command: "${COMMAND}"

srun singularity exec --nv -B /data:/data ${CONTAINER} python "${SCRIPT_PATH}"

echo " "
echo "done we did it heck ya"
date
## END SCRIPT
