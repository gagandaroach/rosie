# Example SLURM Singularity Scripts

## Executing scripts

To execute these scripts, use sbatch on the management nodes. 

```bash
    $ sbatch pyvips_tile_WSI.sh
```

**Note:** This will not work for users that do not have access to /data/mcw_research folder. This repo is meant as a concrete example to base personal workflow. 

## Descriptions

  * pyvips_tile_WSI.sh
    * Execute one command in a Singularity conatiner on a compute node.
  * parallel.pyvips_tile_WSI.sh
    * repeat that command for every file in a directory, parallel accross compute nodes. 
    * run command using srun on singularity container
  * train_stylegan.sh
    * ask slurm to schedule training of stylegan network on dgx node, with 8 gpu
    
