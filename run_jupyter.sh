#!/bin/bash
# Run 
#docker run -ti \
docker run -d \
    -p 8888:8888 \
    -v $HOME/nelson:$HOME/../nelson:ro \
    -v $HOME/workspace/jupyter:$HOME \
    --rm \
    --user root \
    -e NB_UID=$(id -u) \
    -e NB_GID=$(id -g) \
    -e NB_USER=$(id -un) \
    -e NB_GROUP=$(id -gn) \
    local/hylke_data \
    start-notebook.sh \
    --NotebookApp.token=''
    $@
