#!/bin/bash
# Run 
docker run -ti \
    -p 8888:8888 \
    -v $HOME/workspace/jupyter:/home/jovyan/work \
    -e NB_UID=$(id -u) \
    local/hylke_data \
    jupyter notebook
     #    $@
#    --user root \
