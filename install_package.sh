#!/bin/bash





echo "Installing $1"

sudo apt-get update
sudo apt-get install $1 -y

echo "installing completed"



