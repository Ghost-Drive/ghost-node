#!/bin/bash

# Exit immediately if a command exits with a non-zero status.

set -e

#Variables

OS=$(uname -s)
USER=$(whoami)
SWARM_KEY='998a147a3b541d7567c0a242783fe27ee12af7e6b49a657bf11527107a9b5bc5'
BOOTSTRAP_NODE_IP='54.158.26.205'
BOOTSTRAP_NODE_PEER_ID='12D3KooWFzbkTCyFXfnA1eToqPh1QuAYjhvMaL69yYQ5ZFLxmZcF'

#Functions
command_exists() {
	command -v "$@" > /dev/null 2>&1
}

is_wsl() {
	case "$(uname -r)" in
	*microsoft* ) true ;; # WSL 2
	*Microsoft* ) true ;; # WSL 1
	* ) false;;
	esac
}

is_darwin() {
	case "$(uname -s)" in
	*darwin* ) true ;;
	*Darwin* ) true ;;
	* ) false;;
	esac
}

docker_install () {
  echo "Docker is not detected. Installing Docker..."
  curl -fsSL https://get.docker.com -o get-docker.sh
  sudo bash ./get-docker.sh
}

#Check that script is run on a supported system

if [ "${OS}" = "Linux" ] || is_darwin || is_wsl; then
  true && echo "OS checks done..."
else
 echo "You are not running a supported OS. Aborting execution."
 exit 0
fi

#Check if Docker is already installed and install it if not

if command_exists docker && [ -e /var/run/docker.sock ]; then
  true && echo "Docker is already installed, skipping Docker install..."
else
  trap docker_install EXIT
fi

#GhostCloud IPFS node spawn

echo "Setting up GhostCloud IPFS node in a Docker container..."

DOCKER_NAME=$(hostname)
read -n 30 -rpe "Enter your node name: " input
DOCKER_NAME="${input:-$DOCKER_NAME}"

if [[ "${DOCKER_NAME}" =~ [^A-Za-z0-9._-] ]]; then
  echo "That name is NOT allowed."
  exit 0
else
  true
fi

while true; do
  read -rpe "Do you confirm?" yn
    case $yn in
        [Yy]* ) true; break;;
        [Nn]* ) exit;;
        * ) echo "Please answer yes or no.";;
    esac
done

docker run --name "$DOCKER_NAME" -d \
    -p 4001:4001 -p 5001:5001 -p 8888:8080 \
    -v "$(pwd)"/data/ipfs:/data/ipfs/ \
    -e SWARM_KEY=$SWARM_KEY \
    -e BOOTSTRAP_NODE_IP=$BOOTSTRAP_NODE_IP \
    -e BOOTSTRAP_NODE_PEER_ID=$BOOTSTRAP_NODE_PEER_ID \
    ghostdriveprotocol/ghost-ipfs-gen4-node

CONTAINER_ID=$(docker ps -a | grep ghost-ipfs-gen4-node | awk '{print$1}')
IMAGE_ID=$(docker ps -a | grep ghost-ipfs-gen4-node | awk '{print$2}')
echo "OUTPUTS:"
echo "Container ID: $CONTAINER_ID"
echo "Image ID: $IMAGE_ID"
echo "Peer ID: $(docker exec -i "$CONTAINER_ID" sh -c "ipfs config show | grep 'PeerID' | cut -d ':' -f2")"
