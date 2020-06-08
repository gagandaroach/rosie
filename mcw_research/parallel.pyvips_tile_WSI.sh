#!/bin/bash
# uses pyvips tiling python script. see python_image_prep repository on my account.
# schedule one job per each image file. each job in a seperate singularity container.
# execute all jobs simultaneously
# note: it put 1 job on 9. it first put 1 job on index 0, then wrapped aout and put the last 20 on node index 0. rip.

#SBATCH --partition=batch
#SBATCH --nodes=10
#SBATCH --job-name=TILE_WSI_TEST

SCRIPT_NAME="MSOE MCW Research - Tile large WSI .tif into many .png files."
WORKSPACE=/data/mcw_research

CONTAINER=$WORKSPACE/containers/Singularity.pyvips.sif
OUTPUT_DIR=$WORKSPACE/tiles/disk2
INPUT_DIR=$WORKSPACE/prostate_he_raw/disk2_20200224

SCRIPT_PATH=$WORKSPACE/python_image_prep/pyvips_WSI_to_tile.py

## SCRIPT
echo "SBATCH SCRIPT: ${SCRIPT_NAME}"
date

echo Using Container: "$CONTAINER"
echo Python Executable: "${SCRIPT_PATH}"
echo Args: "${SCRIPT_ARGS}"

IMAGES=$INPUT_DIR/*.tif

for image in $IMAGES
do
    SCRIPT_ARGS="-i $image -o $OUTPUT_DIR --scale=0.5"
    srun -N 1 singularity exec --nv -B /data:/data ${CONTAINER} python3 ${SCRIPT_PATH} ${SCRIPT_ARGS}&
done

squeue
squeue -s

wait

## END SCRIPT
echo "END: " $SCRIPT_NAME
date
