FROM ubuntu:19.04
ENV DEBIAN_FRONTEND=noninteractive

# Tag packages by versions to prevent Dockerfile from ever breaking.
RUN apt-get update && \
    apt-get install -qq -y --no-install-recommends \
    xterm=330-1ubuntu3 \
    xauth=1:1.0.10-1 \
    less=487-0.1build1 \
    zsh=5.5.1-1ubuntu3 \
    chromium-browser=76.0.3809.100-0ubuntu0.19.04.1

RUN apt-get clean

# The correct user and password id's are needed to authenticate with X11.
RUN groupadd -g 10412 donkerhc
RUN useradd -u 10412 -g 10412 -c "Hylke Donker" donkerhc
RUN usermod -p 'x' donkerhc
RUN chsh -s /bin/zsh donkerhc
RUN mkdir -p /home/donkerhc/tmp
RUN chown -R donkerhc /home/donkerhc

RUN groupadd -g 10412 donkerhc
RUN useradd -u 10412 -g 10412 -c "Hylke Donker" donkerhc
RUN usermod -p 'x' donkerhc
RUN chsh -s /bin/bash donkerhc
RUN mkdir -p /home/donkerhc/tmp
RUN chown -R donkerhc /home/donkerhc


RUN mkdir -p /var/opt/thinlinc

USER donkerhc
WORKDIR /home/donkerhc
CMD /usr/bin/xterm
