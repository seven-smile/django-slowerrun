#!/bin/bash

set -e

export DEBIAN_FRONTEND=noninteractive


# CLONE THE REPO
PROJECT_BASE_PATH = '/src/local/apps/django-slowererrun'
PROJECT_GIT_URL = 'https://github.com/seven-smile/django-slowerrun.git'

git clone $PROJECT_GIT_URL $PROJECT_BASE_PATH

cd $PROJECT_BASE_PATH

PORT=7777
NAME="${PWD##*/}"

# Add Docker's official GPG key:
sudo apt-get update
sudo apt-get install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources: 
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update

sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

sudo docker run hello-world

sudo docker build -t ${PWD##*/} ./

sudo docker run -d -p 80:$PORT --name $NAME $NAME