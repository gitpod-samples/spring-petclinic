FROM gitpod/workspace-full

RUN sudo curl -fL https://app.getambassador.io/download/tel2/linux/amd64/latest/telepresence -o /usr/local/bin/telepresence
RUN sudo chmod a+x /usr/local/bin/telepresence

