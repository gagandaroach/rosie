# Milwaukee School of Engineering Academic High Performance Compute Cluster User Guide

![ROSIE Supercomputer](/ROSIE.jpg)

## Table of Contents

  - [Access Guide](#access-guide)
    - [Web Access](#web-access)
      - [Opening A Juypter Notebook Instance](#opening-a-juypter-notebook-instance)
    - [Shell Access](#shell-access)
  - [Running Experiments](#running-experiments)
    - [Resource Partitions](#resource-partitions)
    - [Singularity](#singularity)
      - [Definition File](#definition-file)
      - [Singularity Exec](#singularity-exec)
    - [SLURM](#slurm)
      - [Srun](#srun)
      - [Sbatch](#sbatch)
  - [Good to know SLURM Commands](#good-to-know-slurm-commands)
  - [Singularity Container Policy](#singularity-container-policy)
  - [Essential Reading To Master Using ROSIE](#essential-reading-to-master-using-rosie)
  - [**Need Help?**](#need-help)

## Access Guide

Getting started with performing scientific experiments on the compute cluster.

### Web Access

Users can use the web interface to interact with the computer cluster and accelerate their experiments.

[ROSIE Web Portal link](http://ood.rosie.msoe.edu)

**Note:** This requires a user account on the compute cluster. Addtionally, the cluster is only accessible within the MSOE campus network. To connect to network on linux, see convenience script in [utils](/utils) folder. On windows visit sslvpn.msoe.edu to install the vpn client.

On the web portal you can

* Open a Jupyter notebook instance for as many hours as needed.
* Ssh into the machine running the server and execute shell commands.
* Train neural networks for long periods of time.
* Install any python packages you need.

#### Opening A Juypter Notebook Instance

Log into the [ROSIE Web Portal](http://ood.rosie.msoe.edu) with your ROSIE username and password. Click on the Interactive Apps dropdown menu in the toolbar. From here, you can launch a jupyter notebook container for as long as needed.

**Note:** The shell access button will launch a terminal right in your browser. You can view and manage files on the node during the allocated time. 

### Shell Access

Advanced users can directly connect their command line interface to the machine and execute commands. 

Connect with ssh.

```
    $ ssh username@shell.rosie.msoe.edu
```

## Running Experiments

The cluster uses SLURM and Singularity to manage experiments. 

The Simple Linux Utlity for Resource Management or SLURM is a software that is installed on every machine in the cluster. SLURM will organize and dispatch researcher work requests, managing the available resource pool to give as much cpu and gpu power is imagineabile.

### Resource Partitions

The cluster has resources allocated to three partitions.

1. batch
   * 20 teaching nodes with 4 T4
   * 3 dgx1 nodes
2. teaching
   * 20 teaching nodes
3. dgx
   * NVIDIA DGX1 NODES

Teaching partition is good for ninety percent of work.

### Singularity

SLURM executes user specifc commands in Singularity containers. These are special containers that allow for the organized installation and management of custom libraries. A singularity container fucntions like a docker container, except the user account and permission are matched in the container.

```bash
    # cpu ubuntu workbox
    $ singularity shell -B /data:/data /data/containers/ubuntu.sif
    # gpu and tensorflow
    $ singularity shell --nv -B /data:/data /data/containers/msoe-tensorflow.sif
```

See singularity [folder](/singularity) to see more commands on using and creating containers to experiment with custom libraries and data.

#### Definition File

The definition file allows you to create singularity images with custom libraries and code. In the below example, I install a python image processing library onto the base tensorflow container. This enables me to schedule image data cleaning jobs on the batch nodes.

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

#### Singularity Exec

You can ask slurm to run a singularity container process with the singularity exec command. The container will load, execute the command, then exit.

### SLURM

#### Srun

Slurm run or srun will ask slurm to schedule the execution of a command inside of a singularity container when the requested resources are available. 

```bash
    # high performance batch processing node with two tesla T4 gpu
    srun --partition=batch singularity exec -B /data:/data /data/containers/ubuntu.sif 

    # high performance batch processing node with two tesla T4 gpu
    srun --partition=batch --gpus=2 --cpus-per-gpu=8 singularity exec --nv -B /data:/data ${CONTAINER} python ${SCRIPT_PATH} ${SCRIPT_ARGS}

    # research computing node with 8 tesla T100 gpu connected with nvlink
    srun --partition=dgx --gpus=8 --cpus-per-gpu=8 singularity exec --nv -B /data:/data ${CONTAINER} python ${SCRIPT_PATH} ${SCRIPT_ARGS}
```

The `--nv` flag auto mounts NVIDIA gpu resources to the singularity container. You can build singularity containers from any image on the Nvidia gpu cloud.

#### Sbatch

Sbatch is a wrapper around srun.

After figuring out and crafting code in singularity containers, a SLURM sbatch script can help manage environment varialbes around many simlar srun commands. By using sbatch, slurm will automaticate grab any number of nodes, gpus, and link them together and start your process. There is a lot of flexiblity. The sbatch script allows the researcher save and keep track of adjustments to experiments. 

```bash
    $ sbatch example_batch_script.sh
```

See example sbatch scripts in sbatch [folder](/sbatch).

**Note:** The advantage of sbatch is the organization of resource requests for slurm run requests. In the sbatch scripts, you see see the slurm sbatch properties with `#SBATCH prop=val`. With srun, you can set the same properties on the exec. The man pages for `srun`,`sbatch` have excellent examples.

## Good to know SLURM Commands

* `squeue`
  * What are people running on the cluster right now?
* `squeue -s`
  * A little more detail.
* `srun`
  * Ask slurm to run a command on the cluster compute nodes. Auto allocate, execute job, then release resources.
* `sbatch`
  * Queue up a sbatch script. An sbatch script is a bash script that calls srun.
* `scancel`

## Singularity Container Policy

See singularity [folder](/singularity) for examples on using singularity.

The cluster has a base tensorflow python image in `/data/containers/msoe-tensorflow.sif`. 

To request a custom singularity image for batch execution, query your research mentor or faculty advisor with:

  * Clear reason for needing custom container workspace.
  * Tested buildable Singularity Definition file on cluster.

## Essential Reading To Master Using ROSIE

In your browser, these are excellent resources to getting started.

* Bash scripting tutorial for beginners [linuxconfig.org](https://linuxconfig.org/bash-scripting-tutorial-for-beginners)
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

## **Need Help?**

email me: EECS SysAdmin Gagan Daroach <daroachgb@msoe.edu>
