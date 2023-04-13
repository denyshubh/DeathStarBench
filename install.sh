#!/usr/bin/env bash

set -e

sudo add-apt-repository ppa:ubuntu-toolchain-r/test
sudo apt-get update -y && sudo apt-get install libc6 -y
sudo apt install make -y && sudo apt-get install build-essential -y
sudo apt-get install libssl-dev zlib1g-dev -y
sudo apt-get install luarocks
sudo luarocks install luasocket
