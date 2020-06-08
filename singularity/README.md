# Singularity

Like docker. Virtual containers to easily manage dependencies.

User Guide: https://sylabs.io/guides/3.3/user-guide/index.html

ROSIE runs Singularity V3.3

## Useful Commands

### Interactive Shell session with Container

You can interactively enter and image and execute commands.

```
$ singularity shell Singularity.image.sif
```

The home folder is syncronyzed between ROSIE and the singularity container. To access additional data on the cluster, you can mount folders with the -B flag. 

```
$ singularity shell -B /data:/data Sing.pyvips.sif
```

### Run command in Container

You can execute a command in a container with:

```
$ singularity exec Singularity.image.sif 
```

Add NVIDIA GPU to container with --nv flag

```
$ singularity exec --nv Singularity.image.sif 
```

Add local filesystem to Container with -B bind flag

```
$ singularity exec -B /data:/data Sing.image.sif python script.py
```

## Definition file

Use to create custom singularity containers. Install custom packages with apt or create custom workspace folders.

Build with: 

```
$ singularity build Singularity.template.sif Singularity.template.def
```

**Note** Sys admin can build containers on cluster. Contact Gagan when your definition file is ready.