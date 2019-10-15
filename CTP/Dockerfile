FROM ubuntu:19.04
ENV DEBIAN_FRONTEND=noninteractive

# Tag packages by versions to prevent Dockerfile from ever breaking.
RUN apt-get update && \
    apt-get install -qq -y --no-install-recommends \
    sudo=1.8.27-1ubuntu1 \
    xterm=330-1ubuntu3 \
    xauth=1:1.0.10-1 \
    less=487-0.1build1 \
    wget=1.20.1-1ubuntu4 \
    default-jdk=2:1.11-71

RUN apt-get clean

# The correct user and password id's are needed to authenticate with X11.
RUN groupadd -g 10412 donkerhc
RUN useradd -u 10412 -g 10412 -c "Hylke Donker" donkerhc
RUN usermod -p 'x' donkerhc
RUN chsh -s /bin/zsh donkerhc
RUN mkdir -p /home/donkerhc/tmp
RUN chown -R donkerhc /home/donkerhc

# Download an unzipped CTP installation.
ARG commit_hash=614eadd4d008399781ee6201a0c1e4a8583766ab
RUN wget https://github.com/hylkedonker/x11-container-files/raw/${commit_hash}/CTP/ctp.tar.gz
# Extract the installation in /JavaPrograms
RUN mkdir -p /JavaPrograms
RUN cd /JavaPrograms && tar -xzf /ctp.tar.gz

RUN chown -R donkerhc /JavaPrograms

RUN echo "donkerhc ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

USER donkerhc
WORKDIR /JavaPrograms/CTP
CMD java -jar Runner.jar