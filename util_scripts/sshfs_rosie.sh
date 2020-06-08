#!/bin/bash
# This script will use the linux program sshfs to bind mount ROSIE folders onto your machine.
ROSIE_USERNAME=daroachg
LOCAL_ROSIE_MOUNTPOINT=/srv/rosie
sshfs -o allow_other $ROSIE_USERNAME@dh-mgmt1.hpc.msoe.edu:/data $LOCAL_ROSIE_MOUNTPOINT/data
sshfs -o allow_other $ROSIE_USERNAME@dh-mgmt1.hpc.msoe.edu:/home/$ROSIE_USERNAME $LOCAL_ROSIE_MOUNTPOINT/$ROSIE_USERNAME