> [!ATTENTION]
> After Nov 30 2020 this page is deprecated. The campus account management system has been synced with the cluster. To log in, see the [access guide](access.md).

EECS and ROSIE use a separate account management system than the campus network. To request an account, contact the EECS department or the ROSIE SysAdmin.

You will be given a username and a one time password (OTP). **Note: You must log in via shell to reset the OTP before you can use the web portal.**

## Steps <!-- {docsify-ignore-all} -->

![Account Activation Example](_images/ex_activate_steps.png)

1. Use **ssh** to connect to a head management node.
   
Launch your terminal program and input the command (replacing username with your own):

```shell
$ ssh username@dh-mgmt2.hpc.msoe.edu
```

See the [Network Access page](access.md) for details on preparing an ssh client.

2. The system will prompt for your one time password. Input this to proceed.

3. Re-enter your one time password to begin the password change process.

4. Input your desired password. It is critical to follow healthy password protocol here - the more complicated the more secure.

5. Verify your password by typing it in again.

After inputting your new password twice, the system will permit entry into the management node. You can now close this connecting or explore command line interface with the cluster. You can visit the web portal and login with your username and new password.