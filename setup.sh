#!/bin/bash

set -e

export DEBIAN_FRONTEND=noninteractive

PORT=1717
NAME="${PWD##*/}"

# Add Docker's official GPG key:
sudo apt-get update
DEBIAN_FRONTEND=noninteractive sudo apt-get install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources: 
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update

DEBIAN_FRONTEND=noninteractive sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

sudo docker run hello-world

sudo docker build -t ${PWD##*/} ./

sudo docker run -d -p 80:$PORT --name $NAME $NAME