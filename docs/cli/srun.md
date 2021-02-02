## SLURM Run

`srun` allows the user to run a job on Rosie. A job can be a shell script, python file, and more.

```bash
# Ask slurm to run the "hostname" command.
$ srun hostname
# Ask slurm to run the "hostname" command on 3 nodes.
$ srun -N 3 hostname
# Ask slurm to run the "nvidia-smi" command on a node with 2 t4 gpus.
$ srun --gres=gpu:t4:2 nvidia-smi
# Ask slurm to run the "nvidia-smi" command on a node with 8 v100 gpus.
$ srun --gres=gpu:v100:8 nvidia-smi
# Ask slurm to email me alerts for this task.
$ srun --mail-user=student@msoe.edu --mail-type=BEGIN,END,FAIL hostname
```

### Requesting GPU Resources

```bash
# One T4 GPU
$ srun --gres=gpu:t4:1 --partition=teaching nvidia-smi

# Two T4 gpus, partition is optional
$ srun --gres=gpu:t4:2 nvidia-smi

# Nvidia dgx partition
$ srun  hostname

# this command will error out, you must ask slurm for gpus
$ srun --partition=teaching nvidia-smi

# DGX-1 Deep Learning Parition
# Allocate just one gpu,
$ srun --partition=dgx --gres=gpu:v100:1 nvidia-smi
# or all 8!
$ srun --partition=dgx --gres=gpu:v100:8 nvidia-smi
```

### Running Singularity Images

```bash
# queue up a script in a ubuntu singularity container
$ srun --partition=teaching singularity exec -B /data:/data /data/containers/ubuntu_20.04.sif cat /etc/os-release

# high performance batch processing node with two tesla T4 gpu
$ srun --partition=batch --gres=gpu:t4:2 --cpus-per-gpu=8 singularity exec --nv -B /data:/data /data/containers/msoe-tensorflow.sif nvidia-smi
```

The `--nv` flag auto mounts NVIDIA gpu resources to the singularity container. You can build singularity containers from any image on the Nvidia gpu cloud.