# ghost-ipfs-node

## GhostCloud IPFS node description

GhostCloud is a project that aggregates a number of services, such as GhostDrive, GhostVPN etc.
It is based on the cutting-edge technologies and contains IPFS, SHA3, GUN, Web 3.0, etc. under the hood.
GhostCloud incorporates a private IPFS network and the purpose of this repository is to automate and
simplify the process of node setup in GhostCloud private IPFS network for everyone.

Currently, we fully support only installation in Docker and partially installation on a Linux machine (RHEL,CentOS,Debian,Ubuntu).
We plan to fully automate a Linux install and add support for Windows and macOS. 

## Table of Contents

- [System Requirements](#system-requirements)
- [Install in Docker](#docker)
- [Install on Linux](#linux)
- [Install on macOS](#macos)
- [Install on Windows](#windows)
- [Updating go-ipfs](#updating-ipfs-on-your-ghost-node)

### System Requirements

IPFS requires 512MiB of memory and can run an IPFS node on a Raspberry Pi. 
However, how much disk space your IPFS installation takes up depends on how much data you're sharing. 
A base installation takes up about 12MB of disk space, and the default maximum disk storage is set to 10GB.
IPFS can run on most Linux, macOS, and Windows systems. We recommend running it on a machine with at least 2 GB of RAM and 2 CPU cores (go-ipfs is highly parallel). 
On systems with less memory, it may not be completely stable.
We also highly recommend running it on an SSD, preferably on Gen4 NVMe SSD of any vendor.

If your system is resource-constrained, we recommend initializing your daemon with `ipfs init --profile=lowpower`.
For this, you'll need to replace the line 7 of `setup.sh` with the command above.

### Docker

The precompiled docker image is available for download at https://hub.docker.com/r/ghost/ghost-ipfs-node

Alternatively, if you wish to manually build the Docker file, simply run:

```
docker build -t ghost-ipfs-node .
```

To run the image (this can be ran *n* times to create *n* peers for the GhostCloud IPFS network):
```
docker run -d \
           -e SWARM_KEY="998a147a3b541d7567c0a242783fe27ee12af7e6b49a657bf11527107a9b5bc5" \
           -e BOOTSTRAP_NODE_IP="54.158.26.205" \
           -e BOOTSTRAP_NODE_PEER_ID="12D3KooWFzbkTCyFXfnA1eToqPh1QuAYjhvMaL69yYQ5ZFLxmZcF" \
           ghost/ghost-ipfs-node
```

The `SWARM_KEY` given above is GhostCloud swarm key. The `BOOTSTRAP_NODE_IP` is the public IP address
of GhostCloud bootstrap node (master). The `BOOTSTRAP_NODE_PEER_ID` is the peer id of GhostCloud bootstrap node.

### Linux

...

### macOS

...

### Windows

...

### Updating ipfs on your ghost node

#### Using ipfs-update

IPFS has an updating tool that can be accessed through `ipfs update`. The tool is
not installed alongside IPFS in order to keep that logic independent of the main
codebase. To install `ipfs update`, [download it here](https://ipfs.io/ipns/dist.ipfs.io/#ipfs-update).

#### Downloading IPFS builds using IPFS

List the available versions of go-ipfs:

```
$ ipfs cat /ipns/dist.ipfs.io/go-ipfs/versions
```

Then, to view available builds for a version from the previous command ($VERSION):

```
$ ipfs ls /ipns/dist.ipfs.io/go-ipfs/$VERSION
```

To download a given build of a version:

```
$ ipfs get /ipns/dist.ipfs.io/go-ipfs/$VERSION/go-ipfs_$VERSION_darwin-386.tar.gz # darwin 32-bit build
$ ipfs get /ipns/dist.ipfs.io/go-ipfs/$VERSION/go-ipfs_$VERSION_darwin-amd64.tar.gz # darwin 64-bit build
$ ipfs get /ipns/dist.ipfs.io/go-ipfs/$VERSION/go-ipfs_$VERSION_freebsd-amd64.tar.gz # freebsd 64-bit build
$ ipfs get /ipns/dist.ipfs.io/go-ipfs/$VERSION/go-ipfs_$VERSION_linux-386.tar.gz # linux 32-bit build
$ ipfs get /ipns/dist.ipfs.io/go-ipfs/$VERSION/go-ipfs_$VERSION_linux-amd64.tar.gz # linux 64-bit build
$ ipfs get /ipns/dist.ipfs.io/go-ipfs/$VERSION/go-ipfs_$VERSION_linux-arm.tar.gz # linux arm build
$ ipfs get /ipns/dist.ipfs.io/go-ipfs/$VERSION/go-ipfs_$VERSION_windows-amd64.zip # windows 64-bit build
```
