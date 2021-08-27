The interactive app is a full suite visual studio code server running on a compute node in the cluster. Users can create and edit projects, install extensions from the large vscode community, open multiple folders, debug processes, launch terminals, and more.

**Interactive App Screenshot**

![Example](../_images/code_example.png)

**Launching the App**

![Interactive App](../_images/code_form.png)

The launch code server page allows a user to select their starting working folder, number of t4 gpus, and a time to hold the resources.

## Python

To enable VSCode's python language features, install the ms-python package in the vscode extension bar.

### Selecting Conda Environment

VSCode's Python extension allows you to select between user managed conda environments. To change the current working environment, select the Python label in the bottom task bar. Then in the popup window, choose the interpreter you wish to use.

![Opening Choose](../_images/code_select_python.png)
![Choose Window](../_images/code_view_python.png)

### Running Debugger

The screenshot below exemplifies running the debugger on the current python file.

![RunDebugger](../_images/code_run_debug.png)

## Keyboard Shortcuts

VSCode has a number of helpful keyboard shortcuts to help with development.

To open the terminal, `ctrl+~`.

To open the file search bar, `ctrl+p`.

To open the command search bar, input `>` into the file search bar. From here, you can search for any command and see its keyboard shortcut. For example, search for `>move` to see the move line commands.