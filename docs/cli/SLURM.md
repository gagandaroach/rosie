The Simple Linux Utlity for Resource Management or SLURM is a software that is installed on every machine in the cluster. SLURM will give cluster uses as many cpu and gpu resources as needed to complete a job. SLURM will organize all work into a queue, managing all of ROSIE's compute resources to maximize cluster utilization and minimize user wait time.

It provides three key functions:

  * allocating exclusive and/or non-exclusive access to resources (computer nodes) to users for some duration of time so they can perform work,
  * providing a framework for starting, executing, and monitoring work (typically a parallel job such as MPI) on a set of allocated nodes, and
  * arbitrating contention for resources by managing a queue of pending jobs.

Slurm is the workload manager on about 60% of the TOP500 supercomputers.

### Resource Partitions

The cluster is organized into 3 partitions, dividing resources into queues for efficient scheduling.

1. batch
   * 20 teaching nodes with 4 T4
   * 3 dgx1 nodes
2. teaching
   * 20 teaching T4 gpu nodes
3. dgx
   * NVIDIA DGX1 NODES

Teaching partition is good for ninety percent of work.

**Note:** Partitions will change by end of Summer 2020.

### SLURM Run

#### Running barebones scripts in user-space

You can queue up any script in your home folder to execute on the network. 

```bash
$ srun --partition=teaching uname -a 
```

The partition flag specifies what resouce set to use in the cluster. You can specify certain names, gpu configs, or even node counts with the srun command. 

```bash
$ srun --partition=teaching --nodes=3 --cpus-per-task=10 python multi_node_command.py
```

#### Running Singularity Images (recommended)

Slurm run or `srun` will ask slurm to schedule the execution of a command inside of a singularity container when the requested resources are available. 

```bash
# queue up a script in a ubuntu singularity container
$ srun --partition=teaching singularity exec -B /data:/data /data/containers/ubuntu_20.04.sif cat /etc/os-release

# high performance batch processing node with two tesla T4 gpu
$ srun --partition=batch --gpus=2 --cpus-per-gpu=8 singularity exec --nv -B /data:/data ${CONTAINER} python ${SCRIPT_PATH} ${SCRIPT_ARGS}

# research computing node with 8 tesla T100 gpu connected with nvlink
$ srun --partition=dgx --gpus=8 --cpus-per-gpu=8 singularity exec --nv -B /data:/data ${CONTAINER} python ${SCRIPT_PATH} ${SCRIPT_ARGS}
```

The `--nv` flag auto mounts NVIDIA gpu resources to the singularity container. You can build singularity containers from any image on the Nvidia gpu cloud.

### SLURM Batch

Sbatch is a wrapper around srun. It allows researchers to organize their jobs with bash script fies.

```bash
$ sbatch example_batch_script.sh
```

#### Example Sbatch Script

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

Addtional sbatch scripts in slurm [folder](/slurm).

**Note:** The advantage of sbatch is the organization of resource requests for slurm run requests. In the sbatch scripts, you see see the slurm sbatch properties with `#SBATCH prop=val`. With srun, you can set the same properties on the exec. The man pages for `srun`,`sbatch` have excellent examples.

### Other SLURM Commands 

* `squeue`
  * What are people running on the cluster right now?
* `squeue -s`
  * A little more detail.
* `scancel jobid`
  * cancel a running job.