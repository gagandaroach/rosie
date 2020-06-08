# Singularity

Like docker. Virtual containers to easily manage dependencies.

Official Website: https://singularity.lbl.gov/

User Guide: https://sylabs.io/guides/3.3/user-guide/index.html

**Note:** ROSIE runs Singularity version 3.3

## Useful Commands

Singularity’s command line interface allows you to build and interact with containers transparently. You can run programs inside a container as if they were running on your host system. You can easily redirect IO, use pipes, pass arguments, and access files, sockets, and ports on the host system from within a container.

### Interactive Shell session with Container

You can interactively enter and image and execute commands.

```bash
$ singularity shell Singularity.image.sif
```

The home folder is syncronyzed between ROSIE and the singularity container. To access additional data on the cluster, you can mount folders with the -B flag. 

```bash
$ singularity shell -B /data:/data Sing.pyvips.sif
```

### Run command in Container

You can execute a command in a container with:

```bash
$ singularity exec Singularity.image.sif 
```

Add NVIDIA GPU to container with --nv flag

```bash
$ singularity exec --nv Singularity.image.sif 
```

Add local filesystem to Container with -B bind flag

```bash
$ singularity exec -B /data:/data Sing.image.sif python script.py
```

## Definition file

A Singularity Definition File (or “def file” for short) is like a set of blueprints explaining how to build a custom container. It includes specifics about the base OS to build or the base container to start from, software to install, environment variables to set at runtime, files to add from the host system, and container metadata.

Build with: 

```bash
$ singularity build Singularity.template.sif Singularity.template.def
```

**Note** Sys admin can build containers on cluster. Contact Gagan when your definition file is ready.

Documentation: https://sylabs.io/guides/3.3/user-guide/definition_files.html#overview