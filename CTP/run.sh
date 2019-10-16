if [ ! -z "$1" ]; then
    job="$@"
else
    job=("local/ctp" "java" "-jar" "Runner.jar")
fi

import_folder="/== NELSON UMCG ==/NELSON-UMCG-00262"
docker run -ti --rm \
    -p 1080:1080 \
    -v "$HOME/nelson${import_folder}:/mnt/import_root:ro" \
    -u $(id -u):$(id -g) \
    --privileged \
    ${job[@]}
