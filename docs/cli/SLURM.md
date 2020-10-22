The Simple Linux Utlity for Resource Management or SLURM is a software that is installed on every machine in the cluster. SLURM will give cluster uses as many cpu and gpu resources as needed to complete a job. SLURM will organize all work into a queue, managing all of Rosie's compute resources to maximize cluster utilization and minimize user wait time.

It provides three key functions:

  * allocating exclusive and/or non-exclusive access to resources (computer nodes) to users for some duration of time so they can perform work,
  * providing a framework for starting, executing, and monitoring work (typically a parallel job such as MPI) on a set of allocated nodes, and
  * arbitrating contention for resources by managing a queue of pending jobs.

Slurm is the workload manager on about 60% of the TOP500 supercomputers.

## Rosie Resource Partitions

1. Batch Process Partition
   * High performance cpu cores across all compute nodes. 
   * name: `batch`
2. Accelerated Compute Instruction Partition
   * description: 20 Compute PizzaBox Nodes
   * name: `teaching`
   * gres: `gpu:t4:4`
3. Deep Learning Partition
   * description: 3 Nvidia DGX-1 Stations
   * name: `dgx`
   * gres: `gpu:v100:8`

## SLURM Commands

* `squeue`, `squeue -s`
  * What is running on the cluster right now?
* `srun <command>`, `srun python file.py`
  * Schedule a job or task to run on ROSIE.
* `sbatch slurm_batch_script.sh`
  * Submit a batch script of organized commands.
* `scancel <jobid>`
  * Cancel a running job.