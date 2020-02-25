#!/bin/bash
echo hi

MCW_RESEARCH=/srv/data/mcw_research
stylegan_dir=${MCW_RESEARCH}/stylegan2
TRAINING_DATA=0.5x_cleaned
DATA_DIR=$MCW_RESEARCH/tiles/tfrecords
echo $TRAINING_DATA

#singularity exec --nv -B /data/mcw_research:/srv/data/mcw_research /data/singularity-images/tensorflow_20.01-tf1-py3.sif /usr/local/bin/nvidia_entrypoint.sh python ${stylegan_dir}/run_training.py --num-gpus=8 --data-dir=$DATA_DIR --config=config-f --dataset=$TRAINING_DATA --mirror-augment=true --gamma=100
#singularity exec --nv -B /data/mcw_research:/srv/data/mcw_research /data/ood/jupyter/containers/jupyter-tensorflow_20200203.sif python ${stylegan_dir}/run_training.py --num-gpus=8 --data-dir=${DATA_DIR} --config=config-f --dataset=${TRAINING_DATA} --mirror-augment=true --gamma=100
#singularity exec --nv -B /data/mcw_research:/srv/data/mcw_research /data/ood/jupyter/containers/jupyter-tensorflow_20200203.sif python ./run_tf_test.py
singularity exec --nv -B /data/mcw_research:/srv/data/mcw_research /data/containers/msoe-tensorflow.sif python ./run_tf_test.py



#/data/ood/jupyter/containers/jupyter-tensorflow_20200203.sif
echo done we did it heck ya 
date
