# CTP container
Two [CTP](https://mircwiki.rsna.org/index.php?title=MIRC_CTP) Dockerfiles (with and without X11 support) with a simple pipeline to anonimise DICOM data and send it to an XNAT instance.

## Configuration
In `Makefile` adjust the variables:
```Makefile
XNAT_IP_ADDRESS
XNAT_PROJECT_ID
```

## Minimal
```bash
export import_folder=/path/to/DICOM/folder/
make minimal
# Start CTP.
./run.sh
```

## X11
The `Dockerfile.x11` contains additional configuration to forward X11 out of the container. In this way, you can run the graphical installer. Currently, this is configured to use my account only. You need to manually adjust `Dockerfile.x11` to match the username (inlcuding user id and group id) with that on your machine.
```bash
# TODO: Configure Dockerfile.x11 to match your user configuration.
make x11
# Start CTP.
./run_x11.sh
# Or launch installer.. (state of the container is not preserved after shutdown).
./run_x11.sh local/ctp.x11 java -jar Launcher.jar
```
