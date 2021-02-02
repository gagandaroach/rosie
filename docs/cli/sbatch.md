## SLURM Batch

**sbatch** submits a batch script to Slurm. The batch script may be given to sbatch through a file name on the command line, or if no file name is specified, sbatch
will read in a script from standard input. The batch script may contain options preceded with "#SBATCH" before any executable commands in the script.

sbatch exits immediately after the script is successfully transferred to the Slurm controller and assigned a Slurm job ID. The batch script  is  not  necessarily
granted resources immediately, it may sit in the queue of pending jobs for some time before its required resources become available.

By default both standard output and standard error are directed to a file of the name "slurm-%j.out", where the "%j" is replaced with the job allocation number.
The file will be generated on the first node of the job allocation. Other than the batch script itself, Slurm does no movement of user files.

When the job allocation is finally granted for the batch script, Slurm runs a single copy of the batch script on the first node in the set of allocated nodes.

### Running a file

```bash
# On a management node
$ sbatch script.sh
```

### File anatomy

Example sbatch files for Rosie can be found on the msoe.dev github repo [here](https://github.com/gagandaroach/rosie/tree/master/slurm). Below is the example `t4_gpu.sh` sbatch script.

```sh
#!/bin/bash

#SBATCH --job-name="Sbatch Example"
#SBATCH --output=job_%j.out
#SBATCH --mail-type=ALL
#SBATCH --mail-user=student@msoe.edu
#SBATCH --partition=teaching
#SBATCH --nodes=1
#SBATCH --gres=gpu:t4:1
#SBATCH --cpus-per-gpu=4

## SCRIPT START

srun echo "Hello from the executing node!"
srun hostname
srun python --version
srun nvidia-smi

## SCRIPT END
```

Lets break it down...

**Rosie Script Header**'

`#SBATCH --job-name="Sbatch Example"`: The name of this particular job, used by slurm reporting.

`#SBATCH --output=job_%j.out`: Name of the sbatch output file. The job output will be saved here. Can be viewed in termial with `$ cat job_id.out` or with paging `$ less job_id.out`. To follow the output on large tasks, use `$tail -f job_id.out`. 

`#SBATCH --mail-type=ALL`: When to send email alerts. Options: NONE, BEGIN, END, FAIL, REQUEUE, ALL. Can be comma separated list for multiple options.

`#SBATCH --mail-user=student@msoe.edu`: Who to email. Can be comma seperated list.

`#SBATCH --nodes=1`: The number of nodes for the job. Can combine multiple nodes for additional compute resources.

`#SBATCH --gres=gpu:t4:1`: The number / type of gpu resource for this job. The integer at the end can be changed to request more gpus.

By tuning this values users can experiment with different cluster configurations on their tasks.

**Script Body**

This is where the work for the bash script happens. `Srun` requests commands to be executed on the allocated node with the requested resources. These should be modified for per use case.

### Using Singularity Containers

Example executing a python file inside a singularity container, with sbatch.

```sh
#!/bin/bash

#SBATCH --job-name="Sbatch Example"
#SBATCH --output=job_%j.out
#SBATCH --mail-type=ALL
#SBATCH --mail-user=student@msoe.edu
#SBATCH --partition=teaching
#SBATCH --nodes=1
#SBATCH --gres=gpu:t4:1
#SBATCH --cpus-per-gpu=4

SCRIPT_NAME="Rosie Job Script"
CONTAINER="/data/containers/msoe-tensorflow.sif"
PYTHON_FILE="/home/user/train_network.py"
SCRIPT_ARGS="--input input_folder --output output_folder"

## SCRIPT
echo "SBATCH SCRIPT: ${SCRIPT_NAME}"
srun hostname; pwd; date;
srun singularity exec --nv -B /data:/data ${CONTAINER} python3 ${PYTHON_FILE} ${SCRIPT_ARGS}
echo "END: " $SCRIPT_NAME
```