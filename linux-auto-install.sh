#!/bin/bash

# Exit immediately if a command exits with a non-zero status.

set -e

OS=$(uname -s)
SWARM_KEY='998a147a3b541d7567c0a242783fe27ee12af7e6b49a657bf11527107a9b5bc5'
BOOTSTRAP_NODE_IP='20.0.0.234'
BOOTSTRAP_NODE_PEER_ID='12D3KooWFzbkTCyFXfnA1eToqPh1QuAYjhvMaL69yYQ5ZFLxmZcF'
USERNAME=$(whoami)

#Check that script is run on Linux

if [ "${OS}" = "Linux" ]; then true
else echo "You are not running Linux...Aborting execution"; exit 0
fi

#Check Linux distro and perform update

if uname -a | grep 'Debian\|Ubuntu'; then
  sudo apt update -y && sudo apt upgrade -y
  elif [ -f /etc/redhat-release ]; then
    sudo yum update -y && sudo yum upgrade -y
else
  echo "Unknown Linux distro...Exiting now"; exit 0
fi

echo 'Installing Go...'

if go version; then
  wget https://dl.google.com/go/go1.18.2.linux-amd64.tar.gz
  rm -rf /usr/local/go && tar -C /usr/local -xzf go1.18.2.linux-amd64.tar.gz
else
  wget https://dl.google.com/go/go1.18.2.linux-amd64.tar.gz
  tar -C /usr/local -xzf go1.18.2.linux-amd64.tar.gz
fi

sudo mkdir $HOME/gopath
echo 'export GOROOT=/usr/local/go' >> $HOME/.bashrc
echo 'export GOPATH=$HOME/gopath' >> $HOME/.bashrc
echo 'export PATH=$PATH:$GOROOT/bin:$GOPATH/bin' >> $HOME/.bashrc
source ~/.bashrc

echo 'Go installed successfully'

echo 'Installing IPFS...'

wget https://dist.ipfs.io/go-ipfs/v0.12.1/go-ipfs_v0.12.1_linux-amd64.tar.gz
tar xzf go-ipfs_v0.12.1_linux-amd64.tar.gz
sudo sh ./go-ipfs/install.sh
IPFS_PATH=~/.ipfs
ipfs init --profile server

echo 'IPFS installed successfully'

echo 'Adding swarm key...'

touch ~/.ipfs/swarm.key
echo "/key/swarm/psk/1.0.0/" >> ~/.ipfs/swarm.key
echo "/base16/" >> ~/.ipfs/swarm.key
echo $SWARM_KEY >> ~/.ipfs/swarm.key

echo 'Swarm key added'

echo 'Bootstrapping node...'

ipfs bootstrap rm --all
ipfs bootstrap add /ip4/${BOOTSTRAP_NODE_IP}/tcp/4001/ipfs/${BOOTSTRAP_NODE_PEER_ID}
export LIBP2P_FORCE_PNET=1
ipfs config Addresses.Gateway /ip4/0.0.0.0/tcp/8080
ipfs config Addresses.API /ip4/0.0.0.0/tcp/8080

echo 'Node bootstrapped'

echo 'Configuring systemd autostart...'

sed -i "s+User=$+User=${USERNAME}+g" ipfs.service
mv ipfs.service /etc/systemd/system/
sudo systemctl daemon-reload
sudo systemctl enable ipfs
sudo systemctl start ipfs



