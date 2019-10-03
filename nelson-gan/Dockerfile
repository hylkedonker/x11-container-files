FROM jupyter/tensorflow-notebook:1386e2046833

USER root

RUN apt-get update && \
    apt-get install -qq -y --no-install-recommends \
    curl=7.58.0-2ubuntu3.8
RUN pip install ipdb==0.12.2

USER jovyan
WORKDIR /home/jovyan/work

RUN git clone https://github.com/ChengBinJin/WGAN-TensorFlow.git
# Enfore reproducibily by checking out one particular revision. The hash below
# points to the latest revision on Oct 2nd 2019.
RUN cd WGAN-TensorFlow; \
    git reset --hard d6699079327ff30dbefad07fd6f8796951ea06cd
