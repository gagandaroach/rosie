#!/bin/bash

#SBATCH --partition=dgx
#SBATCH --nodes=1
#SBATCH --gpus=8
#SBATCH --cpus-per-gpu=8
##SBATCH --time=10-1:0
# format: <days>-<hours>:<minutes>

SCRIPT_NAME="Template Job"
MCW_RESEARCH=/data/mcw_research

NETWORK_DIR=$MCW_RESEARCH/stylegan2
DATASET_DIR=$MCW_RESEARCH/tiles/tfrecords
TRAINING_DATASET=0.5x_cleaned

SCRIPT_PATH=$NETWORK_DIR/run_training.py
SCRIPT_ARGS="--num-gpus=8 --data-dir=$DATASET_DIR --config=config-f --dataset=$TRAINING_DATASET --mirror-augment=true --gamma=100"

CONTAINER="/data/containers/msoe-tensorflow.sif"
COMMAND="python $SCRIPT_PATH $SCRIPT_ARGS"

## SCRIPT
echo "starting sbatch script: ${SCRIPT_NAME}"
date

echo Training Dataset: "$TRAINING_DATASET"
echo Using Container: "$CONTAINER"
echo Executing Command: "${COMMAND}"

srun singularity exec --nv -B /data:/data ${CONTAINER} /usr/local/bin/nvidia_entrypoint.sh "${COMMAND}"

echo "done we did it heck ya"
date
## END SCRIPT