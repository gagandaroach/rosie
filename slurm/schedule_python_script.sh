#!/bin/bash

#SBATCH --partition=teaching
#SBATCH --nodes=1
#SBATCH --cpus-per-task=2
#SBATCH --job-name=CPU_JOB

SCRIPT_NAME="MSOE CPU Processing Script - NO GPU"
WORKSPACE=/data/mcw_research

CONTAINER="/data/containers/msoe-tensorflow.sif"
OUTPUT_DIR=$WORKSPACE/output
INPUT_DIR=$WORKSPACE/input

SCRIPT_PATH=$WORKSPACE/src/process_thing.py
SCRIPT_ARGS="-i $INPUT_DIR -o $OUTPUT_DIR"

## SCRIPT
echo "SBATCH SCRIPT: ${SCRIPT_NAME}"
date

echo Using Container: "$CONTAINER"
echo Python Executable: "${SCRIPT_PATH}"
echo Args: "${SCRIPT_ARGS}"

srun singularity exec -B /data:/data ${CONTAINER} python3 ${SCRIPT_PATH} ${SCRIPT_ARGS}

## END SCRIPT
echo "END: " $SCRIPT_NAME
date
