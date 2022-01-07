## SLURM Run

`srun` allows the user to run a job on Rosie. A job can be a shell script, python file, and more.

Enter srun commands on a management node. SLURM will request the appropriate resources to complete the task.

For detailed usage and technical `srun` information, input `$ man srun` or `$ srun --help` in the command line.

```bash
# Ask slurm to run the "hostname" command on the default partition.
$ srun hostname

# Ask slurm to run the "hostname" command on 3 nodes.
$ srun -N 3 hostname

# Ask slurm to run the "nvidia-smi" command on a node with 2 t4 gpus.
$ srun --gres=gpu:t4:2 nvidia-smi

# Ask slurm to run the "nvidia-smi" command on a node with 8 v100 gpus.
$ srun --gres=gpu:v100:8 nvidia-smi

# Ask slurm to email me alerts for this task.
$ srun --mail-user=student@msoe.edu --mail-type=BEGIN,END,FAIL hostname

# Ask slurm for an interactive session on a teaching node.  (**Interactive sessions should only be used on the teaching nodes**)
$ srun --pty --partition=teaching bash
```

The `hostname` command prints the current node's hostname. The compute nodes in the teaching partition are selected by default.

The `nvidia-smi` command prints out GPU information.

You can issue any command to srun, e.g. `python train.py`, `./program.out`, `shell_script.sh`. Srun will launch the task on a compute node.

### GPU Resource Allocation

```bash
# One T4 GPU
$ srun --gres=gpu:t4:1 --partition=teaching nvidia-smi

# One T4 GPU in an interactive session (**Interactive sessions should only be used on the teaching nodes**)
$ srun --gres=gpu:t4:1 --partition=teaching --pty bash

# Two T4 gpus, partition is optional
$ srun --gres=gpu:t4:2 nvidia-smi


# DGX-1 Deep Learning Parition
# Allocate just one gpu,
$ srun --partition=dgx --gres=gpu:v100:1 nvidia-smi
# or all 8!
$ srun --partition=dgx --gres=gpu:v100:8 nvidia-smi
```

For example, to launch a machine learing python training file with one t4 gpu, you can issue

```bash
$ srun --partition=teaching --gres=gpu:t4:1 python ~/network_code/train.py
```

### Running Singularity Images

```bash
# queue up a script in a ubuntu singularity container
$ srun --partition=teaching singularity exec -B /data:/data /data/containers/msoe-tensorflow.sif cat /etc/os-release

# high performance compute node with two tesla T4 gpu
$ srun --partition=teaching --gres=gpu:t4:2 --cpus-per-gpu=8 singularity exec --nv -B /data:/data /data/containers/msoe-tensorflow.sif nvidia-smi
```

The `--nv` flag auto mounts NVIDIA gpu resources to the singularity container. You can build singularity containers from any image on the Nvidia gpu cloud.

## SRUN Help Reference

Execute `man srun` for more detail.

