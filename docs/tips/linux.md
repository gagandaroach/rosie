## Commands

Some good to know linux commands. Try these on your ROSIE terminal connection.

**ls**

View the contents of the current directory. prints files and folders.

`ls -l` view in a list.

`ls -la` view hidden files as well

`ls -lah` convert bytes to clear MB or GB measurements (**h**uman readable)


**pwd**

Print the folder path location of the current working directory.

**man**

view the manual pages of a command

`man ls` view the manual pages for ls
`man man` view the manual pages for man

**whereis**

find the location of a executable or program

```bash
sysadmin@dh-mgmt2:/data$ whereis ssh
ssh: /usr/bin/ssh /etc/ssh /usr/share/man/man1/ssh.1.gz
sysadmin@dh-mgmt2:/data$ whereis ls
ls: /bin/ls /usr/share/man/man1/ls.1.gz
```

**cd**

change directory

**cp**

copy a file or group of files. type `cp --help` for more information.

`cp sourcefile.txt copyfile.txt` copy a file

`cp -r data_folder new_folder` copy a folder

**rm**

remove (delete) a file or folder.

`rm sourcefile.txt` remove a file

`rm -rf useless_folder` remove a folder

## Process Management

When you execute a process in the terminal, control of the computer is halted until the process completes.

`Ctrl+C` will send an interupt signal to the current process.

`Ctrl+Z` will pause the process and put it in the background.

`bg` in the terminal will resume tasks in the background.

`fg` in the terminal will bring tasks back to the foreground.

`&`. Including an appresand at the end of a terminal command will send it to the background and start it immediately. e.g. `python data_convert.py&`.

`disown` will deattach a background process from the current terminal session, creating a zombie process. This will continue to execute until it complets or is killed.
