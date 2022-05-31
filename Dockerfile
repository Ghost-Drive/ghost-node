FROM ipfs/go-ipfs

# The setup.sh script is used to setup GhostCloud private IPFS and replaces the default start_ipfs
# file provided by the ipfs/go-ipfs image
COPY setup.sh /usr/local/bin/start_ipfs
RUN chmod 0755 /usr/local/bin/start_ipfs

# Enforce GhostCloud private network settings
ENV LIBP2P_FORCE_PNET 1

# The entrypoint (i.e. script.sh) will setup swarm.key, init IPFS, remove all public
# bootstrap values and start the ipfs daemon
ENTRYPOINT ["/usr/local/bin/start_ipfs"]