# Prepare target env
CONTAINER_DISPLAY="0"
CONTAINER_HOSTNAME="x11_container"

# Create a directory for the socket
mkdir -p display/socket
touch display/Xauthority

# Get the DISPLAY slot
DISPLAY_NUMBER=$(echo $DISPLAY | cut -d. -f1 | cut -d: -f2)
export DISPLAY=:${DISPLAY_NUMBER}
AUTH_COOKIE=$(xauth list | grep "^$(hostname)/unix:${DISPLAY_NUMBER} " | awk '{print $3}')

DISPLAY_NUMBER=$(echo $DISPLAY | cut -d. -f1 | cut -d: -f2)

# Extract current authentication cookie
AUTH_COOKIE=$(xauth list | grep "^$(hostname)/unix:${DISPLAY_NUMBER} " \
    | awk '{print $3}')

# Create the new X Authority file
xauth -f display/Xauthority \
    add ${CONTAINER_HOSTNAME}/unix:${CONTAINER_DISPLAY} \
    MIT-MAGIC-COOKIE-1 ${AUTH_COOKIE}

# Proxy with the :0 DISPLAY
socat TCP4:localhost:60${DISPLAY_NUMBER} \
    UNIX-LISTEN:display/socket/X${CONTAINER_DISPLAY} &

docker run -ti --rm \
    -e DISPLAY=:${CONTAINER_DISPLAY} \
    -v ${PWD}/display/socket:/tmp/.X11-unix \
    -v ${PWD}/display/Xauthority:$HOME/.Xauthority \
    --hostname ${CONTAINER_HOSTNAME} \
    --cap-add=SYS_PTRACE \
    -u $(id -u):$(id -g) \
    --privileged local/hylke \
    xterm
#sudo /usr/bin/docker run -ti --rm --cap-add=SYS_PTRACE -e DISPLAY=$DISPLAY -u $(id -u):$(id -g) -v /tmp/.X11-unix:/tmp/.X11-unix  --privileged local/hylke xterm
# docker run -ti --rm local/hylke \
#     /bin/bash
