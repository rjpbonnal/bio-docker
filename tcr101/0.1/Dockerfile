FROM ubuntu:14.04

MAINTAINER Raoul Jean Pierre Bonnal <ilpuccio.febo@gmail.com>

#Source https://github.com/ContinuumIO/docker-images/blob/master/anaconda/Dockerfile#L10

RUN apt-get update --fix-missing && apt-get install -y wget bzip2 ca-certificates \
    libglib2.0-0 libxext6 libsm6 libxrender1 \
    git mercurial subversion
RUN echo 'export PATH=/opt/conda/bin:$PATH' > /etc/profile.d/conda.sh && \
    wget --quiet https://repo.continuum.io/archive/Anaconda2-2.4.1-Linux-x86_64.sh && \
    /bin/bash /Anaconda2-2.4.1-Linux-x86_64.sh -b -p /opt/conda && \
    rm /Anaconda2-2.4.1-Linux-x86_64.sh

RUN apt-get install -y curl grep sed dpkg && \
    TINI_VERSION=`curl https://github.com/krallin/tini/releases/latest | grep -o "/v.*\"" | sed 's:^..\(.*\).$:\1:'` && \
    curl -L "https://github.com/krallin/tini/releases/download/v${TINI_VERSION}/tini_${TINI_VERSION}.deb" > tini.deb && \
    dpkg -i tini.deb && \
    rm tini.deb && \
    apt-get clean

RUN apt-get install -y unzip

RUN wget -O bowtie2-2.2.6-linux-x86_64.zip "http://downloads.sourceforge.net/project/bowtie-bio/bowtie2/2.2.6/bowtie2-2.2.6-linux-x86_64.zip?r=http%3A%2F%2Fsourceforge.net%2Fprojects%2Fbowtie-bio%2Ffiles%2Fbowtie2%2F2.2.6%2F&ts=1453458192&use_mirror=netcologne" && \
   unzip bowtie2-2.2.6-linux-x86_64.zip && \
   mv bowtie2-2.2.6 /opt/


RUN apt-get install -y build-essential checkinstall zlib1g-dev

RUN apt-get install -y 	libncurses5-dev
   
RUN wget https://github.com/deweylab/RSEM/archive/v1.2.26.tar.gz && \
    tar xzvf v1.2.26.tar.gz && \
    cd RSEM-1.2.26 && \
    make && \
    cd .. && \
    mv RSEM-1.2.26 /opt/

RUN /opt/conda/bin/conda install -y pysam biopython

ADD tcr101.tar.gz /opt/ 

RUN cd /opt/tcr101 && \
    sed -i -e '1s:#! /usr/bin/python:#!/usr/bin/env python:' trapes.py

ENV PATH /opt/conda/bin:/opt/bowtie2-2.2.6:/opt/RSEM-1.2.26:/opt/tcr101:$PATH
ENV PYTHONPATH /opt/conda/pkgs

# http://bugs.python.org/issue19846
# > At the moment, setting "LANG=C" on a Linux system *fundamentally breaks Python 3*, and that's not OK.
ENV LANG C.UTF-8

ENTRYPOINT [ "/usr/bin/tini", "--" ]
CMD [ "/bin/bash" ]
