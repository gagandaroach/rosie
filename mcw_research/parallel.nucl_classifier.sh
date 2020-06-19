#!/bin/bash
# count nucleoid tiles. 
# 2 input folder of tiles from diff data source
# combine into one output

#SBATCH --partition=teaching
#SBATCH --job-name=COUNT_NUCLEOIDS_IN_TILES

SCRIPT_NAME="MSOE MCW Research - Categorize Histology Images based on Nucleoid Count"
WORKSPACE=/data/mcw_research

CONTAINER=$WORKSPACE/containers/Singularity.TF_pyvips_histomicstk.sif
INPUT_DIR=$WORKSPACE/tiles/prostate_he_tiles_0.5x
INPUT_DIR2=$WORKSPACE/tiles/prostate_he_tiles_0.5x_2
OUTPUT_DIR=$WORKSPACE/tiles/classified_bins/disk1+2_0.5x

SCRIPT_PATH=$WORKSPACE/python_image_prep/tile_nucleoid_classifer.py

## SCRIPT
echo "SBATCH SCRIPT: ${SCRIPT_NAME}"
date

echo Using Container: "$CONTAINER"
echo Python Executable: "${SCRIPT_PATH}"

IMAGES=$INPUT_DIR/*.png
IMAGES2=$INPUT_DIR2/*.png

for image in $IMAGES
do
    SCRIPT_ARGS="-i $image -o $OUTPUT_DIR -s True"
    srun singularity exec -B /data:/data ${CONTAINER} python3 ${SCRIPT_PATH} ${SCRIPT_ARGS}&
    sleep 2
done

for image in $IMAGES2
do
    SCRIPT_ARGS="-i $image -o $OUTPUT_DIR -s True"
    srun singularity exec -B /data:/data ${CONTAINER} python3 ${SCRIPT_PATH} ${SCRIPT_ARGS}&
    sleep 2
done

squeue
squeue -s

wait

## END SCRIPT
echo "END: " $SCRIPT_NAME
date
