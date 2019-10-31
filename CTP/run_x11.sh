# Run CTP container "local/ctp" with X11 support.
#
# Set up unix socket to transfer X11 communication through the Docker container.
#
# N.B.: requires correct configuration of username and password in the
# Dockerfile.

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

# Create the new X Authority file, which we will mount in the container.
xauth -f display/Xauthority \
    add ${CONTAINER_HOSTNAME}/unix:${CONTAINER_DISPLAY} \
    MIT-MAGIC-COOKIE-1 ${AUTH_COOKIE}

socat UNIX-LISTEN:display/socket/X${CONTAINER_DISPLAY},fork \
    TCP4:localhost:60${DISPLAY_NUMBER} &

# Arguments received by this script are passed to `docker run`.
if [ ! -z "$1" ]; then
    job="$@"
else
    # By default, start container "local/ctp" and run CTP daemon.
    job=("local/ctp.x11" "java" "-jar" "Runner.jar")
fi

# Files to be processed by CTP (will be mounted in Docker contained read only).
import_folder="$HOME/nelson/== NELSON UMCG ==/NELSON-UMCG-00262"

# - Forward CTP port.
# - Mount files to process in container.
# - Configure X11 display and mount X11 files.
# - Set up hostname and user in container.
docker run -ti --rm \
    -p 1080:1080 \
    -v "${import_folder}:/mnt/import_root:ro" \
    -e DISPLAY=:${CONTAINER_DISPLAY} \
    -v ${PWD}/display/socket:/tmp/.X11-unix \
    -v "${PWD}/display/Xauthority:$HOME/.Xauthority" \
    --hostname ${CONTAINER_HOSTNAME} \
    -u $(id -u):$(id -g) \
    --privileged \
    ${job[@]}
