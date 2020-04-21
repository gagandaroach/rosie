#!/bin/bash

START_SCRIPT="THIS SCRIPT WILL START A DOCKER CONTAINER WITH VPN ABILITY TO CONNECT TO MSOE NETWORK WITH CREDS"

echo $START_SCRIPT

echo ">>>> STOPPING OLD CONTAINER"

docker stop vpn_host
docker rm vpn_host

echo ">>>> BUILDING CONTAINER"
docker build . -t vpn_host

echo ">>>> STARTING NEW CONTAINER"

docker run -it --name vpn_host --cap-add NET_ADMIN vpn_host