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

How to connect to the cluster.

### Web Access

Users can use their web browser to interact with the computer cluster and schedule jobs.

[ROSIE Web Portal link](http://ood.rosie.msoe.edu)

**Note:** This requires a user account on the compute cluster. 

**VPN Note:** The cluster is only accessible within the MSOE campus network. If you are off campus, you must connect to the MSOE virtual private network. To connect to the vpn on linux, see convenience script in [utils](/utils) folder. On windows, visit sslvpn.msoe.edu to install the vpn client.

On the web portal you can

* Open a Jupyter notebook instance for as many hours as needed.
* Ssh into the machine running the server and execute shell commands.
* Train neural networks for long periods of time.
* Install any python packages you need.

#### Opening A Juypter Notebook Instance

Log into the [ROSIE Web Portal](http://ood.rosie.msoe.edu) with your ROSIE username and password. Click on the Interactive Apps dropdown menu in the toolbar. From here you can launch a jupyter notebook web server for some amount of user specified time.

**Note:** The shell access button will launch a terminal right in your browser. You can view and manage files on the node during the allocated time. 

### Shell Access

Advanced users can directly connect their command line interface to the machine and execute commands. 

Connect with ssh.

```
    $ ssh username@shell.rosie.msoe.edu
```

## Designing Experiments with Singularity

Singularity is a platform that enables organized installation and management of custom libraries and code. Singularity creates virtual machiines that can be dispatched across nodes on the cluster, creating homogeneous virtual working environments. 

Singularity virutal machines are saved as .sif files. A sif file can be instantiated to a running virtual machine. The user can enter this virtual machine, create a shell session, and execute command line arguments.

### Singularity Shell

```bash
    # cpu ubuntu workbox
    $ singularity shell -B /data:/data /data/containers/ubuntu.sif
    # --nv flags attached node gpus and tensorflow
    $ singularity shell --nv -B /data:/data /data/containers/msoe-tensorflow.sif
```

See singularity [folder](/singularity) to see more commands on using and creating containers to experiment with custom libraries and data.

### Definition File

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

### Singularity Exec

You can ask slurm to run a singularity container process with the singularity exec command. The container will load, execute the command, then exit.

### Cluster Singularity Images

The cluster has the following singularity containers available for use:

| Image Name          | Container Location in Cluster        |
|---------------------|--------------------------------------|
| ubuntu_18.04.sif    | /data/containers/ubuntu_18.04.sif    |
| ubuntu_20.04.sif    | /data/containers/ubuntu_20.04.sif    |
| msoe-tensorflow.sif | /data/containers/msoe-tensorflow.sif |

### Building Singularity Image Policy

See singularity [folder](/singularity) for examples on using singularity and example singularity definition files.

To request a custom singularity image for batch execution, query your research mentor or faculty advisor with:

  * Clear reason for needing custom container workspace.
  * Singularity def file created and tested on local machine.
  * Copy of Singularity file in cluster home directory.

## Running Experiments with SLURM

The cluster uses SLURM and Singularity to manage experiments. 

The Simple Linux Utlity for Resource Management or SLURM is a software that is installed on every machine in the cluster. SLURM will give cluster uses as many cpu and gpu resources as needed to complete a job. SLURM will organize all work into a queue, managing all of ROSIE's compute resources to maximize cluster utilization and minimize user wait time.

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

**Note:** Partitions will change by end of Summer 2020.

### SLURM Run

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

### SLURM Batch

Sbatch is a wrapper around srun.

After figuring out and crafting code in singularity containers, a SLURM sbatch script can help manage environment varialbes around many simlar srun commands. By using sbatch, slurm will automaticate grab any number of nodes, gpus, and link them together and start your process. There is a lot of flexiblity. The sbatch script allows the researcher save and keep track of adjustments to experiments. 

```bash
    $ sbatch example_batch_script.sh
```

See example sbatch scripts in slurm [folder](/slurm).

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

## Need Help?

email me: EECS SysAdmin Gagan Daroach <daroachgb@msoe.edu>
