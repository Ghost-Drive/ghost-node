#!/bin/sh

echo "/key/swarm/psk/1.0.0/" >> /data/ipfs/swarm.key
echo "/base16/" >> /data/ipfs/swarm.key
echo $SWARM_KEY >> /data/ipfs/swarm.key

ipfs init
ipfs bootstrap rm --all
ipfs daemon