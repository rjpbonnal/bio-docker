# INGM Bioinformatics
#
# DESCRIPTION DeNovoHuman Installation of RSEM
# VERSION             1.2.26
# CREATION 2016-01-25


FROM ubuntu:14.04

MAINTAINER Raoul Jean Pierre Bonnal <ilpuccio.febo@gmail.com>

#Source https://github.com/ContinuumIO/docker-images/blob/master/anaconda/Dockerfile#L10

RUN apt-get update --fix-missing && apt-get install -y wget bzip2 ca-certificates build-essential checkinstall zlib1g-dev libncurses5-dev
   
RUN wget https://github.com/deweylab/RSEM/archive/v1.2.26.tar.gz && \
    tar xzvf v1.2.26.tar.gz && \
    cd RSEM-1.2.26 && \
    make && \
    cd .. && \
    mv RSEM-1.2.26 /opt/

ENV PATH /opt/bowtie2-2.2.6:/opt/RSEM-1.2.26:$PATH

# http://bugs.python.org/issue19846
# > At the moment, setting "LANG=C" on a Linux system *fundamentally breaks Python 3*, and that's not OK.
ENV LANG C.UTF-8

CMD [ "/bin/bash" ]
