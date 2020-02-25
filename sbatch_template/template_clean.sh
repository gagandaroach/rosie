#!/bin/bash

#SBATCH --partition=dgx
#SBATCH --nodes=1
#SBATCH --gpus=8
#SBATCH --cpus-per-gpu=8
##SBATCH --time=10-1:0
# format: <days>-<hours>:<minutes>

echo starting sbatch script: Template job
date

MCW_RESEARCH=/data/mcw_research
INPUT_DIR=${MCW_RESEARCH}/stylegan2
OUTPUT_DIR=0.5x_cleaned

SCRIPT_PATH=/srv/data/mcw_research/stylegan2/run_training.py
SCRIPT_ARGS="--num-gpus=8 --data-dir=$DATA_DIR --config=config-f --dataset=$TRAINING_DATA --mirror-augment=true --gamma=100"

echo "$TRAINING_DATA"

# Path to container
container="/data/containers/msoe-tensorflow.sif"

# Command to run inside container
command="python $SCRIPT_PATH $SCRIPT_ARGS"

echo "${command}"

# Execute singularity container on node.
srun singularity exec --nv -B /data:/data ${container} /usr/local/bin/nvidia_entrypoint.sh ${command}

echo done we did it heck ya
date
