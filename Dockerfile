FROM gitpod/workspace-full

RUN sudo apt-get update && sudo apt-get purge -y \
         docker-ce \
         docker-ce-cli \
         containerd.io && \
    sudo apt-get install -y \
         docker-ce=5:19.03.15~3-0~ubuntu-focal \
         docker-ce-cli=5:19.03.15~3-0~ubuntu-focal && \
    sudo apt-get clean && sudo rm -rf /var/lib/apt/lists/* && \
    sudo curl -fsSL -o /usr/bin/runc https://github.com/opencontainers/runc/releases/download/v1.0.0-rc93/runc.amd64
