# Example SLURM Singularity Scripts

These are example scripts for performing work on the cluster.

## Executing scripts

To execute these scripts, use sbatch on the management nodes. 

```bash
    $ sbatch pyvips_tile_WSI.sh
```

**Note:** This will not work for users that do not have access to /data/mcw_research folder. This repo is meant as a concrete example to base personal workflow. 

## Descriptions

* pyvips_tile_WSI.sh
  * Use SLURM to schedule a python script in a Singularity container
  * read file from /data partition, write to /data partition
* parallel.pyvips_tile_WSI.sh
  * repeat that command for every file in a directory, parallel across compute nodes. 
* train_stylegan.sh
  * train large deep learning network
  * use data from lab pool
  * custom argument parameter pass through    
