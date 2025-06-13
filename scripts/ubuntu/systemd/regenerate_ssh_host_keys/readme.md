# Regenerate ssh keys service
The service will run before `ssh.service` starts. It will generate keys using `ssh-keygen`, but first it will remove any ssh keys on the system, generate new ones and then finally disable itself to stop the service from overwriting the generated keys on boot.

> **NOTE**
> This method is recommended for templates that do not use `cloud-init`.

## Setup
### Give the file root ownership
```shell
sudo chown root:root regenerate_ssh_host_keys.service
```
### Add to system files
```shell
sudo mv regenerate_ssh_host_keys.service /etc/systemd/system/
```
### Tell systemd about our service
```shell
sudo systemctl daemon-reload
```
### Enable our service
Our service should be loaded but not enabled, you can see this with the command below. 
```shell
systemctl status regenerate_ssh_host_keys.service
```
Now enable the service
```shell
sudo systemctl enable regenerate_ssh_host_keys.service
```