```bash
sysadmin@dh-mgmt1:~$ srun --help
Usage: srun [OPTIONS...] executable [args...]

Parallel run options:
  -A, --account=name          charge job to specified account
      --acctg-freq=<datatype>=<interval> accounting and profiling sampling
                              intervals. Supported datatypes:
                              task=<interval> energy=<interval>
                              network=<interval> filesystem=<interval>
      --bb=<spec>             burst buffer specifications
      --bbf=<file_name>       burst buffer specification file
      --bcast=<dest_path>     Copy executable file to compute nodes
  -b, --begin=time            defer job until HH:MM MM/DD/YY
  -c, --cpus-per-task=ncpus   number of cpus required per task
      --checkpoint=time       job step checkpoint interval
      --comment=name          arbitrary comment
      --compress[=library]    data compression library used with --bcast
      --cpu-freq=min[-max[:gov]] requested cpu frequency (and governor)
  -d, --dependency=type:jobid defer job until condition on jobid is satisfied
      --deadline=time         remove the job if no ending possible before
                              this deadline (start > (deadline - time[-min]))
      --delay-boot=mins       delay boot for desired node features
  -D, --chdir=path            change remote current working directory
      --export=env_vars|NONE  environment variables passed to launcher with
                              optional values or NONE (pass no variables)
  -e, --error=err             location of stderr redirection
      --epilog=program        run "program" after launching job step
  -E, --preserve-env          env vars for node and task counts override
                              command-line flags
      --gres=list             required generic resources
      --gres-flags=opts       flags related to GRES management
  -H, --hold                  submit job in held state
  -i, --input=in              location of stdin redirection
  -I, --immediate[=secs]      exit if resources not available in "secs"
      --jobid=id              run under already allocated job
  -J, --job-name=jobname      name of job
  -k, --no-kill               do not kill job on node failure
  -K, --kill-on-bad-exit      kill the job if any task terminates with a
                              non-zero exit code
  -l, --label                 prepend task number to lines of stdout/err
  -L, --licenses=names        required license, comma separated
  -M, --clusters=names        Comma separated list of clusters to issue
                              commands to.  Default is current cluster.
                              Name of 'all' will submit to run on all clusters.
                              NOTE: SlurmDBD must up.
  -m, --distribution=type     distribution method for processes to nodes
                              (type = block|cyclic|arbitrary)
      --mail-type=type        notify on state change: BEGIN, END, FAIL or ALL
      --mail-user=user        who to send email notification for job state
                              changes
      --mcs-label=mcs         mcs label if mcs plugin mcs/group is used
      --mpi=type              type of MPI being used
      --multi-prog            if set the program name specified is the
                              configuration specification for multiple programs
  -n, --ntasks=ntasks         number of tasks to run
      --nice[=value]          decrease scheduling priority by value
      --ntasks-per-node=n     number of tasks to invoke on each node
  -N, --nodes=N               number of nodes on which to run (N = min[-max])
  -o, --output=out            location of stdout redirection
  -O, --overcommit            overcommit resources
      --pack-group=value      pack job allocation(s) in which to launch
                              application
  -p, --partition=partition   partition requested
      --power=flags           power management options
      --priority=value        set the priority of the job to value
      --prolog=program        run "program" before launching job step
      --profile=value         enable acct_gather_profile for detailed data
                              value is all or none or any combination of
                              energy, lustre, network or task
      --propagate[=rlimits]   propagate all [or specific list of] rlimits
      --pty                   run task zero in pseudo terminal
      --quit-on-interrupt     quit on single Ctrl-C
  -q, --qos=qos               quality of service
  -Q, --quiet                 quiet mode (suppress informational messages)
      --reboot                reboot block before starting job
  -r, --relative=n            run job step relative to node n of allocation
      --restart-dir=dir       directory of checkpoint image files to restart
                              from
  -s, --oversubscribe         over-subscribe resources with other jobs
  -S, --core-spec=cores       count of reserved cores
      --signal=[B:]num[@time] send signal when time limit within time seconds
      --slurmd-debug=level    slurmd debug level
      --spread-job            spread job across as many nodes as possible
      --switches=max-switches{@max-time-to-wait}
                              Optimum switches and max time to wait for optimum
      --task-epilog=program   run "program" after launching task
      --task-prolog=program   run "program" before launching task
      --thread-spec=threads   count of reserved threads
  -T, --threads=threads       set srun launch fanout
  -t, --time=minutes          time limit
      --time-min=minutes      minimum time limit (if distinct)
  -u, --unbuffered            do not line-buffer stdout/err
      --use-min-nodes         if a range of node counts is given, prefer the
                              smaller count
  -v, --verbose               verbose mode (multiple -v's increase verbosity)
  -W, --wait=sec              seconds to wait after first task exits
                              before killing job
      --wckey=wckey           wckey to run job under
  -X, --disable-status        Disable Ctrl-C status feature

Constraint options:
      --cluster-constraint=list specify a list of cluster-constraints
      --contiguous            demand a contiguous range of nodes
  -C, --constraint=list       specify a list of constraints
      --mem=MB                minimum amount of real memory
      --mincpus=n             minimum number of logical processors (threads)
                              per node
      --reservation=name      allocate resources from named reservation
      --tmp=MB                minimum amount of temporary disk
  -w, --nodelist=hosts...     request a specific list of hosts
  -x, --exclude=hosts...      exclude a specific list of hosts
  -Z, --no-allocate           don't allocate nodes (must supply -w)

Consumable resources related options:
      --exclusive[=user]      allocate nodes in exclusive mode when
                              cpu consumable resource is enabled
                              or don't share CPUs for job steps
      --exclusive[=mcs]       allocate nodes in exclusive mode when
                              cpu consumable resource is enabled
                              and mcs plugin is enabled
                              or don't share CPUs for job steps
      --mem-per-cpu=MB        maximum amount of real memory per allocated
                              cpu required by the job.
                              --mem >= --mem-per-cpu if --mem is specified.
      --resv-ports            reserve communication ports

Affinity/Multi-core options: (when the task/affinity plugin is enabled)
  -B, --extra-node-info=S[:C[:T]]           Expands to:
      --sockets-per-node=S    number of sockets per node to allocate
      --cores-per-socket=C    number of cores per socket to allocate
      --threads-per-core=T    number of threads per core to allocate
                              each field can be 'min' or wildcard '*'
                              total cpus requested = (N x S x C x T)

      --ntasks-per-core=n     number of tasks to invoke on each core
      --ntasks-per-socket=n   number of tasks to invoke on each socket
      --cpu-bind=             Bind tasks to CPUs
                              (see "--cpu-bind=help" for options)
      --hint=                 Bind tasks according to application hints
                              (see "--hint=help" for options)
      --mem-bind=             Bind memory to locality domains (ldom)
                              (see "--mem-bind=help" for options)

GPU scheduling options:
      --cpus-per-gpu=n        number of CPUs required per allocated GPU
  -G, --gpus=n                count of GPUs required for the job
      --gpu-bind=...          task to gpu binding options
      --gpu-freq=...          frequency and voltage of GPUs
      --gpus-per-node=n       number of GPUs required per allocated node
      --gpus-per-socket=n     number of GPUs required per allocated socket
      --gpus-per-task=n       number of GPUs required per spawned task
      --mem-per-gpu=n         real memory required per allocated GPU

Help options:
  -h, --help                  show this help message
      --usage                 display brief usage message

Other options:
  -V, --version               output version information and exit
```
