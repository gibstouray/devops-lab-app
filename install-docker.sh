#!/bin/bash
  sudo apt-get update -y
  sudo apt-get install -y docker.io
  sudo usermod -aG docker ${USER}
  sudo systemctl start docker
  sudo systemctl enable docker
  sudo su - ${USER}
  sudo apt install -y docker-compose

  # install curl
  sudo apt install -y curl
