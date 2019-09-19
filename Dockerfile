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

RUN groupadd -g 10412 donkerhc
RUN useradd -u 10412 -g 10412 -c "Hylke Donker" donkerhc
RUN usermod -p 'x' donkerhc
RUN mkdir -p -m 0755 /etc/sudoers.d
RUN echo 'donkerhc ALL=NOPASSWD: ALL' > /etc/sudoers.d/noauto-donkerhc
RUN chmod 0600 /etc/sudoers.d/noauto-donkerhc
RUN chsh -s /bin/bash donkerhc
RUN mkdir -p /home/donkerhc/tmp
RUN chown -R donkerhc /home/donkerhc

RUN groupadd -g 10462 muntingh
RUN useradd -u 10462 -g 10462 -c "Gerhard Muntingh" muntingh
RUN usermod -p 'x' muntingh
RUN mkdir -p -m 0755 /etc/sudoers.d
RUN echo 'muntingh ALL=NOPASSWD: ALL' > /etc/sudoers.d/noauto-muntingh
RUN chmod 0600 /etc/sudoers.d/noauto-muntingh
RUN chsh -s /bin/bash muntingh
RUN mkdir -p /home/muntingh/tmp
RUN chown -R muntingh /home/muntingh


RUN mkdir -p /var/opt/thinlinc


USER donkerhc
ENV HOME /home/donkerhc
WORKDIR /home/donkerhc
CMD /usr/bin/xterm
