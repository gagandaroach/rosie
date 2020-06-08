#!/bin/bash
# This script connects to MSOE VPN. Uses linux openconnect client.
# Connect using MSOE Active Directory username and password.
sudo openconnect --protocol=gp -g MSOE sslvpn.msoe.edu
