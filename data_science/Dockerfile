FROM jupyter/datascience-notebook:1386e2046833

ENV DEBIAN_FRONTEND=noninteractive

USER root

# Tag packages by versions to prevent Dockerfile from ever breaking.
RUN apt-get update && \
    apt-get install -qq -y --no-install-recommends \
    xauth=1:1.0.10-1 \
    xterm \
    less=487-0.1 \
    zsh=5.4.2-3ubuntu3.1 \
    graphviz=2.40.1-2 \
    mysql-client==5.7.30-0ubuntu0.18.04.1

RUN apt-get clean

# Install python packages.
RUN pip install ipdb==0.12.2 \
    pyreadstat==0.2.9 \
    xgboost==0.90 \
    graphviz==0.13 \
    imbalanced-learn==0.5.0 \
    gensim==3.8.1 \
    category_encoders==2.1.0 \
    catboost==0.22 \
    mlinsights==0.2.360 \
    openpyxl==3.0.2 \
    pydicom==1.4.2 \
    lxml==4.5.1 \
    openpyxl==3.0.3 \
    html5lib==1.0.1 \
    xlrd==1.2.0

# The correct user and password id's are needed to authenticate with X11.
RUN groupadd nobody
# RUN groupadd -g 10412 donkerhc
# RUN useradd -u 10412 -g 10412 -c "Hylke Donker" donkerhc
# RUN usermod -p 'x' donkerhc
# RUN chsh -s /usr/bin/zsh donkerhc
RUN mkdir -p /home/nelson
# RUN chown -R donkerhc /home/donkerhc

RUN mkdir -p /var/opt/thinlinc

USER donkerhc
WORKDIR /home/donkerhc
