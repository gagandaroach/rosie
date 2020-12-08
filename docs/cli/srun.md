## SLURM Run

`srun` allows the user to run a job on Rosie. A job can be a shell script, python file, and more.

```bash
$ srun hostname
$ srun -N 3 hostname
$ srun --gres=gpu:t4:2 nvidia-smi
$ srun --gres=gpu:v100:8 nvidia-smi
```

The partition flag specifies what resouce set to use in the cluster. You can specify certain names, gpu configs, or even node counts with the srun command. 

```bash
# for exampke, with a python script
$ srun --partition=teaching --nodes=3 --cpus-per-task=10 python multi_node_command.py
```

### Requesting GPU Resources

```bash
# One T4 GPU
$ srun --partition=batch --gres=gpu:t4:1 nvidia-smi

# two t4 gpus, partition is optional
$ srun --gres=gpu:t4:2 nvidia-smi

# Nvidia dgx partition
$ srun --partition=dgx hostname

# this command will error out, you must ask slurm for gpus
$ srun --partition=dgx nvidia-smi

# run again, asking for all 8 v100 gpus
$ srun --partition=dgx --gres=gpu:v100:8 nvidia-smi
```

### Running Singularity Images

```bash
# queue up a script in a ubuntu singularity container
$ srun --partition=teaching singularity exec -B /data:/data /data/containers/ubuntu_20.04.sif cat /etc/os-release

# high performance batch processing node with two tesla T4 gpu
$ srun --partition=batch --gpus=2 --cpus-per-gpu=8 singularity exec --nv -B /data:/data ${CONTAINER} python ${SCRIPT_PATH} ${SCRIPT_ARGS}

# research computing node with 8 tesla T100 gpu connected with nvlink
$ srun --partition=dgx --gpus=8 --cpus-per-gpu=8 singularity exec --nv -B /data:/data ${CONTAINER} python ${SCRIPT_PATH} ${SCRIPT_ARGS}
```

The `--nv` flag auto mounts NVIDIA gpu resources to the singularity container. You can build singularity containers from any image on the Nvidia gpu cloud.