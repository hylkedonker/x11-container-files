#!/bin/bash
docker run -ti \
    --privileged \
    -u $(id -u):$(id -g) \
    -v /home/donkerhc/workspace/nelson-gan:/home/jovyan/work:Z \
    local/hylke-wgan bash
