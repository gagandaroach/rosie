# VSCODE Remote Development Using SSH <!-- {docsify-ignore-all} -->

The Visual Studio Code Remote - SSH extension allows you to open a remote folder on any remote machine, virtual machine, or container with a running SSH server and take full advantage of VS Code's feature set. Once connected to a server, you can interact with files and folders anywhere on the remote filesystem.

No source code needs to be on your local machine to gain these benefits since the extension runs commands and other extensions directly on the remote machine.

![Vscode Example](../_images/vscode_example.PNG)

## Install Instructions

Follow the official install documentation here: https://code.visualstudio.com/docs/remote/ssh.

To configure the Vscode remote ssh host, input your username and the second mgmt node as the hostname. e.g. `<username>@ad.msoe.edu@dh-mgmt4.hpc.msoe.edu`

![Vscode SSH Config](../_images/vscode_ssh_connect.png)

## VSCode SSH ProxyJump

To connect directly to an allocated compute node, use the ssh proxyjump directive to connect to the mgmt node and proxy through to the compute node. This will enable IDE debugging execution on a compute node (with a gpu!)

**Microsoft ProxyCommand setup blogpost**

https://code.visualstudio.com/blogs/2019/10/03/remote-ssh-tips-and-tricks#_proxycommand