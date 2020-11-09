#!/bin/bash
# uses pyvips tiling python script. see python_image_prep repository on my account.

#SBATCH --partition=batch
#SBATCH --nodes=1
#SBATCH --cpus-per-task=2
#SBATCH --job-name=TILE_WSI_TEST

SCRIPT_NAME="MSOE MCW Research - Tile large WSI .tif into many .png files."
WORKSPACE=/data/mcw_research

CONTAINER=$WORKSPACE/containers/Singularity.pyvips.sif
OUTPUT_DIR=$WORKSPACE/tiles/disk2
INPUT_DIR=$WORKSPACE/prostate_he_raw/disk2_20200224
INPUT_IMAGE=$INPUT_DIR/234_12.tif

SCRIPT_PATH=$WORKSPACE/python_image_prep/pyvips_WSI_to_tile.py
SCRIPT_ARGS="-i $INPUT_IMAGE -o $OUTPUT_DIR --scale=0.5"

## SCRIPT
echo "SBATCH SCRIPT: ${SCRIPT_NAME}"
date

echo Using Container: "$CONTAINER"
echo Python Executable: "${SCRIPT_PATH}"
echo Args: "${SCRIPT_ARGS}"

srun singularity exec --nv -B /data:/data ${CONTAINER} python3 ${SCRIPT_PATH} ${SCRIPT_ARGS}

## END SCRIPT
echo "END: " $SCRIPT_NAME
date
