FROM ubuntu:14.04

RUN apt-get update && \
    apt-get install -qq -y --no-install-recommends \
    python-pip \
    ipython \
    gcc \
    git

RUN apt-get install -qq -y --no-install-recommends \
    python-matplotlib \
    python-pandas \
    python-scikits-learn \
    python-ipdb \
    python-tk

RUN apt-get clean

RUN pip install -U "setuptools==3.4.1"
RUN pip install -U "pip==1.5.4"

RUN mkdir /pydeep
WORKDIR /pydeep
RUN groupadd donkerhc
RUN useradd -g donkerhc donkerhc
RUN chown -R donkerhc:donkerhc /pydeep
RUN git clone https://github.com/MelJan/PyDeep.git
