# INGM Bioinformatics
#
# DESCRIPTION: VDJFasta
# VERSION               0.0.1
# CREATED 2015-02-17

FROM      ubuntu:14.04
MAINTAINER Raoul J.P. Bonnal <ilpuccio.febo@gmail.com>

RUN apt-get update --fix-missing && apt-get install -y wget build-essential lib32z1-dev software-properties-common

RUN apt-get update --fix-missing && apt-get install -y ncbi-blast+

#RUN apt-get update --fix-missing && apt-get install -y inotify-tools nano wget links curl rsync bc git git-core apt-transport-https gawk autoconf automake libtool bison make m4 git build-essential software-properties-common ncbi-blast+

#ADD http://eddylab.org/software/hmmer3/3.1b2/hmmer-3.1b2-linux-intel-x86_64.tar.gz /opt/

COPY hmmer-3.1b2-linux-intel-x86_64.tar.gz /opt/

RUN cd /opt &&\
    tar xzvf hmmer-3.1b2-linux-intel-x86_64.tar.gz &&\
    cd hmmer-3.1b2-linux-intel-x86_64 &&\
    ./configure &&\
    make &&\
    make check &&\
    make install

ADD vdjfasta-tcr.tar.gz /opt/

RUN mkdir -p /opt/data

COPY Han-Glanville-2014-example-data.tgz /opt/data/

RUN apt-get update --fix-missing && apt-get install -y parallel

COPY test.sh /opt/vdjfasta-tcr/bin/

RUN chmod +x /opt/vdjfasta-tcr/bin/test.sh && \
    chmod a+w /opt/data

ENV PATH /opt/vdjfasta-tcr/bin:$PATH

ENV SHELL /bin/bash
