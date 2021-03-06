# Prepare target env
CONTAINER_DISPLAY="0"
CONTAINER_HOSTNAME="x11_container"

# Create a directory for the socket, removing previous sessions if necessary.
rm -rf display
mkdir -p display/socket
touch display/Xauthority

# Get the DISPLAY slot
DISPLAY_NUMBER=$(echo $DISPLAY \
    | cut -d. -f1 \
    | cut -d: -f2)
export DISPLAY=:${DISPLAY_NUMBER}

# Extract current authentication cookie
AUTH_COOKIE=$(xauth list \
    | grep "^$(hostname)/unix:${DISPLAY_NUMBER} " \
    | awk '{print $3}')

# Create the new X Authority file
xauth -f display/Xauthority \
    add ${CONTAINER_HOSTNAME}/unix:${CONTAINER_DISPLAY} \
    MIT-MAGIC-COOKIE-1 ${AUTH_COOKIE}

socat UNIX-LISTEN:display/socket/X${CONTAINER_DISPLAY},fork \
    TCP4:localhost:60${DISPLAY_NUMBER} &

if [ ! -z "$1" ]; then
    job="$@"
else
    job=("local/hylke" "chromium-browser" "-v")
fi

docker run -ti --rm \
    -e DISPLAY=:${CONTAINER_DISPLAY} \
    -v ${PWD}/display/socket:/tmp/.X11-unix \
    -v "${PWD}/display/Xauthority:$HOME/.Xauthority" \
    --hostname ${CONTAINER_HOSTNAME} \
    --cap-add=SYS_PTRACE \
    -u $(id -u):$(id -g) \
    --group-add nobody \
    --privileged \
    ${job[@]}
