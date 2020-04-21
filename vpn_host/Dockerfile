FROM ubuntu:latest
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update
RUN apt-get upgrade -y

RUN apt-get install vim vpnc ssh -y

COPY default.conf  /etc/vpnc/default.conf
COPY ssh_config /root/.ssh/config

ENTRYPOINT [ "bash" ]
