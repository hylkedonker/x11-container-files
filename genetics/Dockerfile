FROM ubuntu:19.04
ENV DEBIAN_FRONTEND=noninteractive

# Tag packages by versions to prevent Dockerfile from ever breaking.
RUN apt-get update && \
    apt-get install -qq -y --no-install-recommends \
    xterm=330-1ubuntu3 \
    xauth=1:1.0.10-1 \
    less=487-0.1build1 \
    sudo=1.8.27-1ubuntu1 \
    samtools=1.9-4 \
    bcftools=1.9-1 \
    bedtools=2.27.1+dfsg-4 \
    zsh=5.5.1-1ubuntu3

RUN apt-get clean

# The correct user and password id's are needed to authenticate with X11.
RUN groupadd -g 10412 donkerhc
RUN useradd -u 10412 -g 10412 -c "Hylke Donker" donkerhc
RUN usermod -p 'x' donkerhc
RUN chsh -s /bin/zsh donkerhc
RUN mkdir -p /home/donkerhc/tmp
RUN chown -R donkerhc /home/donkerhc

RUN mkdir -p /var/opt/thinlinc
RUN echo "donkerhc ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

USER donkerhc
WORKDIR /home/donkerhc
CMD /usr/bin/xterm
