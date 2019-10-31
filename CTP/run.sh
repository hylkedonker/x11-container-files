# Run minimal CTP container "local/ctp" (without X11 support).

# Arguments received by this script are passed to `docker run`.
if [ ! -z "$1" ]; then
    job="$@"
else
    # By default, start container "local/ctp" and run CTP daemon.
    job=("local/ctp" "java" "-jar" "Runner.jar")
fi

# Files to be processed by CTP (will be mounted in Docker contained read only).
if [ -z "${import_folder}" ]; then
    echo "No import folder specified (\$import_folder is not set)!"
    exit 1
fi

# - Forward CTP port.
# - Mount files to process in container.
docker run -ti --rm \
    -p 1080:1080 \
    -v "${import_folder}:/mnt/import_root:ro" \
    ${job[@]}
