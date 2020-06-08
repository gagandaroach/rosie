#!/bin/bash

#SBATCH --partition=batch
#SBATCH --nodes=1
#SBATCH --gpus=2
#SBATCH --cpus-per-gpu=8
#SBATCH --job-name=TEST_PYTHON

CONTAINER="/data/containers/msoe-tensorflow.sif"
SCRIPT_NAME="MSOE ROSIE Python Example Script"
WORKSPACE=/home/$User/neuralnetwork
SCRIPT_PATH=$WORKSPACE/run_training.py
SCRIPT_ARGS="--num-gpus=2 --mirror-augment=false --learning-rate=0.3"

## START SCRIPT 
echo "SBATCH LOAD: ${SCRIPT_NAME}"
date

echo Using Container: "$CONTAINER"
echo Python Executable: "${SCRIPT_PATH}"

srun singularity exec --nv -B /data:/data ${CONTAINER} python ${SCRIPT_PATH} ${SCRIPT_ARGS}

## END SCRIPT
echo "END: " $SCRIPT_NAME
date
