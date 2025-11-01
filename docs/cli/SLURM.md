The Simple Linux Utlity for Resource Management or SLURM is a software that is installed on every machine in the cluster. SLURM will give cluster uses as many cpu and gpu resources as needed to complete a job. SLURM will organize all work into a queue, managing all of Rosie's compute resources to maximize cluster utilization and minimize user wait time.

It provides three key functions:

  + allocating exclusive and/or non-exclusive access to resources (computer nodes) to users for some duration of time so they can perform work, 
  + providing a framework for starting, executing, and monitoring work (typically a parallel job such as MPI) on a set of allocated nodes, and
  + arbitrating contention for resources by managing a queue of pending jobs.

Slurm is the workload manager on about 60% of the TOP500 supercomputers.

## Rosie Resource Partitions

| PARTITION |  TIMELIMIT | NODES  | NODELIST | GPU Resources |
| ------------- |  ------------- | ------------- | ------------- | ------------ |
| teaching | 7 days | 20  | dh-node[1-20] | `gpu:t4:4` |
| batch | 2 days | 20  | dh-node[1-20] | `gpu:t4:4` | 
| highmem | 7 days |  2 |  dh-node[19-20] | `gpu:t4:4` |
| dgx | 21 days |  3  | dh-dgx1-[1-3] | `gpu:v100:8` | 
| dgxh100 | 21 days | 2 |  dh-dgxh100-[1-2] | `gpu:h100:8` | 
| desktop | 7 days |  20 |  dh-node[1-20] | `gpu:t4:1` |

## SLURM Commands

Slurm has a number of commands that control task execution on Rosie's compute resources. The below list details some of the basic commands.

* `sinfo`
  + What is the resource allocation per partition?
* `squeue`, `squeue -s`
  + What is running on the cluster right now?
* `srun <command>`, `srun python file.py`
  + Schedule a job or task to run on ROSIE.
  + If you want a GPU, include the `--gpus=1` option: `srun --gpus=1 bash`.
  + You can also use srun to ssh into a worker node: `srun --pty --partition=teaching bash` will open a bash terminal on a newly allocated node.  This will give you a prompt similar to `foggp@dh-node20:~$`.  Once you are logged in, you can open a second shell to that node by using `ssh dh-node20`, being sure to use the same number as the node you were allocated.
  + If you want a GPU, be sure to use `srun --pty --gpus=1 --partition=teaching bash` instead.
  + **Do not use --pty with the dgx nodes. Run batch jobs on these nodes instead.**
* `sbatch slurm_batch_script.sh`
  + Submit a batch script of organized commands.
* `scancel <jobid>`
  + Cancel a running job.
