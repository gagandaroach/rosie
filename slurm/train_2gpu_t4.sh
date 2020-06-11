#!/bin/bash

#SBATCH --partition=teaching
#SBATCH --nodes=1
#SBATCH --gpus=2
#SBATCH --cpus-per-gpu=8
#SBATCH --job-name=T4_NN_TRAIN

SCRIPT_NAME="T4 1 GPU Neural Network Train Script"
WORKSPACE=/home/$USER/workspace
SCRIPT_PATH=$WORKSPACE/src/run_training.py
RESULT_DIR=$WORKSPACE/results
DATASET_DIR=$WORKSPACE/data
DATASET_NAME="CIFAR-10"

SCRIPT_ARGS="--num-gpus=2 --data-dir=$DATASET_DIR --result-dir=$RESULT_DIR --dataset=$DATASET_NAME"

CONTAINER="/data/containers/msoe-tensorflow.sif"

## SCRIPT
echo "SBATCH LOAD: ${SCRIPT_NAME}"
date

echo Using Container: "$CONTAINER"
echo Python Executable: "${SCRIPT_PATH}"
echo Python Args: "${SCRIPT_ARGS}"
echo Dataset Folder: "$DATASET_DIR"
echo Dataset Name: "$DATASET_NAME"

srun singularity exec --nv -B /data:/data ${CONTAINER} python ${SCRIPT_PATH} ${SCRIPT_ARGS}

## END SCRIPT
echo "END: " $SCRIPT_NAME
date
