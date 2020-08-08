# Milwaukee School of Engineering Academic High Performance Compute Cluster User Guide

![ROSIE Supercomputer](/ROSIE.jpg)

- [Milwaukee School of Engineering Academic High Performance Compute Cluster User Guide](#milwaukee-school-of-engineering-academic-high-performance-compute-cluster-user-guide)
  - [Activating your User Account](#activating-your-user-account)
  - [Access Guide](#access-guide)
    - [Shell Access](#shell-access)
    - [Web Access](#web-access)
      - [Opening A Juypter Notebook Instance](#opening-a-juypter-notebook-instance)
  - [Compute Infrastructure](#compute-infrastructure)
  - [Storage Pools](#storage-pools)
  - [Singularity Virtual Environments](#singularity-virtual-environments)
    - [Executing commands in Singularity Image](#executing-commands-in-singularity-image)
    - [Interactive Singularity Shell](#interactive-singularity-shell)
    - [ROSIE Available Singularity Images](#rosie-available-singularity-images)
    - [Building Singularity Images](#building-singularity-images)
      - [Definition File](#definition-file)
  - [Running Experiments with SLURM](#running-experiments-with-slurm)
    - [Resource Partitions](#resource-partitions)
    - [SLURM Run](#slurm-run)
      - [Running barebones scripts in user-space](#running-barebones-scripts-in-user-space)
      - [Running Singularity Images (recommended)](#running-singularity-images-recommended)
    - [SLURM Batch](#slurm-batch)
      - [Example Sbatch Script](#example-sbatch-script)
    - [Other SLURM Commands](#other-slurm-commands)
  - [How To Master Using ROSIE](#how-to-master-using-rosie)
  - [Need Help? Any comments or concerns? Email me.](#need-help-any-comments-or-concerns-email-me)

## Activating your User Account

The campus cluster uses its own account managemnt system. To request an account, contact the EECS department or the ROSIE SysAdmin.

You will be given a username and temporary password. You must log in via shell to reset this temporary password before you can use the web portal.

## Access Guide

How to connect to the cluster.

### Shell Access

Users can directly connect to the management nodes and and open a command line interface.

Connect with **ssh**.

```
    $ ssh username@shell.rosie.msoe.edu
```

Windows command prompt and powershell do not include ssh by default. An easy way to get the ssh program is to download and install GIT. The included git bash terminal program has a ssh command.

### Web Access

Users can use their web browser to interact with the computer cluster and schedule jobs.

[ROSIE Web Portal link](https://dh-ood.hpc.msoe.edu)

**VPN Note:** The cluster is only accessible within the MSOE campus network. If you are off campus, you must connect to the MSOE virtual private network. To connect to the vpn on linux, see convenience script in [utils](/utils) folder. On windows, visit sslvpn.msoe.edu to install the vpn client.

On the web portal you can

* Open a Jupyter notebook instance for as many hours as needed.
* Ssh into the machine running the server and execute shell commands.
* Train neural networks for long periods of time.
* Install any python packages you need.

#### Opening A Juypter Notebook Instance

Log into the [ROSIE Web Portal](http://dh-ood.hpc.msoe.edu) with your ROSIE username and password. Click on the Interactive Apps dropdown menu in the toolbar. From here you can launch a jupyter notebook web server for some amount of user specified time.

**Note:** The shell access button will launch a terminal right in your browser. You can view and manage files on the node during the allocated time. 


## Compute Infrastructure

ROSIE has 3 different types of computational processing nodes. There is a total of 27 compute nodes on the cluster.

| Name | Node Count | Processor | CPU Count | RAM | GPU | IP Address |
|----------|---------|-------|--------|-----|----|----|
| Management | 4 | Intel Xeon Gold 6240 @ 2.601GHz | 72 | 187G | No GPU | 10.199.0.20[1-4] |
| T4 | 20 | Intel Xeon Gold 6240 @ 2.60GHz | 72 | 376G | 4x Tesla T4 | 10.199.0.[1-20] |
| DGX-1 | 3 | Intel Xeon CPU E5-2698 v4 @ 2.20GHz | 80 | 503G | 8x Tesla V100-SXM2 | 10.199.0.10[1-3] |

## Storage Pools

ROSIE has two high speed access 90TB storage nodes.

1. The first storage device stores the home folder for every cluster user.
2. The second storage devices holds the `/data` resource share. This contains datasets and code samples for faculty and students researching with the clusters compute resources.

Both of these data pools are mounted to each cluster compute node at the same mountpoint.

This means that from any machine on the cluster, you can access your home folder files and research data files.

## Singularity Virtual Environments

Like docker. Virtual containers to easily manage dependencies.

Official Website: https://singularity.lbl.gov/

User Guide: https://sylabs.io/guides/3.3/user-guide/index.html

**Note:** ROSIE runs Singularity version 3.3

Singularity is a platform that enables organized installation and management of custom libraries and code. Singularity creates virtual machiines that can be dispatched across nodes on the cluster, creating homogeneous virtual working environments. 

Singularity’s command line interface allows you to interact with containers transparently. You can run programs inside a container as if they were running on your host system. You can easily redirect IO, use pipes, pass arguments, and access files, sockets, and ports on the host system from within a container.

Singularity containers are saved as .sif files. A sif file can be instantiated to a running virtual machine. The user can enter this virtual machine, create a shell session, and execute command line arguments.

### Executing commands in Singularity Image

You can execute a command in a container. This will execute the command, then quit the container. This is useful for creating a job, as the sif can hold all required job files.

```bash
$ singularity exec -B /data:/data /data/containers/ubuntu_20.04.sif cat /etc/os-release
```
**Note:** Add cluster datapool to Container with -B bind flag.

You can also add NVIDIA GPU to container command execution with --nv flag

```bash
$ singularity exec --nv /data/containers/msoe-tensorflow.sif cat /etc/os-release
```

### Interactive Singularity Shell

You can enter an interactive shell with a singularity image. The `-b` flag will bind mount data into the container, with the pattern `host:conatiner`. The `-nv` flag will mount the gpus into the virtual machine.

```bash
# cpu ubuntu workbox
$ singularity shell -B /data:/data /data/containers/ubuntu_20.04.sif
```

You can attach gpus to the interactive shell. 

```bash
# --nv flags attached node gpus and tensorflow
$ singularity shell --nv -B /data:/data /data/containers/msoe-tensorflow.sif
```

If you combine the above command with SLURM, you can schedule a active shell session on a T4 compute node!

### ROSIE Available Singularity Images

The cluster has the following singularity containers available for use:

| Image Name          | Container Location in Cluster        |
|---------------------|--------------------------------------|
| ubuntu_18.04.sif    | /data/containers/ubuntu_18.04.sif    |
| ubuntu_20.04.sif    | /data/containers/ubuntu_20.04.sif    |
| msoe-tensorflow.sif | /data/containers/msoe-tensorflow.sif |

### Building Singularity Images

Users can create their own singulairyt images from the popular docker images on the DockerHub or NVIDIA GPU Cloud. To create a singularity image from a docker container:

```bash
$ singularity build Singularity.ubuntu.sif docker://ubuntu:latest
```

This will create a singularity image `Singularity.ubuntu.sif` of the latest tag docker ubuntu container.

See singularity [folder](/singularity) for example singularity definition files.

To request a custom singularity image for batch execution, query your research mentor or faculty advisor with:

  * Clear reason for needing custom container workspace.
  * Singularity def file created and tested on local machine.
  * Copy of Singularity file in cluster home directory.

#### Definition File

The definition file allows you to create singularity images with custom libraries and code. In the below example, I install a python image processing library onto a base docker tensorflow container. This enables me to schedule image data cleaning jobs on the batch nodes.

```
Bootstrap: docker
From: tensorflow:19.07-py3
Registry: nvcr.io
Namespace: nvidia
# -----------------------------------------------------------------------------------

%post
# -----------------------------------------------------------------------------------
# this will install all necessary packages and prepare the container

    apt-get update && apt-get -y upgrade
    apt-get -y install \
        libvips-dev \
        libvips-tools \
        python3 \
        python3-pip
    python3 -m pip install --upgrade pip
    python3 -m pip install --upgrade setuptools
    python3 -m pip install pyvips
```

## Running Experiments with SLURM

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

## How To Master Using ROSIE

In your browser, these are excellent resources to getting started.

* SLURM Documentation [link](https://slurm.schedmd.com/documentation.html)
* Singularity Documentation [link](https://slurm.schedmd.com/documentation.html)

On any node on the cluster, execute these commands to read detailed information about the commands.

```bash
  $ man srun
  $ man sbatch
  $ singularity --help
```

Slurm jobs scheduled by daroachg for mcw_research Medical Imaging are in mcw_research [folder](/mcw_research). Examples of sbatch scripts using srun and singularity to:

  * StyleGAN deploy on dgx node
  * Batched parallel data cleaning 

## Need Help? Any comments or concerns? Email me.

email me: EECS SysAdmin Gagan Daroach <daroachgb@msoe.edu>
 