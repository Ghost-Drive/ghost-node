#!/bin/sh

echo "/key/swarm/psk/1.0.0/" >> /data/ipfs/swarm.key
echo "/base16/" >> /data/ipfs/swarm.key
echo $SWARM_KEY >> /data/ipfs/swarm.key

ipfs init
ipfs bootstrap rm --all
ipfs bootstrap add /ip4/$BOOTSTRAP_NODE_IP/tcp/4001/ipfs/$BOOTSTRAP_NODE_PEER_ID
export LIBP2P_FORCE_PNET=1
ipfs config Addresses.Gateway /ip4/0.0.0.0/tcp/8080
ipfs config Addresses.API /ip4/0.0.0.0/tcp/8080
ipfs daemon