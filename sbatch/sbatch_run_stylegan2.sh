#!/bin/bash

################################################################################
#
# Submit file for Rosie.
#
# To submit your job, run 'sbatch <jobfile>'
# To view your jobs in the Slurm queue, run 'squeue -l -u <your_username>'
# To view details of a running job, run 'scontrol show jobid -d <jobid>'
# To cancel a job, run 'scancel <jobid>'
#
# See the manpages for salloc, srun, sbatch, squeue, scontrol, and scancel
# for more information or read the Slurm docs online: https://slurm.schedmd.com
#
################################################################################


# You _must_ specify the partition. Rosie's default is the 'teaching'
# partition for interactive nodes.  Another option is the 'batch' partition.
#SBATCH --partition=dgx

# The number of nodes to request
#SBATCH --nodes=1

# The number of GPUs to request
#SBATCH --gpus=8

# The number of CPUs to request per GPU
#SBATCH --cpus-per-gpu=8

# Kill the job if it takes longer than the specified time
# format: <days>-<hours>:<minutes>
#SBATCH --time=0-1:0

####
#
# Here's the actual job code.
# Note: You need to make sure that you execute this from the directory that
# model.py is located in OR provide an absolute path.
#
####

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
