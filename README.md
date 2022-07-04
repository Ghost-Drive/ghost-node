# ghost-ipfs-gen4-node

## P2P Network Description (GXD)

GhostDrive provides a robust solution for secure data storage through the implementation of encryption and network verification protocols. The network publicly verifies the encryption, transmission, receipt, and storage of data without ever being granted access to the data itself through zero-knowledge verification (zk-Starks) and full end-to-end encryption.

GXD is a project that aggregates a number of services, such as GhostDrive, GhostVPN etc.
It is based on the cutting-edge technologies and contains IPFS, SHA3, GUN, Web 3.0, etc. under the hood.
GXD Network incorporates a private IPFS network and the purpose of this repository is to automate and
simplify the process of node setup in GhostCloud private IPFS network for everyone. 
As this is a private network, you will always use the same `SWARM_KEY` and there is no need for NAT Forwarding of TCP/UDP ports to each node behind a firewall since all nodes spawned simply register with our bootstrap node to allow incoming traffic to the node.

Currently, we fully support only installation in Docker and partially installation on a Linux machine (RHEL,CentOS,Debian,Ubuntu).
We plan to fully automate a Linux install and add support for Windows and macOS. 

## Table of Contents

- [System Requirements](#system-requirements)
- [Install in Docker](#docker)
- [Install on Linux](#linux)
- [Install on macOS](#macos)
- [Install on Windows](#windows)
- [Rewards](#rewards)
- [Updating go-ipfs](#updating-ipfs-on-your-ghost-node)
- [Notes](#notes)

### System Requirements

IPFS requires 512MiB of memory and can run an IPFS node on a Raspberry Pi. 
However, how much disk space your IPFS installation takes up depends on how much data you're sharing. 
A base installation takes up about 12MB of disk space, and the default maximum disk storage is set to 10GB.
IPFS can run on most Linux, macOS, and Windows systems. We recommend running it on a machine with at least 2 GB of RAM and 2 CPU cores (go-ipfs is highly parallel). 
On systems with less memory, it may not be completely stable.
We also highly recommend running it on an SSD, preferably on Gen4 NVMe SSD of any vendor.

If your system is resource-constrained, we recommend initializing your daemon with `ipfs init --profile=lowpower`.
For this, you'll need to replace the line 7 of `setup.sh` with the command above.

#### Recommended system specifications

• CPU
    12 cores / 24 threads, or more, 2.8GHz, or faster
    AVX2 instruction support (to use official release binaries, self-compile otherwise)
    Support for AVX512f and/or SHA-NI instructions is helpful
    The AMD Zen3 series is popular with the validator community

• RAM
    128GB, or more

• Motherboard with 256GB capacity suggested

• Disk
    PCIe Gen4 NVME SSD
    Accounts: 500GB, or larger. High TBW (Total Bytes Written)
    Ledger: 64TB or larger. High TBW suggested

• OS: (Optional) 10GB, or larger. SATA OK
    The Samsung 970 and 980 Pro series SSDs are popular with the validator community

• GPUs
    Not strictly necessary at this time
    Motherboard and power supply speed to add one or more high-end GPUs in the future suggested

### Docker

```
bash <(curl -s https://raw.githubusercontent.com/Ghost-Drive/ghost-node/main/get-gxd-docker.sh)
```
OR
```
bash <(wget -qO -  https://raw.githubusercontent.com/Ghost-Drive/ghost-node/main/get-gxd-docker.sh)
```
You will be prompted for a node name in the middle of a setup process. 
Thus, you can run the script *n* times to launch *n* nodes.

A precompiled docker image is available for download at https://hub.docker.com/r/ghost/ghost-ipfs-node

Alternatively, if you wish to manually build the Docker file, clone the project and simply run:

```
docker build -t ghost-ipfs-gen4-node ./docker
```

### Linux

...

### MacOS

...

### Windows

...

### Rewards

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

#### Notes

1. As IPFS default WebUI is shipped via the public IPFS network, it is not available out-of-the-box in our GhostCloud private IPFS network.
   If you need to use it, it can be separately installed from the https://github.com/ipfs/ipfs-webui
   
   
   

   
  ### GXD Master Node requirements
  
  Typical 4-node NVM + GPU installation
- Rack 24U 1x
- Supermicro 2U GPU Lines server 4x 
- Intel Xeon LGA-4189 16-core processor 4x 
- NVMe SSD 4Tb Gen 3/4 2.5” hot swap drive 16x 
- GPU PNY NVIDIA A40 48GB – 4x
- HPE FlexNetwork 5130 HI Switch Series 1x 
- Accessories
