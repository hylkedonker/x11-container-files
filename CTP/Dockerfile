FROM ubuntu:19.04
ENV DEBIAN_FRONTEND=noninteractive

# Configure CTP.
ARG XNAT_IP_ADDRESS=localhost
ARG XNAT_PROJECT_ID=1234
ARG SCRIPT_PATH=/JavaPrograms/CTP/scripts
ARG CONTAINER_USER=ctpuser

# Tag packages by versions to prevent Dockerfile from ever breaking.
RUN apt-get update && \
    apt-get install -qq -y --no-install-recommends \
    less=487-0.1build1 \
    wget=1.20.1-1ubuntu4 \
    dcmtk=3.6.4-2 \
    default-jdk=2:1.11-71

RUN apt-get clean

# Download an unzipped CTP installation (the CTP installer requires X11, which
# we can't run in a Dockerfile).
ARG commit_hash=614eadd4d008399781ee6201a0c1e4a8583766ab
RUN wget https://github.com/hylkedonker/x11-container-files/raw/${commit_hash}/CTP/ctp.tar.gz
# Extract the installation in /JavaPrograms
RUN mkdir -p /JavaPrograms
RUN cd /JavaPrograms && tar -xzf /ctp.tar.gz

RUN useradd ${CONTAINER_USER}
RUN chown -R ${CONTAINER_USER} /JavaPrograms

# Mass import data from this location (to be mounted in this location by `docker
# run`).
RUN mkdir /mnt/import_root
ARG IMPORT_FOLDER=/mnt/import_root

# 1) Copy configuration files.
COPY configsnippet.xml \
    PROJECTTriplet.script \
    merge_snippet.sh \
    ./
RUN chmod +x merge_snippet.sh
COPY PROJECTNAMEPsuedo.script "${SCRIPT_PATH}/${XNAT_PROJECT_ID}Psuedo.script"

# 2) Configure files.
# Generate snippet based on XNAT ip and project id.
RUN cat configsnippet.xml | sed \
    -e "s/\[XNAT_IP_ADDRESS\]/${XNAT_IP_ADDRESS}/g" \
    -e "s/PROJECT/${XNAT_PROJECT_ID}/g" \
    -e 's|treeRoot=\".\+\"|treeRoot=\"'${IMPORT_FOLDER}'\"|' \
    > /tmp/configsnippet.xml

# Insert configuration snippet in config.xml.
RUN ./merge_snippet.sh "/tmp/configsnippet.xml" "/JavaPrograms/CTP/config.xml" \
    > /tmp/config.xml
RUN mv /tmp/config.xml /JavaPrograms/CTP/config.xml
RUN cat PROJECTTriplet.script | sed -e "s/PROJECT/${XNAT_PROJECT_ID}/g" \
    > "${SCRIPT_PATH}/${XNAT_PROJECT_ID}Triplet.script"

USER ${CONTAINER_USER}
WORKDIR /JavaPrograms/CTP
CMD java -jar Runner.jar