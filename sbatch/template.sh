#!/bin/bash

#SBATCH --partition=dgx
#SBATCH --nodes=1
#SBATCH --gpus=8
#SBATCH --cpus-per-gpu=8
##SBATCH --time=10-1:0
# format: <days>-<hours>:<minutes>

MCW_RESEARCH=/srv/data/mcw_research
stylegan_dir=${MCW_RESEARCH}/stylegan2
TRAINING_DATA=0.5x_cleaned
DATA_DIR=$MCW_RESEARCH/tiles/tfrecords
echo $TRAINING_DATA

# Path to container
container="/data/containers/msoe-tensorflow.sif"

# Command to run inside container
command="python /srv/data/mcw_research/stylegan2/run_training.py --num-gpus=8 --data-dir=$DATA_DIR --config=config-f --dataset=$TRAINING_DATA --mirror-augment=true --gamma=100"

# Execute singularity container on node.
srun singularity exec --nv -B /data:/data ${container} /usr/local/bin/nvidia_entrypoint.sh ${command}

singularity exec --nv -B /data/mcw_research:/srv/data/mcw_research /data/containers/msoe-tensorflow.sif python /srv/data/mcw_research/stylegan2/run_training.py --num-gpus=8 --data-dir=$DATA_DIR --config=config-f --dataset=$TRAINING_DATA --mirror-augment=true --gamma=100

echo done we did it heck ya 
date
