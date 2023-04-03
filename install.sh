#!/usr/bin/env bash

set -e

sudo add-apt-repository ppa:ubuntu-toolchain-r/test
sudo apt-get update -y && sudo apt-get install libc6 -y
sudo apt install make -y && sudo apt-get install build-essential -y
sudo apt-get install libssl-dev zlib1g-dev -y
sudo apt-get install luarocks && luasocket -y
sudo curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
sudo chmod 700 get_helm.sh
sudo ./get_helm.sh