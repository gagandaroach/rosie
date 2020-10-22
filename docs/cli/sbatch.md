## SLURM Batch

Sbatch is a wrapper around srun. It allows researchers to organize their jobs with bash script fies.

```bash
$ sbatch example_batch_script.sh
```

### Example Sbatch Script

```sh
#!/bin/bash

#SBATCH --partition=teaching
#SBATCH --nodes=1
#SBATCH --cpus-per-task=2
#SBATCH --job-name=CPU_JOB

SCRIPT_NAME="MSOE CPU Processing Script - NO GPU"
CONTAINER="/data/containers/msoe-tensorflow.sif"
WORKSPACE=/data/mcw_research
OUTPUT_DIR=$WORKSPACE/output
INPUT_DIR=$WORKSPACE/input
SCRIPT_PATH=$WORKSPACE/src/process_thing.py
SCRIPT_ARGS="-i $INPUT_DIR -o $OUTPUT_DIR"

## SCRIPT
echo "SBATCH SCRIPT: ${SCRIPT_NAME}"
srun singularity exec -B /data:/data ${CONTAINER} python3 ${SCRIPT_PATH} ${SCRIPT_ARGS}
echo "END: " $SCRIPT_NAME
```


**Note:** The advantage of sbatch is the organization of resource requests for slurm run requests. In the sbatch scripts, you see see the slurm sbatch properties with `#SBATCH prop=val`. With srun, you can set the same properties on the exec. The man pages for `srun`,`sbatch` have excellent examples.