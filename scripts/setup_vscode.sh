#!/bin/bash

# Required packages for VS Code to work
apt-get update
apt install software-properties-common apt-transport-https wget -y
wget -q https://packages.microsoft.com/keys/microsoft.asc -O- | apt-key add -
add-apt-repository "deb [arch=arm64] https://packages.microsoft.com/repos/vscode stable main"
apt install code net-tools -y