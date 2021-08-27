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
| desktop | 7 days |  20 |  dh-node[1-20] | `gpu:t4:1` |

## SLURM Commands

Slurm has a number of commands that control task execution on Rosie's compute resources. The below list details some of the basic commands.

* `sinfo`
  + What is the resource allocation per partition?
* `squeue`, `squeue -s`
  + What is running on the cluster right now?
* `srun <command>`, `srun python file.py`
  + Schedule a job or task to run on ROSIE.
* `sbatch slurm_batch_script.sh`
  + Submit a batch script of organized commands.
* `scancel <jobid>`
  + Cancel a running job.
