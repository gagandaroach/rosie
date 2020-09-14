## Campus Network

The cluster is only accessible on the campus network. If you are connecting from a building on campus, you are likely already attached to the campus network.

To access ROSIE off campus, you must first connect to the MSOE VPN. You will log into the VPN with your campus credentials (@msoe.edu address).

### Vpn Clients

On **Windows** or **Mac**, you can download the GlobalProtect client from [vpn.msoe.edu](vpn.msoe.edu).

On **Linux**, a popular option is to use [openconnect](https://www.infradead.org/openconnect/index.html). Many distributions include openconnect with their default package manager. After you install openconnect, in your terminal execute: `sudo openconnect --protocol=gp vpn.msoe.edu`. 

## Shell Access

Users can directly connect to the management nodes and open a command line interface.

Connect with **ssh**.

```
    $ ssh username@dh-mgmt2.hpc.msoe.edu
```

**Windows** does not include ssh by default. An easy way to get the ssh program is to download and install [GIT](https://git-scm.com/). The included git bash terminal program has a ssh command. Another popular option is to use [PuTTY](https://www.putty.org/).

## Web Browser Access

Users can use their web browser to interact with the computer cluster and schedule jobs.

[ROSIE Web Portal link](https://dh-ood.hpc.msoe.edu)